Return-Path: <cgroups+bounces-1214-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF6B8387E6
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 08:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EEFB23166
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 07:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B734451C5F;
	Tue, 23 Jan 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLCP9WaA"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35A79DB;
	Tue, 23 Jan 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705994524; cv=fail; b=MwavB6s5FV6eDuaHKdVETGBt9P4gCjtjXk+2Yztugm1mgkaLTrcYPhS0nBqnYf9fz87L87zKw5F2i/JdYaNmFST9GN0mO7Ws+I0ytmIJx3/X/5BwuPs0uHzmue3XaleIjbJhEUMdAuXXNvn6yULAMK/4tadiFtFmAyc/MoeumuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705994524; c=relaxed/simple;
	bh=/UMKyLFK1irJYMeeu+EjmKiwkYoTZ4vhWeIxF1ow0/M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E2M2CDVhauRE2KzT+dw6bPuv52Q39tgWqmvijZdi0skHYK5r8QUR0iFYFLuzmkJrGnqEMZ/P7shh52mY+bOE+lHO04inOM2vkjekCNbErBaBUkcxFCfe9ShN2Tmq4yL2N0Ucf4IoHgfDjtIBwhovLOkqyV/pbTu96ZW3TPGREAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLCP9WaA; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705994522; x=1737530522;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/UMKyLFK1irJYMeeu+EjmKiwkYoTZ4vhWeIxF1ow0/M=;
  b=cLCP9WaAsb8rFPah6WgK2Wqk4MjTEywLSOhaEpoXEN2brrm5HrCt+8zc
   4QmaGNqrYLbfvmoojLz83kIg0dwb2gDvUCFOy/oQ+eHvUGo8d1BNQ5wX2
   N6uPIZzHX/p5Ihk2Nf6PCIXAB9q2yt71nRzhmPJ4fBnNt683rqnIH8icK
   iCnuC5fWIXfzyNVGjsu1Pf2XJ4IcYj6HaAXHcIKInZUbm+9VFrt/JA4EQ
   zlJ+1q0h9GoPy045iQeMLGX6cfABS2v8J122W8X0CZYAEXkSaJVfMl6UW
   BCTDS0xqWaVcdLzFWM6yYA3lucJAzawem86cGPF9tjkXgutl9NlBS/z7P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8806734"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="8806734"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 23:22:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1443840"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 23:22:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 23:21:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 23:21:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 23:21:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 23:21:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzAPI2L4TmH3pB8vQ+6MriZK4dzas662TYYIK7OYHR8qYUNAcKivsCrzo0V0Gs1UQ1CbOWQGH/FI7z0qekLeJqS3ipwxh4Pdxx7Z0oqA+la+hKEqk7ZDmC0p984RNrnYDrgyR8/iRa33PkBjuGCinSH/EoYjJqiKQ8Ff3nyBX/ZUGSGCxTK3QRQ806uisECHs+lqlgQtQ1c2eZLvlPrkcrE6IC+LQEC9FR5R5DeUGxT4l/jf4lkf2w0yYj1jFMNA4ys1C3k8dfMI2jN1RJZ/UjgVvyaT69X/2eQtT91sGz3yV9eoyHZxOLdX3v8jkbbHzc3t3+TUj2LrLUuvyJxv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNDek/eiLKPHcJiFNUtnrIIYRo1oJB7aVdUQrnlO5Pc=;
 b=QQC1EstKgZCnnyVaNtRJ0H53QWHg/vcyg//n6A2VRX1bp7Eo2g1+8QK+abSXGU8denrtSqVLQj2MBE7Gahp/Duo3GF6S1UEWjslkX6WS6cRZyr7vyf0F7bAGt0CPIGViLQO/qktg/CRbV5q+gT0U1XvRMqYGNueruF3X0u19lRZ3b0YrUYcofCOr+KjRB4ss3LtDl1j1GP6v3SJMdSAxeE4Y7R9nk4OjNdmNCQwJoyWxpm+leRSboNb/RTe6BfF/5mTrgSeRykEXbIfhFys50R++jTpR3lmNV4+evK5KUF3oW5IXInASTx35RUNjf5+8i071JUfaNgdgrUBS5QSQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 07:21:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 07:21:56 +0000
Date: Tue, 23 Jan 2024 15:21:43 +0800
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
Message-ID: <Za9pB928KjSORPw+@xsang-OptiPlex-9020>
References: <202401221624.cb53a8ca-oliver.sang@intel.com>
 <CAJD7tka0o+jn3UkXB+ZfZvRw1v+KysJbaGQvJdHcSmAhYC5TQA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka0o+jn3UkXB+ZfZvRw1v+KysJbaGQvJdHcSmAhYC5TQA@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 067e2ff2-9c2c-4321-5e41-08dc1be3faf3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Tfq5+tY56rEjE4B+CxjyceO9wXwDAlUZPV9EwS8FNH7zCphvcKwdC4OXw5MBtf10jdrSaeMLUeDWU8E9adVlxkNuoxNUBNlndJKvKPK5CkFNu/FSekFUOnS2hY2wlOFFWz21wm/wRGbNsR3tiPQo3oSXSyw3CEEjPBoejyNOjod77hAha9r2RTDFyvlzMZgjPD17bJKaa7GqovUzv+AGWAJkGEIDRO1ZPuUDwmJ1QmwbLqchww9N634Q1AzlFJluOrFVWRod1LvdtZMjtmfOiuvh5apPD9QzOquxGvOR9xVNxmQCx47xVOnuRJ4X2S74jR5tnNZBJP5RzLsW9FI3u+t80GqJUGac6kEhBXAiVpfMfuGYkBtZRH8rBsWDGMmQMmroCTkvyXlCBaCPaKyE8W0HnLNbnOFRDbJpjumM3One54AmWSMpeh9hETdsQh7+L1IRJ1kjIwhR8RDOCZZrS956+AmhkY7Ti1smP3vwX06NJJAoPwf51EkVQToBfMgO2TEOVSJlnqQoGcvCDrfIZ0sSRUO8gn3LsmOEOMlSrElyujVwiMmInFr8JP9rre/v7mTMko0SfxJVNuXf7V5Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(478600001)(41300700001)(33716001)(86362001)(38100700002)(83380400001)(82960400001)(5660300002)(9686003)(6506007)(8936002)(316002)(4326008)(6512007)(8676002)(966005)(6486002)(66476007)(7416002)(6916009)(26005)(66556008)(66946007)(2906002)(107886003)(54906003)(53546011)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9PVFV3eUE4czJyM1orWnVaNk5pa200REpJczkvMm9ZSzJNQzE4OHlvM2Nz?=
 =?utf-8?B?VTZMVTBWUUN5S3hubVFxUnN6ZDkxczFMZ3ZKYS9PYjE5czFtM1lFdXlVeHFa?=
 =?utf-8?B?dUhrQ25KQkw0Zkw2aGs4WWl5R2tKMURWcHEyd0hJRDIxa3JkajlXOHdHd1Ur?=
 =?utf-8?B?eExmTm5YczhpZEhYRGUxWXZQVVdSeGZqaGZLZ3Z1Q2lwYWFWRTlxZHBqUk8z?=
 =?utf-8?B?R0tzU0cwSU82aVREV0FjTmlEYmdxMzVmV2d1WUFCWW9tNDYrVjUvYmEybFZJ?=
 =?utf-8?B?VWhoT1daNzN1YXY1Ujl4NTNSWkQ5d1lSeS9VWTVSQk9wRnQ1NXNnZ0lKUmUz?=
 =?utf-8?B?ZDRSL3U1aWRtaEcybjJ1STd2OVZjRmpBOS9MZThKQk44SjZ1QzNCVzVrU0tz?=
 =?utf-8?B?YmM5UXFDOFJlWksvR0NteEkvMTRKSy9vc1R1MEdOcVF4NnJ6QzY3U2VlNEtq?=
 =?utf-8?B?d2E5MVZ5R2g4TEdLYlozRUI3SlB1SWNXNUY0YW4ycmtnRER1eDB5clpnZTZi?=
 =?utf-8?B?aVhJTTVpK2FsZlQrY0JEWThUR1pjVm5rTU9EQkIxRjh1Z0g2dVlqUHprSWYx?=
 =?utf-8?B?NC95aDQwSXpBNUVUOUJMSlFNRWFmR2V3TnRrS2c2K1kzRmJUTEU3dU16V1k0?=
 =?utf-8?B?eWwrSUZ4SHBxVzRqT1lDNGRFOTJFejIzeHJ0WEZ3ZVJ2eTdvai9YVmtwV1A3?=
 =?utf-8?B?NzlYOE5hb0taT2UzdmFrQzNwWEZPS09UL241T3dQZE4zMnFsUFl1bHRiL2w1?=
 =?utf-8?B?elZTNjkxWFpWOW5ZcnNyNHMvUVBXYUxhcERpci9sckZhSUJWdlprd25QVDVZ?=
 =?utf-8?B?UlgxVmQyR21FS05QOUFPa1FLVEFrZEJyZ0dJTWdBc3BaR1h1NGo0OGNWSXdT?=
 =?utf-8?B?a3c1UE5sUVNOclZ1UGZVMnc5aFJLcnBxTTd2WUI5RDlEYUIyZHkyL2w1ZFZi?=
 =?utf-8?B?YzZhWjhpNTJGck41WjRJdnJPTXVQd0xOTDd1c1hFQjB0ajBhNlptUDBsazc3?=
 =?utf-8?B?a3FsUDJCL0RPYm16d0FnQkN1RHhKUmRkdlRIV2VreHNKUUhaUURPbVQvTFVy?=
 =?utf-8?B?ekQ1YXVQaVBORGp3QlN1N3pydUoxSHRWbDY5Q1JWNkVKR0ZIUER1ZmM2U29W?=
 =?utf-8?B?c2xCeWNOZzFnaVV5dGlGWDBNcVVXMFp4eFpIRStoaVZLMEU4Q2dSZStMTFJL?=
 =?utf-8?B?WnB1bDFzVFVGd0JRRlRBRXk1bjczLytZZjRJTytGMkpyVStJZ2pKSzRpQTNZ?=
 =?utf-8?B?YXJnNFQ5MjdBUExOT3pvS1MzQk52NTBnZS9BZzhVdER4VnBOTnZ2TWpSUk1P?=
 =?utf-8?B?MVBORmtpcURzcVpDRzFBbkpmUWhQRUc2dnYzSXA2dHlkaGVrTVp4Y0RLVndW?=
 =?utf-8?B?Z3ZDdTlNajF5TzdKSWEzcjFwdzdRVzR2U1I5bCtaOEFFYmY2aDM4VjJBaWpZ?=
 =?utf-8?B?ZjBFK1RJVEVNbHZjd0JwSlZIaXF4SFE0c1Ywa0hFL0hMbmhTYjY5dDh1OTBn?=
 =?utf-8?B?M0pvOURLcHVSU1c3NlVVaHFLL00rY3l3UkNhaVVuYTF6Z21XdDA3bjlwdFpE?=
 =?utf-8?B?a09KRDRvT3kzOS82L3dFak02c09KSU5VRmJpdjRPdUROQjZYd2c1SEU0Z2Yz?=
 =?utf-8?B?YnhZQVFaMzdMY1lrRVFUUHhIZUVSay9HRG8zbU1EOFArbnZHMFFBelF1Y1R4?=
 =?utf-8?B?TUFVMWZRK3ljRzdsOStCbnhsaUVQb2t3QUV1eTVjbCtxcml5UWFIa0JFUGtT?=
 =?utf-8?B?V2Z6bEhPZGIzdGtDTDFEbm4yeDhvUVVBNUJmV2VJQkdGUVJ1QXZRQW9leksr?=
 =?utf-8?B?aVpqdlFJMndnRTdSbDYvTlRieElMTmloclBTTTBDSVJRWjRvazc4VnNJTGlp?=
 =?utf-8?B?aGJKOEswRFFZWmxZR2FrZ0d4VDgrNjg2TzlaRFdxempmOFZFMzR1UUdLNlJX?=
 =?utf-8?B?UHFtTStKeittTi9NQVg0RWYzN3RXUW1GUDF5amNHTGdyczFGVHhlcTZuV0VG?=
 =?utf-8?B?WDNaSmpoTVF6eCtwT1F6N1VIamdWTC9WdUpLTmNoMm5tcXlVTHBVcmhpQjBX?=
 =?utf-8?B?RHUwK2d0N1Q2NTc0L1Q4em15RTNEZUIvUWVTNklmaU9QdjBUVk9FOTFneXhX?=
 =?utf-8?B?NDdneGJtWDJ0a3I0T0d4dHkzK2ppRWlSUWVaWGFDT0dUOHk1ditFY3JRTU5C?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 067e2ff2-9c2c-4321-5e41-08dc1be3faf3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 07:21:56.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMkT+PsHwffSrv9nsnHLhaCeSdTZLPuvp62/314GMvxvonRvef+AqJPh2l/RBSxRejYLDmiHtDylVsbsNV4YhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com

hi, Yosry Ahmed,

On Mon, Jan 22, 2024 at 01:39:19PM -0800, Yosry Ahmed wrote:
> On Mon, Jan 22, 2024 at 12:39 AM kernel test robot
> <oliver.sang@intel.com> wrote:
> >
> >
> >
> > hi, Yosry Ahmed,
> >
> > per your suggestion in
> > https://lore.kernel.org/all/CAJD7tkameJBrJQxRj+ibKL6-yd-i0wyoyv2cgZdh3ZepA1p7wA@mail.gmail.com/
> > "I think it would be useful to know if there are
> > regressions/improvements in other microbenchmarks, at least to
> > investigate whether they represent real regressions."
> >
> > we still report below two regressions to you just FYI what we observed in our
> > microbenchmark tests.
> > (we still captured will-it-scale::fallocate regression but ignore here per
> > your commit message)
> >
> >
> > Hello,
> >
> > kernel test robot noticed a -36.6% regression of vm-scalability.throughput on:
> >
> >
> > commit: 8d59d2214c2362e7a9d185d80b613e632581af7b ("mm: memcg: make stats flushing threshold per-memcg")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > testcase: vm-scalability
> > test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
> > parameters:
> >
> >         runtime: 300s
> >         size: 1T
> >         test: lru-shm
> >         cpufreq_governor: performance
> >
> > test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> > test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> >
> > In addition to that, the commit also has significant impact on the following tests:
> >
> > +------------------+----------------------------------------------------------------------------------------------------+
> > | testcase: change | will-it-scale: will-it-scale.per_process_ops -32.3% regression                                     |
> > | test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                                   |
> > | test parameters  | cpufreq_governor=performance                                                                       |
> > |                  | mode=process                                                                                       |
> > |                  | nr_task=50%                                                                                        |
> > |                  | test=tlb_flush2                                                                                    |
> > +------------------+----------------------------------------------------------------------------------------------------+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202401221624.cb53a8ca-oliver.sang@intel.com
> 
> Thanks for reporting this. We have had these patches running on O(10K)
> machines in our production for a while now, and there haven't been any
> complaints (at least not yet). OTOH, we do see significant CPU savings
> on reading memcg stats.
> 
> That being said, I think we can improve the performance here by
> caching pointers to the parent_memcg->vmstats_percpu and
> memcg->vmstats in struct memcg_vmstat_percpu. This should
> significantly reduce the memory fetches in the loop in
> memcg_rstat_updated().
> 
> Oliver, would you be able to test if the attached patch helps? It's
> based on 8d59d2214c236.

the patch failed to compile:

build_errors:
  - "mm/memcontrol.c:731:38: error: 'x' undeclared (first use in this function)"


> 
> [..]



