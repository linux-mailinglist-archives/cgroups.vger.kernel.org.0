Return-Path: <cgroups+bounces-76-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A07D6172
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 08:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10461C20D80
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 06:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093F14F91;
	Wed, 25 Oct 2023 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sb3++ivE"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CBB14296
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 06:09:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF7CC;
	Tue, 24 Oct 2023 23:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698214161; x=1729750161;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JnAWg2pRmipVlQtKHTz2EfUxchriWfLbMh9XmrLDOaI=;
  b=Sb3++ivEtL9elCeTJi3pxw7KJZYfp7qQkzz8DP/RYiir+oTXnOXjscS2
   EECUG//ZMpcFxTkAvgWanStZJ+3TAtms4m0JyXda/KUH6KQqDDrk8gOsz
   t/upLqmivjjC4BM+aLaUYajzmBfFnZwHQlxWpU8RUEhSHVM60RdW//smq
   C1Z/FpYaWiXrjz+wbuSkeqXMkN2yKGPWztSK0KMGJf86BfVB1n08e8Xix
   LbvQ5GPDnHExGW20NpnhU3i5gX0MWX2TqudRMjqtG2afzCR3+3jB714M3
   wD8ugDEYBNw3Mlsq09W7RiTmzlcJEvQlxdlM36rLKpE7D++iVceaZqStJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="473480477"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="473480477"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 23:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="6419625"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 23:08:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 23:09:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 23:09:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 23:09:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ3adMpqh+uwhppQAGkp6ric/Ax3ODlzHnxq36in9q015UWboOaYu7M+BGA48Bq2+wO8lWVu///q355TZ2+C2bxKUnm8mCn1qa9vftibMOtC/L58OettlDYaEfR6xfZqu+H3eaAzLfcVXv1pneQNJxbcHzoQ/lvCiRhkRl2QcwCwijdGmkVHSL/OuIt+7XPZ+2QK/bdV0rf9ynnDlCnmKGT6Sg5MhOBNe49OA11DZqBg20VdU+JrxZl1ljuaeuJCOM1VSNEG5D9UjWWP8NK5S3TBD0NxXBMrv9RHEy58u/kFLo8Z1mNM0G1CXJVKJuPQDofRJt1serE47DwEv4UueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xmOVFGZmed7DgYQjR0uptzYEUoNyOpwrS7gnUEdxnI=;
 b=NWoRcBdWc3AVvBQUgypl2ARK9cIax9PX0TdiQ3QMnFr1L/1n7sO9s0Fc3mQ3TFFFsEGhb/L0c75On2t4IQsXusY9As842O9pnpmhViKPbEVnGSYFY1C3WkQGRzmuzVsudPKJxgk8ISlZeu+3Tmin4LZCp7Q13b26TolEzcjm0SxnwI6aYCEnNS7X2x5VeA8Ez3QFV8WiNiMLCMmB72acZGpXdciCDsnOdq2enBPR58JIn/VFLRk0G06ykH9c7q+m88ipELg6IUkq3q+X9KkNdOmLtewVg1P6xLw2hwVCF+dZfuUHX6GbBW9b3cYYo/oO6Yr9qdAizecGviuQ4+HwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB7165.namprd11.prod.outlook.com (2603:10b6:510:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 06:09:13 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 06:09:13 +0000
Date: Wed, 25 Oct 2023 14:09:02 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Feng Tang <feng.tang@intel.com>, Shakeel Butt <shakeelb@google.com>,
	"oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "Huang, Ying" <ying.huang@intel.com>, "Yin, Fengwei"
	<fengwei.yin@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>,
	Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, Michal
 =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Waiman Long
	<longman@redhat.com>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>, Wei Xu <weixugc@google.com>, Greg Thelen
	<gthelen@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
Message-ID: <ZTiw/iIb0SbvN7vh@xsang-OptiPlex-9020>
References: <20231010032117.1577496-4-yosryahmed@google.com>
 <202310202303.c68e7639-oliver.sang@intel.com>
 <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
 <CAJD7tkbjZri4ayBOT9rJ0yMAi__c-1SVmRh_5oXezr7U6dvALg@mail.gmail.com>
 <ZTXLeAAI1chMamkU@feng-clx>
 <CAJD7tka5UnHBz=eX1LtynAjJ+O_oredMKBBL3kFNfG7PHjuMCw@mail.gmail.com>
 <CAJD7tkYXJ3vcGvteNH98tB_C7OTo718XSxL=mFsUa7kO8vzFzA@mail.gmail.com>
 <ZTdqpcDFVHhFwWMc@xsang-OptiPlex-9020>
 <CAJD7tka7hmOD6KPmJBJa+TscbYEMmTjS+Jh2utPfTbKkfvwD9A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka7hmOD6KPmJBJa+TscbYEMmTjS+Jh2utPfTbKkfvwD9A@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b4d734-6496-4409-2310-08dbd520e91e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpGKG1gsDc3HKqfKz3BUgtk0yVPxX2qIpvuboQGscCcO2YM1E0BkywIVx96Hy3mlSx2w7KAfHJ5vRxMOIi3ss7rmt6OOWlUy5kiTGG372ai1S/8cyM0VksiEPazV6LKUpvY5g32DjuHMhvNcHeQ6ABsIclE4RmgCySy4vVkhS9gR9D8VHxp46Zck0QBl9phkemntBXb/k0k7B7ObfNNdg/7dyacG4YLKrN7DDNnOC1Wa7BGRRNfkcznn32alGPbXcXrGGiB8cOdQrBfjjp8sRRh7nh5RXcpMUqpWum2sVM0GLkKYeAiD9YJrlGGCrGXrercJLh1lOTqbC8RK6OZ61WwP+tR1bQRLn8zOBoV0PKy/7IlJoLLPNfOo5fu8WbHr3MZ3ykwqJND73AHBgOb55HaouyKTgJusPkHZi/jS7sFgM1rLT9KQ3tskhGUqbcOhbr7XpErfJf8Q9PLy2A9P3eYr83kPujinfVOfyonEWi4xrnY0aMpS6G9yXyoTBkPEKMLM6fd1lWZlmOvmcNbsy/rvfxJ3Oy3NKsf/Tgga85E1gjzDUF+A/B7sSmfDY9s8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(7416002)(4326008)(8936002)(8676002)(44832011)(41300700001)(30864003)(2906002)(5660300002)(33716001)(9686003)(53546011)(82960400001)(6666004)(6512007)(6506007)(83380400001)(107886003)(38100700002)(66946007)(86362001)(66556008)(26005)(19627235002)(6486002)(478600001)(66476007)(6916009)(316002)(54906003)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFZBRWhyVlFrMm9IcmhZOVI3R3hsa2l0d2RrS2J5MUV0L2hwR24ycExCREJ0?=
 =?utf-8?B?UFh1Y21LN0lDa25IVWFNQkk1dmNpMy9vamRTTWkwenY3U29zTHpJVE9nVnhz?=
 =?utf-8?B?K2hHVUJHTzRYbG1SZUtCdGkxSXF1cW51ZGJ3OEM2YkJDYk1xbWpwVThIK0hB?=
 =?utf-8?B?cXh0a2Y3eDNFb3V2YmlFUExybmRWdzhQT3FUQ0FNYzNQemkzU1NXQ0p0Ui9X?=
 =?utf-8?B?KzROYTB4K0RKZjhCbGdqVGNwSmZaNEx1elFycUpkREFhdk9PWFduMkx0azIy?=
 =?utf-8?B?ZDFkOHdQSXl2dTlhSU10czZCTUh6enZ0ZjdmRm1mc2xFMnRiL2hwZXk5NUtp?=
 =?utf-8?B?Qm1zQlYwRkZvU2RjRFpTZmQ3R3VpdUhZZ3dUeHpzREk1eUxCZ2JrUHEycGJU?=
 =?utf-8?B?WDBLVWJOZUt1OU1iK0RxS2o1ODVTQmI0cHpIamx4elNIWjVtdWN4Z3pST1RZ?=
 =?utf-8?B?UVQyS3p0UmZSLy9iS3psVUprcTI1bWh5U0tBTE9JU3Z3eG1ZdHYyTzcwSFVL?=
 =?utf-8?B?TjVIZW9aQWptcFNVa1NHL3ZJWnRJS3V3SkdVM1NCNHdMWnh4VlU5cnR6dGFT?=
 =?utf-8?B?ZnlNOFVFa25ON1dScmlPQkJ4SEVOVGw3WkdPRlZTN2dpNWo1NVorR29Fa3hP?=
 =?utf-8?B?cnBCQllRYmNVaXdYd05NUG9GMzhPQ2dLRmdtY0Rlbk5EK0gxV0pwYW1XUm00?=
 =?utf-8?B?K29zSk1haHA3NFFLUm5YbnhoeWtXclVDSDZ3UHk4TUdrT1BYcndxVE8wUUV5?=
 =?utf-8?B?bEZzQzR0T2ZybTk4TDJQK2N4bHdLM0FOQnBTR3ZqSW9hbmlPdlpmNnBQUzVE?=
 =?utf-8?B?SjBCb0VOSFluYm1xSW9CTUh6eCs1dkwzODI5SngzNXFLWXpMbUlqT0QyVFpM?=
 =?utf-8?B?UjNxU3o4a09STnR5MWZjaGthMlhwQTZIeVJPRllrcDZ4bWkwbWpUVVRRa1Ix?=
 =?utf-8?B?Y0NibHc5ZFpIYXlqL0dsVVhJbHNUa3c2TU8xSWhDa0RWcDQ2OXJVSU5MTnJy?=
 =?utf-8?B?Nk1NMDR0UXhmTmpWV1RobXhEQUd0TEpVU2pWdEhlM1VZaFgvMjdaRFVvbkxM?=
 =?utf-8?B?cnE5NkJrNHU4TFJNQmozK2J6K1BBSm1VTVhZTDh3ZGlmcFgyWi8wNlNTdzFE?=
 =?utf-8?B?NVA3c2RES2RXL3poRkk0eUxadm5rNHdsTUlPN01WY25WVWVDMmpDRmhBS2tr?=
 =?utf-8?B?T0E5Z3JZZDE3SFlubjduWkpRYXMvK3gvaGpLUytwS0ptQ29jWUQ2d29mdkVt?=
 =?utf-8?B?QU45RUc4QVY0MDNEVjc4RVpqcUs3RkpNTjM4K0tSQnRhb2k2c0R1M09HTy91?=
 =?utf-8?B?TjMwVEJwVk5BV09weGUvNHBScWgwZ25DVEprcEs4eVVPTDdCQ2YvcWZJdWJh?=
 =?utf-8?B?bnVhbUp5dVFRczJkNm02RkhqOUlpMkcvandJUmd0VXpIMll2dDR2WThkNlV1?=
 =?utf-8?B?UWp2U3BucFZTT05Ca1BwdFJNS005aGNKMDFYVWlrRDhjeTlZUDVXTU0vOHgr?=
 =?utf-8?B?TGpwRGY5MHJ4cTZqUTdwUEx3UVE0M1Z5L01pL2ZVZ3lURVhsc1FjNDVhYjIr?=
 =?utf-8?B?V25ONUZKT2duQWtRQVZjM2UzSGFOellUOGtSRkRGT3k3QUpCdUhSbnR1WjBk?=
 =?utf-8?B?RzgvcEJyczM0QnZ6ZkNzQ3lJakJ4ZFY5UG9wTHJIWFB6c3RTZk1PMG9wSUcz?=
 =?utf-8?B?TU4vTTlFYVVVKzE4TUkrZDluaHBNMWh3TDVLSURMVEMvc3dVOXltNldOQ0dU?=
 =?utf-8?B?dmZ3QWg0ZWV0YTdtMWdFWnFIekx5K2NsWE9kaUdxRXBOQ2d5SmNkSFRxUEti?=
 =?utf-8?B?MXBoOHY4bjM2OFlNL2lJTFVObFRuMDJtcXFXM1dodk5oMGdWbkduOS9yNUdv?=
 =?utf-8?B?bURKZFhicnh4aHN2UlJBcnBhSC84NmcwNkgyekdBL2grdi9XL00wQ1VwZTNJ?=
 =?utf-8?B?enM3WGNsRUVRcXRCdHpRMnI4TFBqTUNHOUxaUmNwc3gxaEZ4NTV4THFIZ25N?=
 =?utf-8?B?dmkwWFpWbTF1MFpnU21hVHBWL2twNXAzSjMxYW9teElPeWZOWmhkcUpaajcx?=
 =?utf-8?B?YVZiSWU5bkZWd1V1V1pLektKaWxsOVJVbXZrOGd5TjVKWUJLNVJTWGxJMGZv?=
 =?utf-8?B?enJ3LzlSKzU2UjZ6VkVIeUJKMHQwTC9oUnRBd0dUTUpJbzJzbkZqZ3gzZkc1?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b4d734-6496-4409-2310-08dbd520e91e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:09:13.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5APml9edmddNlndtOobyIkkzYKy5+3oVkNSw8QzKCntk1occGXTQjD18DtjEmNgL+6z7f5Rlt99rO6rLzf+Pqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7165
X-OriginatorOrg: intel.com

hi, Yosry Ahmed,

On Tue, Oct 24, 2023 at 12:14:42AM -0700, Yosry Ahmed wrote:
> On Mon, Oct 23, 2023 at 11:56 PM Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > hi, Yosry Ahmed,
> >
> > On Mon, Oct 23, 2023 at 07:13:50PM -0700, Yosry Ahmed wrote:
> >
> > ...
> >
> > >
> > > I still could not run the benchmark, but I used a version of
> > > fallocate1.c that does 1 million iterations. I ran 100 in parallel.
> > > This showed ~13% regression with the patch, so not the same as the
> > > will-it-scale version, but it could be an indicator.
> > >
> > > With that, I did not see any improvement with the fixlet above or
> > > ___cacheline_aligned_in_smp. So you can scratch that.
> > >
> > > I did, however, see some improvement with reducing the indirection
> > > layers by moving stats_updates directly into struct mem_cgroup. The
> > > regression in my manual testing went down to 9%. Still not great, but
> > > I am wondering how this reflects on the benchmark. If you're able to
> > > test it that would be great, the diff is below. Meanwhile I am still
> > > looking for other improvements that can be made.
> >
> > we applied previous patch-set as below:
> >
> > c5f50d8b23c79 (linux-review/Yosry-Ahmed/mm-memcg-change-flush_next_time-to-flush_last_time/20231010-112257) mm: memcg: restore subtree stats flushing
> > ac8a48ba9e1ca mm: workingset: move the stats flush into workingset_test_recent()
> > 51d74c18a9c61 mm: memcg: make stats flushing threshold per-memcg
> > 130617edc1cd1 mm: memcg: move vmstats structs definition above flushing code
> > 26d0ee342efc6 mm: memcg: change flush_next_time to flush_last_time
> > 25478183883e6 Merge branch 'mm-nonmm-unstable' into mm-everything   <---- the base our tool picked for the patch set
> >
> > I tried to apply below patch to either 51d74c18a9c61 or c5f50d8b23c79,
> > but failed. could you guide how to apply this patch?
> > Thanks
> >
> 
> Thanks for looking into this. I rebased the diff on top of
> c5f50d8b23c79. Please find it attached.

from our tests, this patch has little impact.

it was applied as below ac6a9444dec85:

ac6a9444dec85 (linux-devel/fixup-c5f50d8b23c79) memcg: move stats_updates to struct mem_cgroup
c5f50d8b23c79 (linux-review/Yosry-Ahmed/mm-memcg-change-flush_next_time-to-flush_last_time/20231010-112257) mm: memcg: restore subtree stats flushing
ac8a48ba9e1ca mm: workingset: move the stats flush into workingset_test_recent()
51d74c18a9c61 mm: memcg: make stats flushing threshold per-memcg
130617edc1cd1 mm: memcg: move vmstats structs definition above flushing code
26d0ee342efc6 mm: memcg: change flush_next_time to flush_last_time
25478183883e6 Merge branch 'mm-nonmm-unstable' into mm-everything

for the first regression reported in original report, data are very close
for 51d74c18a9c61, c5f50d8b23c79 (patch-set tip, parent of ac6a9444dec85),
and ac6a9444dec85.
full comparison is as [1]

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/fallocate1/will-it-scale

130617edc1cd1ba1 51d74c18a9c61e7ee33bc90b522 c5f50d8b23c7982ac875791755b ac6a9444dec85dc50c6bfbc4ee7
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
     36509           -25.8%      27079           -25.2%      27305           -25.0%      27383        will-it-scale.per_thread_ops

for the second regression reported in origianl report, seems a small impact
from ac6a9444dec85.
full comparison is as [2]

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/fallocate1/will-it-scale

130617edc1cd1ba1 51d74c18a9c61e7ee33bc90b522 c5f50d8b23c7982ac875791755b ac6a9444dec85dc50c6bfbc4ee7
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
     76580           -30.0%      53575           -28.9%      54415           -26.7%      56152        will-it-scale.per_thread_ops

[1]
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/fallocate1/will-it-scale

130617edc1cd1ba1 51d74c18a9c61e7ee33bc90b522 c5f50d8b23c7982ac875791755b ac6a9444dec85dc50c6bfbc4ee7
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
      2.09            -0.5        1.61 ±  2%      -0.5        1.61            -0.5        1.60        mpstat.cpu.all.usr%
      3324           -10.0%       2993            +3.6%       3444 ± 20%      -6.2%       3118 ±  4%  vmstat.system.cs
    120.83 ± 11%     +79.6%     217.00 ±  9%    +105.8%     248.67 ± 10%    +115.2%     260.00 ± 10%  perf-c2c.DRAM.local
    594.50 ±  6%     +43.8%     854.83 ±  5%     +56.6%     931.17 ± 10%     +21.2%     720.67 ±  7%  perf-c2c.DRAM.remote
    -16.64           +39.7%     -23.25          +177.3%     -46.14           +13.9%     -18.94        sched_debug.cpu.nr_uninterruptible.min
      6.59 ± 13%      +6.5%       7.02 ± 11%     +84.7%      12.18 ± 51%      -6.6%       6.16 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
      0.04           -20.8%       0.03 ± 11%     -20.8%       0.03 ± 11%     -25.0%       0.03        turbostat.IPC
     27.58            +3.7%      28.59            +4.2%      28.74            +3.8%      28.63        turbostat.RAMWatt
     71000 ± 68%     +66.4%     118174 ± 60%     -49.8%      35634 ± 13%     -59.9%      28485 ± 10%  numa-meminfo.node0.AnonHugePages
      1056          -100.0%       0.00            +1.9%       1076           -12.6%     923.33 ± 44%  numa-meminfo.node0.Inactive(file)
      6.67 ±141%  +15799.3%       1059          -100.0%       0.00         +2669.8%     184.65 ±223%  numa-meminfo.node1.Inactive(file)
   3797041           -25.8%    2816352           -25.2%    2839803           -25.0%    2847955        will-it-scale.104.threads
     36509           -25.8%      27079           -25.2%      27305           -25.0%      27383        will-it-scale.per_thread_ops
   3797041           -25.8%    2816352           -25.2%    2839803           -25.0%    2847955        will-it-scale.workload
 1.142e+09           -26.2%  8.437e+08           -26.6%  8.391e+08           -25.7%  8.489e+08        numa-numastat.node0.local_node
 1.143e+09           -26.1%  8.439e+08           -26.6%  8.392e+08           -25.7%  8.491e+08        numa-numastat.node0.numa_hit
 1.148e+09           -25.4%  8.563e+08 ±  2%     -23.7%  8.756e+08 ±  2%     -24.2%  8.702e+08        numa-numastat.node1.local_node
 1.149e+09           -25.4%  8.564e+08 ±  2%     -23.8%  8.758e+08 ±  2%     -24.2%  8.707e+08        numa-numastat.node1.numa_hit
     10842            +0.9%      10941            +2.9%      11153 ±  2%      +0.3%      10873        proc-vmstat.nr_mapped
     32933            -2.6%      32068            +0.1%      32956 ±  2%      -1.5%      32450 ±  2%  proc-vmstat.nr_slab_reclaimable
 2.291e+09           -25.8%    1.7e+09           -25.1%  1.715e+09           -24.9%   1.72e+09        proc-vmstat.numa_hit
 2.291e+09           -25.8%    1.7e+09           -25.1%  1.715e+09           -25.0%  1.719e+09        proc-vmstat.numa_local
  2.29e+09           -25.8%  1.699e+09           -25.1%  1.714e+09           -24.9%  1.718e+09        proc-vmstat.pgalloc_normal
 2.289e+09           -25.8%  1.699e+09           -25.1%  1.714e+09           -24.9%  1.718e+09        proc-vmstat.pgfree
    199.33          -100.0%       0.00            -0.3%     198.66           -16.4%     166.67 ± 44%  numa-vmstat.node0.nr_active_file
    264.00          -100.0%       0.00            +1.9%     269.00           -12.6%     230.83 ± 44%  numa-vmstat.node0.nr_inactive_file
    199.33          -100.0%       0.00            -0.3%     198.66           -16.4%     166.67 ± 44%  numa-vmstat.node0.nr_zone_active_file
    264.00          -100.0%       0.00            +1.9%     269.00           -12.6%     230.83 ± 44%  numa-vmstat.node0.nr_zone_inactive_file
 1.143e+09           -26.1%  8.439e+08           -26.6%  8.392e+08           -25.7%  8.491e+08        numa-vmstat.node0.numa_hit
 1.142e+09           -26.2%  8.437e+08           -26.6%  8.391e+08           -25.7%  8.489e+08        numa-vmstat.node0.numa_local
      1.67 ±141%  +15799.3%     264.99          -100.0%       0.00         +2669.8%      46.16 ±223%  numa-vmstat.node1.nr_inactive_file
      1.67 ±141%  +15799.3%     264.99          -100.0%       0.00         +2669.8%      46.16 ±223%  numa-vmstat.node1.nr_zone_inactive_file
 1.149e+09           -25.4%  8.564e+08 ±  2%     -23.8%  8.758e+08 ±  2%     -24.2%  8.707e+08        numa-vmstat.node1.numa_hit
 1.148e+09           -25.4%  8.563e+08 ±  2%     -23.7%  8.756e+08 ±  2%     -24.2%  8.702e+08        numa-vmstat.node1.numa_local
      0.04 ±108%     -76.2%       0.01 ± 23%    +154.8%       0.10 ± 34%    +110.0%       0.08 ± 88%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.00 ± 93%    +154.2%       2.55 ± 16%    +133.4%       2.34 ± 39%    +174.6%       2.76 ± 22%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.71 ±131%     -91.3%       0.06 ± 74%    +184.4%       2.02 ± 40%    +122.6%       1.58 ± 98%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.84 ± 45%     +35.2%       2.48 ± 31%     +66.1%       3.05 ± 25%     +61.9%       2.98 ± 10%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
    191.10 ±  2%     +18.0%     225.55 ±  2%     +18.9%     227.22 ±  4%     +19.8%     228.89 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3484            -7.8%       3211 ±  6%      -7.3%       3230 ±  7%     -11.0%       3101 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
    385.50 ± 14%     +39.6%     538.17 ± 12%    +104.5%     788.17 ± 54%     +30.9%     504.67 ± 41%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      3784            -7.5%       3500 ±  6%      -7.1%       3516 ±  2%     -10.6%       3383 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
    118.67 ± 11%     -62.6%      44.33 ±100%     -45.9%      64.17 ± 71%     -64.9%      41.67 ±100%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      5043 ±  2%     -13.0%       4387 ±  6%     -14.7%       4301 ±  3%     -16.5%       4210 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    167.12 ±222%    +200.1%     501.48 ± 99%      +2.9%     171.99 ±215%    +399.7%     835.05 ± 44%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.17 ± 21%      +8.9%       2.36 ± 16%     +94.3%       4.21 ± 36%     +40.4%       3.04 ± 21%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    191.09 ±  2%     +18.0%     225.53 ±  2%     +18.9%     227.21 ±  4%     +19.8%     228.88 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    293.46 ±  4%     +12.8%     330.98 ±  6%     +21.0%     355.18 ± 16%      +7.1%     314.31 ± 26%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     30.33 ±105%     -35.1%      19.69 ±138%    +494.1%     180.18 ± 79%    +135.5%      71.43 ± 76%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.59 ±  3%    +125.2%       1.32 ±  2%    +139.3%       1.41          +128.6%       1.34        perf-stat.i.MPKI
 9.027e+09           -17.9%  7.408e+09           -17.5%  7.446e+09           -17.3%  7.465e+09        perf-stat.i.branch-instructions
      0.64            -0.0        0.60            -0.0        0.60            -0.0        0.60        perf-stat.i.branch-miss-rate%
  58102855           -23.3%   44580037 ±  2%     -23.4%   44524712 ±  2%     -22.9%   44801374        perf-stat.i.branch-misses
     15.28            +7.0       22.27            +7.9       23.14            +7.2       22.50        perf-stat.i.cache-miss-rate%
  25155306 ±  2%     +82.7%   45953601 ±  3%     +95.2%   49105558 ±  2%     +87.7%   47212483        perf-stat.i.cache-misses
 1.644e+08           +25.4%  2.062e+08 ±  2%     +29.0%   2.12e+08           +27.6%  2.098e+08        perf-stat.i.cache-references
      3258           -10.3%       2921            +2.5%       3341 ± 19%      -6.7%       3041 ±  4%  perf-stat.i.context-switches
      6.73           +23.3%       8.30           +22.7%       8.26           +21.8%       8.20        perf-stat.i.cpi
    145.97            -1.3%     144.13            -1.4%     143.89            -1.2%     144.29        perf-stat.i.cpu-migrations
     11519 ±  3%     -45.4%       6293 ±  3%     -48.9%       5892 ±  2%     -46.9%       6118        perf-stat.i.cycles-between-cache-misses
      0.04            -0.0        0.03            -0.0        0.03            -0.0        0.03        perf-stat.i.dTLB-load-miss-rate%
   3921408           -25.3%    2929564           -24.6%    2957991           -24.5%    2961168        perf-stat.i.dTLB-load-misses
 1.098e+10           -18.1%  8.993e+09           -17.6%  9.045e+09           -16.3%  9.185e+09        perf-stat.i.dTLB-loads
      0.00 ±  2%      +0.0        0.00 ±  4%      +0.0        0.00 ±  5%      +0.0        0.00 ±  3%  perf-stat.i.dTLB-store-miss-rate%
 5.606e+09           -23.2%  4.304e+09           -22.6%  4.338e+09           -22.4%  4.349e+09        perf-stat.i.dTLB-stores
     95.65            -1.2       94.49            -0.9       94.74            -0.8       94.87        perf-stat.i.iTLB-load-miss-rate%
   3876741           -25.0%    2905764           -24.8%    2915184           -25.0%    2909099        perf-stat.i.iTLB-load-misses
 4.286e+10           -18.9%  3.477e+10           -18.4%  3.496e+10           -17.9%  3.517e+10        perf-stat.i.instructions
     11061            +8.2%      11969            +8.4%      11996            +9.3%      12091        perf-stat.i.instructions-per-iTLB-miss
      0.15           -18.9%       0.12           -18.5%       0.12           -17.9%       0.12        perf-stat.i.ipc
      0.01 ± 96%      -8.9%       0.01 ± 96%     +72.3%       0.01 ± 73%    +174.6%       0.02 ± 32%  perf-stat.i.major-faults
     48.65 ±  2%     +46.2%      71.11 ±  2%     +57.0%      76.37 ±  2%     +45.4%      70.72        perf-stat.i.metric.K/sec
    247.84           -18.9%     201.05           -18.4%     202.30           -17.7%     203.92        perf-stat.i.metric.M/sec
     89.33            +0.5       89.79            -0.7       88.67            -2.1       87.23        perf-stat.i.node-load-miss-rate%
   3138385 ±  2%     +77.7%    5578401 ±  2%     +89.9%    5958861 ±  2%     +70.9%    5363943        perf-stat.i.node-load-misses
    375827 ±  3%     +69.2%     635857 ± 11%    +102.6%     761334 ±  4%    +109.3%     786773 ±  5%  perf-stat.i.node-loads
   1343194           -26.8%     983668           -22.6%    1039799 ±  2%     -23.6%    1026076        perf-stat.i.node-store-misses
     51550 ±  3%     -19.0%      41748 ±  7%     -22.5%      39954 ±  4%     -20.6%      40921 ±  7%  perf-stat.i.node-stores
      0.59 ±  3%    +125.1%       1.32 ±  2%    +139.2%       1.40          +128.7%       1.34        perf-stat.overall.MPKI
      0.64            -0.0        0.60            -0.0        0.60            -0.0        0.60        perf-stat.overall.branch-miss-rate%
     15.30            +7.0       22.28            +7.9       23.16            +7.2       22.50        perf-stat.overall.cache-miss-rate%
      6.73           +23.3%       8.29           +22.6%       8.25           +21.9%       8.20        perf-stat.overall.cpi
     11470 ±  2%     -45.3%       6279 ±  2%     -48.8%       5875 ±  2%     -46.7%       6108        perf-stat.overall.cycles-between-cache-misses
      0.04            -0.0        0.03            -0.0        0.03            -0.0        0.03        perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  2%      +0.0        0.00 ±  4%      +0.0        0.00 ±  5%      +0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
     95.56            -1.4       94.17            -1.0       94.56            -0.9       94.66        perf-stat.overall.iTLB-load-miss-rate%
     11059            +8.2%      11967            +8.5%      11994            +9.3%      12091        perf-stat.overall.instructions-per-iTLB-miss
      0.15           -18.9%       0.12           -18.4%       0.12           -17.9%       0.12        perf-stat.overall.ipc
     89.29            +0.5       89.78            -0.6       88.67            -2.1       87.20        perf-stat.overall.node-load-miss-rate%
   3396437            +9.5%    3718021            +9.1%    3705386            +9.6%    3721307        perf-stat.overall.path-length
 8.997e+09           -17.9%  7.383e+09           -17.5%  7.421e+09           -17.3%   7.44e+09        perf-stat.ps.branch-instructions
  57910417           -23.3%   44426577 ±  2%     -23.4%   44376780 ±  2%     -22.9%   44649215        perf-stat.ps.branch-misses
  25075498 ±  2%     +82.7%   45803186 ±  3%     +95.2%   48942749 ±  2%     +87.7%   47057228        perf-stat.ps.cache-misses
 1.639e+08           +25.4%  2.056e+08 ±  2%     +28.9%  2.113e+08           +27.6%  2.091e+08        perf-stat.ps.cache-references
      3247           -10.3%       2911            +2.5%       3329 ± 19%      -6.7%       3030 ±  4%  perf-stat.ps.context-switches
    145.47            -1.3%     143.61            -1.4%     143.38            -1.2%     143.70        perf-stat.ps.cpu-migrations
   3908900           -25.3%    2920218           -24.6%    2949112           -24.5%    2951633        perf-stat.ps.dTLB-load-misses
 1.094e+10           -18.1%  8.963e+09           -17.6%  9.014e+09           -16.3%  9.154e+09        perf-stat.ps.dTLB-loads
 5.587e+09           -23.2%  4.289e+09           -22.6%  4.324e+09           -22.4%  4.335e+09        perf-stat.ps.dTLB-stores
   3863663           -25.0%    2895895           -24.8%    2905355           -25.0%    2899323        perf-stat.ps.iTLB-load-misses
 4.272e+10           -18.9%  3.466e+10           -18.4%  3.484e+10           -17.9%  3.505e+10        perf-stat.ps.instructions
   3128132 ±  2%     +77.7%    5559939 ±  2%     +89.9%    5938929 ±  2%     +70.9%    5346027        perf-stat.ps.node-load-misses
    375403 ±  3%     +69.0%     634300 ± 11%    +102.3%     759484 ±  4%    +109.1%     784913 ±  5%  perf-stat.ps.node-loads
   1338688           -26.8%     980311           -22.6%    1036279 ±  2%     -23.6%    1022618        perf-stat.ps.node-store-misses
     51546 ±  3%     -19.1%      41692 ±  7%     -22.6%      39921 ±  4%     -20.7%      40875 ±  7%  perf-stat.ps.node-stores
  1.29e+13           -18.8%  1.047e+13           -18.4%  1.052e+13           -17.8%   1.06e+13        perf-stat.total.instructions
      0.96            -0.3        0.70 ±  2%      -0.3        0.70 ±  2%      -0.3        0.70        perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.97            -0.3        0.72            -0.2        0.72            -0.2        0.72        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.fallocate64
      0.76 ±  2%      -0.2        0.54 ±  3%      -0.2        0.59 ±  3%      -0.1        0.68        perf-profile.calltrace.cycles-pp.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.82            -0.2        0.60 ±  2%      -0.2        0.60 ±  2%      -0.2        0.60        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.91            -0.2        0.72            -0.2        0.72            -0.2        0.70 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     51.50            -0.0       51.47            -0.5       50.99            -0.3       51.21        perf-profile.calltrace.cycles-pp.fallocate64
     48.31            +0.0       48.35            +0.5       48.83            +0.3       48.61        perf-profile.calltrace.cycles-pp.ftruncate64
     48.29            +0.0       48.34            +0.5       48.81            +0.3       48.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     48.28            +0.0       48.33            +0.5       48.80            +0.3       48.59        perf-profile.calltrace.cycles-pp.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     48.29            +0.1       48.34            +0.5       48.82            +0.3       48.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64
     48.28            +0.1       48.33            +0.5       48.80            +0.3       48.58        perf-profile.calltrace.cycles-pp.do_truncate.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     48.27            +0.1       48.33            +0.5       48.80            +0.3       48.58        perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.27            +0.1       48.32            +0.5       48.80            +0.3       48.58        perf-profile.calltrace.cycles-pp.shmem_setattr.notify_change.do_truncate.do_sys_ftruncate.do_syscall_64
     48.25            +0.1       48.31            +0.5       48.78            +0.3       48.57        perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_setattr.notify_change.do_truncate.do_sys_ftruncate
      2.06 ±  2%      +0.1        2.13 ±  2%      +0.1        2.16            +0.0        2.09        perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      0.68            +0.1        0.76 ±  2%      +0.1        0.75            +0.1        0.74        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.67            +0.1        1.77            +0.1        1.81 ±  2%      +0.0        1.71        perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
     45.76            +0.1       45.86            +0.5       46.29            +0.4       46.13        perf-profile.calltrace.cycles-pp.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      1.78 ±  2%      +0.1        1.92 ±  2%      +0.2        1.95            +0.1        1.88        perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change
      0.69 ±  5%      +0.1        0.84 ±  4%      +0.2        0.86 ±  5%      +0.1        0.79 ±  2%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      1.56 ±  2%      +0.2        1.76 ±  2%      +0.2        1.79            +0.2        1.71        perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr
      0.85 ±  4%      +0.4        1.23 ±  2%      +0.4        1.26 ±  3%      +0.3        1.14        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.78 ±  4%      +0.4        1.20 ±  3%      +0.4        1.22            +0.3        1.11        perf-profile.calltrace.cycles-pp.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range
      0.73 ±  4%      +0.4        1.17 ±  3%      +0.5        1.19 ±  2%      +0.4        1.08        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio
     41.60            +0.7       42.30            +0.1       41.73            +0.5       42.06        perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
     41.50            +0.7       42.23            +0.2       41.66            +0.5       41.99        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     48.39            +0.8       49.14            +0.2       48.64            +0.5       48.89        perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.00            +0.8        0.77 ±  4%      +0.8        0.80 ±  2%      +0.8        0.78 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     40.24            +0.8       41.03            +0.2       40.48            +0.6       40.80        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     40.22            +0.8       41.01            +0.2       40.47            +0.6       40.79        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      0.00            +0.8        0.79 ±  3%      +0.8        0.82 ±  3%      +0.8        0.79 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     40.19            +0.8       40.98            +0.3       40.44            +0.6       40.76        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
      1.33 ±  5%      +0.8        2.13 ±  4%      +0.9        2.21 ±  4%      +0.8        2.09 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
     48.16            +0.8       48.98            +0.3       48.48            +0.6       48.72        perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.00            +0.9        0.88 ±  2%      +0.9        0.91            +0.9        0.86        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio
     47.92            +0.9       48.81            +0.4       48.30            +0.6       48.56        perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     47.07            +0.9       48.01            +0.5       47.60            +0.7       47.79        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     46.59            +1.1       47.64            +0.7       47.24            +0.8       47.44        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      0.99            -0.3        0.73 ±  2%      -0.3        0.74            -0.3        0.74        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.96            -0.3        0.70 ±  2%      -0.3        0.70 ±  2%      -0.3        0.71        perf-profile.children.cycles-pp.shmem_alloc_folio
      0.78 ±  2%      -0.2        0.56 ±  3%      -0.2        0.61 ±  3%      -0.1        0.69 ±  2%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.83            -0.2        0.61 ±  2%      -0.2        0.61 ±  2%      -0.2        0.62        perf-profile.children.cycles-pp.alloc_pages_mpol
      0.92            -0.2        0.73            -0.2        0.73            -0.2        0.71 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.74 ±  2%      -0.2        0.55 ±  2%      -0.2        0.56 ±  2%      -0.2        0.58 ±  3%  perf-profile.children.cycles-pp.xas_store
      0.67            -0.2        0.50 ±  3%      -0.2        0.50 ±  2%      -0.2        0.50        perf-profile.children.cycles-pp.__alloc_pages
      0.43            -0.1        0.31 ±  2%      -0.1        0.31            -0.1        0.31        perf-profile.children.cycles-pp.__entry_text_start
      0.41 ±  2%      -0.1        0.30 ±  3%      -0.1        0.31 ±  2%      -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.free_unref_page_list
      0.35            -0.1        0.25 ±  2%      -0.1        0.25 ±  2%      -0.1        0.25        perf-profile.children.cycles-pp.xas_load
      0.35 ±  2%      -0.1        0.25 ±  4%      -0.1        0.25 ±  2%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.39            -0.1        0.30 ±  2%      -0.1        0.29 ±  3%      -0.1        0.30        perf-profile.children.cycles-pp.get_page_from_freelist
      0.27 ±  2%      -0.1        0.19 ±  4%      -0.1        0.19 ±  5%      -0.1        0.19 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.32 ±  3%      -0.1        0.24 ±  3%      -0.1        0.25            -0.1        0.26 ±  4%  perf-profile.children.cycles-pp.find_lock_entries
      0.23 ±  2%      -0.1        0.15 ±  4%      -0.1        0.16 ±  3%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.xas_descend
      0.25 ±  3%      -0.1        0.18 ±  3%      -0.1        0.18 ±  3%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.28 ±  3%      -0.1        0.20 ±  3%      -0.1        0.21 ±  2%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.16 ±  3%      -0.1        0.10 ±  5%      -0.1        0.10 ±  4%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.xas_find_conflict
      0.26 ±  2%      -0.1        0.20 ±  3%      -0.1        0.19 ±  3%      -0.1        0.19        perf-profile.children.cycles-pp.filemap_get_entry
      0.26            -0.1        0.20 ±  2%      -0.1        0.20 ±  4%      -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.20 ±  3%      -0.1        0.14 ±  3%      -0.0        0.15 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.19 ±  5%      -0.1        0.14 ±  4%      -0.0        0.15 ±  5%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.xas_clear_mark
      0.17 ±  5%      -0.0        0.12 ±  4%      -0.0        0.12 ±  6%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.xas_init_marks
      0.15 ±  4%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.15 ± 12%      -0.0        0.10 ± 20%      -0.1        0.10 ± 15%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     51.56            -0.0       51.51            -0.5       51.03            -0.3       51.26        perf-profile.children.cycles-pp.fallocate64
      0.18 ±  3%      -0.0        0.14 ±  3%      -0.0        0.13 ±  5%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.07 ±  5%      -0.0        0.02 ± 99%      -0.0        0.04 ± 44%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.xas_find
      0.13 ±  2%      -0.0        0.09            -0.0        0.10 ±  5%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.14 ±  4%      -0.0        0.10 ±  7%      -0.0        0.10 ±  6%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.06 ±  6%      -0.0        0.02 ± 99%      -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.12 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.xas_start
      0.08 ±  5%      -0.0        0.05            -0.0        0.05            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.12            -0.0        0.08 ±  5%      -0.0        0.08 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.folio_unlock
      0.14 ±  3%      -0.0        0.11 ±  3%      -0.0        0.11 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      0.12 ±  6%      -0.0        0.08 ±  5%      -0.0        0.09 ±  5%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.12 ±  3%      -0.0        0.09 ±  4%      -0.0        0.09 ±  7%      -0.0        0.09        perf-profile.children.cycles-pp.noop_dirty_folio
      0.20 ±  2%      -0.0        0.17 ±  5%      -0.0        0.18            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.10            -0.0        0.07 ±  5%      -0.0        0.08 ±  8%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.09 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.09 ±  5%      -0.0        0.06 ±  7%      -0.0        0.06 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.inode_add_bytes
      0.06 ±  6%      -0.0        0.03 ± 70%      -0.0        0.04 ± 44%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.filemap_free_folio
      0.06 ±  6%      -0.0        0.03 ± 70%      +0.0        0.07 ±  7%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.12 ±  3%      -0.0        0.10 ±  5%      -0.0        0.09 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.shmem_recalc_inode
      0.12 ±  3%      -0.0        0.09 ±  5%      -0.0        0.09 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.09 ±  5%      -0.0        0.07 ±  7%      -0.0        0.09 ±  4%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.08 ±  5%      -0.0        0.06            -0.0        0.06 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.security_file_permission
      0.08 ±  5%      -0.0        0.06            -0.0        0.06 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.08 ±  6%      -0.0        0.05 ±  7%      -0.0        0.05 ±  8%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.09 ±  4%      -0.0        0.07 ±  8%      -0.0        0.09 ±  8%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__percpu_counter_limited_add
      0.08 ±  6%      -0.0        0.06 ±  8%      -0.0        0.06            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.07 ±  8%      -0.0        0.05            -0.0        0.05 ±  7%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.14 ±  3%      -0.0        0.12 ±  6%      -0.0        0.12 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.07 ±  5%      -0.0        0.05            -0.0        0.05            -0.0        0.05        perf-profile.children.cycles-pp.policy_nodemask
      0.24 ±  2%      -0.0        0.22 ±  2%      -0.0        0.22 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.08            -0.0        0.07 ±  7%      -0.0        0.06 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.xas_create
      0.08 ±  8%      -0.0        0.06 ±  7%      -0.0        0.06 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.00            +0.0        0.00            +0.0        0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__file_remove_privs
      0.28 ±  2%      +0.0        0.28 ±  4%      +0.0        0.30            +0.0        0.30        perf-profile.children.cycles-pp.uncharge_batch
      0.14 ±  5%      +0.0        0.17 ±  4%      +0.0        0.17 ±  2%      +0.0        0.16        perf-profile.children.cycles-pp.uncharge_folio
      0.43            +0.0        0.46 ±  4%      +0.0        0.48            +0.0        0.47        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
     48.31            +0.0       48.35            +0.5       48.83            +0.3       48.61        perf-profile.children.cycles-pp.ftruncate64
     48.28            +0.0       48.33            +0.5       48.80            +0.3       48.59        perf-profile.children.cycles-pp.do_sys_ftruncate
     48.28            +0.1       48.33            +0.5       48.80            +0.3       48.58        perf-profile.children.cycles-pp.do_truncate
     48.27            +0.1       48.33            +0.5       48.80            +0.3       48.58        perf-profile.children.cycles-pp.notify_change
     48.27            +0.1       48.32            +0.5       48.80            +0.3       48.58        perf-profile.children.cycles-pp.shmem_setattr
     48.26            +0.1       48.32            +0.5       48.79            +0.3       48.57        perf-profile.children.cycles-pp.shmem_undo_range
      2.06 ±  2%      +0.1        2.13 ±  2%      +0.1        2.16            +0.0        2.10        perf-profile.children.cycles-pp.truncate_inode_folio
      0.69            +0.1        0.78            +0.1        0.77            +0.1        0.76        perf-profile.children.cycles-pp.lru_add_fn
      1.72 ±  2%      +0.1        1.80            +0.1        1.83 ±  2%      +0.0        1.74        perf-profile.children.cycles-pp.shmem_add_to_page_cache
     45.77            +0.1       45.86            +0.5       46.29            +0.4       46.13        perf-profile.children.cycles-pp.__folio_batch_release
      1.79 ±  2%      +0.1        1.93 ±  2%      +0.2        1.96            +0.1        1.88        perf-profile.children.cycles-pp.filemap_remove_folio
      0.13 ±  5%      +0.1        0.28            +0.1        0.19 ±  5%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.file_modified
      0.69 ±  5%      +0.1        0.84 ±  3%      +0.2        0.86 ±  5%      +0.1        0.79 ±  2%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.09 ±  7%      +0.2        0.24 ±  2%      +0.1        0.15 ±  3%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.inode_needs_update_time
      1.58 ±  3%      +0.2        1.77 ±  2%      +0.2        1.80            +0.1        1.72        perf-profile.children.cycles-pp.__filemap_remove_folio
      0.15 ±  3%      +0.4        0.50 ±  3%      +0.4        0.52 ±  2%      +0.4        0.52 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
      0.79 ±  4%      +0.4        1.20 ±  3%      +0.4        1.22            +0.3        1.12        perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.36 ±  5%      +0.4        0.77 ±  4%      +0.4        0.81 ±  2%      +0.4        0.78 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
     98.33            +0.5       98.78            +0.4       98.77            +0.4       98.77        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     97.74            +0.6       98.34            +0.6       98.32            +0.6       98.33        perf-profile.children.cycles-pp.do_syscall_64
     41.62            +0.7       42.33            +0.1       41.76            +0.5       42.08        perf-profile.children.cycles-pp.folio_add_lru
     43.91            +0.7       44.64            +0.2       44.09            +0.5       44.40        perf-profile.children.cycles-pp.folio_batch_move_lru
     48.39            +0.8       49.15            +0.2       48.64            +0.5       48.89        perf-profile.children.cycles-pp.__x64_sys_fallocate
      1.34 ±  5%      +0.8        2.14 ±  4%      +0.9        2.22 ±  4%      +0.8        2.10 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.61 ±  4%      +0.8        2.42 ±  2%      +0.9        2.47 ±  2%      +0.6        2.24        perf-profile.children.cycles-pp.__mod_lruvec_page_state
     48.17            +0.8       48.98            +0.3       48.48            +0.6       48.72        perf-profile.children.cycles-pp.vfs_fallocate
     47.94            +0.9       48.82            +0.4       48.32            +0.6       48.56        perf-profile.children.cycles-pp.shmem_fallocate
     47.10            +0.9       48.04            +0.5       47.64            +0.7       47.83        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     84.34            +0.9       85.28            +0.8       85.11            +0.9       85.28        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     84.31            +0.9       85.26            +0.8       85.08            +0.9       85.26        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     84.24            +1.0       85.21            +0.8       85.04            +1.0       85.21        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     46.65            +1.1       47.70            +0.7       47.30            +0.8       47.48        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      1.23 ±  4%      +1.4        2.58 ±  2%      +1.4        2.63 ±  2%      +1.3        2.52        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.98            -0.3        0.73 ±  2%      -0.2        0.74            -0.2        0.74        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.88            -0.2        0.70            -0.2        0.70            -0.2        0.69 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.60            -0.2        0.45            -0.1        0.46 ±  2%      -0.2        0.46 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.41 ±  3%      -0.1        0.27 ±  3%      -0.1        0.27 ±  2%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.release_pages
      0.41 ±  3%      -0.1        0.29 ±  2%      -0.1        0.28 ±  3%      -0.1        0.29 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.41            -0.1        0.30 ±  3%      -0.1        0.30 ±  2%      -0.1        0.32 ±  4%  perf-profile.self.cycles-pp.xas_store
      0.30 ±  3%      -0.1        0.18 ±  5%      -0.1        0.19 ±  2%      -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.38 ±  2%      -0.1        0.27 ±  2%      -0.1        0.27 ±  2%      -0.1        0.27        perf-profile.self.cycles-pp.__entry_text_start
      0.30 ±  3%      -0.1        0.20 ±  6%      -0.1        0.20 ±  5%      -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.lru_add_fn
      0.28 ±  2%      -0.1        0.20 ±  5%      -0.1        0.20 ±  2%      -0.1        0.20 ±  3%  perf-profile.self.cycles-pp.shmem_fallocate
      0.26 ±  2%      -0.1        0.18 ±  5%      -0.1        0.18 ±  4%      -0.1        0.19 ±  3%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.27 ±  3%      -0.1        0.20 ±  2%      -0.1        0.20 ±  3%      -0.1        0.20 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.21 ±  2%      -0.1        0.15 ±  4%      -0.1        0.15 ±  4%      -0.1        0.16 ±  2%  perf-profile.self.cycles-pp.__alloc_pages
      0.20 ±  2%      -0.1        0.14 ±  3%      -0.1        0.14 ±  2%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.xas_descend
      0.26 ±  3%      -0.1        0.20 ±  4%      -0.1        0.21 ±  3%      -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.find_lock_entries
      0.06 ±  6%      -0.1        0.00            +0.0        0.06 ±  7%      +0.1        0.13 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.18 ±  4%      -0.0        0.13 ±  5%      -0.0        0.13 ±  3%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.xas_clear_mark
      0.15 ±  7%      -0.0        0.10 ± 11%      -0.0        0.11 ±  8%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.shmem_inode_acct_blocks
      0.13 ±  4%      -0.0        0.09 ±  5%      -0.0        0.08 ±  5%      -0.0        0.09        perf-profile.self.cycles-pp.free_unref_page_commit
      0.13            -0.0        0.09 ±  5%      -0.0        0.09 ±  5%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.16 ±  4%      -0.0        0.12 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.16 ±  4%      -0.0        0.12 ±  4%      -0.0        0.11 ±  6%      -0.0        0.11        perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.13 ±  5%      -0.0        0.09 ±  7%      -0.0        0.09            -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.__filemap_remove_folio
      0.13 ±  2%      -0.0        0.09 ±  5%      -0.0        0.09 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.06 ±  7%      -0.0        0.02 ± 99%      -0.0        0.02 ± 99%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.12 ±  4%      -0.0        0.09 ±  5%      -0.0        0.09 ±  5%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.vfs_fallocate
      0.13 ±  3%      -0.0        0.10 ±  5%      -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.fallocate64
      0.11 ±  4%      -0.0        0.07            -0.0        0.08 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.xas_start
      0.07 ±  5%      -0.0        0.03 ± 70%      -0.0        0.04 ± 44%      -0.1        0.02 ±141%  perf-profile.self.cycles-pp.shmem_alloc_folio
      0.14 ±  4%      -0.0        0.10 ±  7%      -0.0        0.10 ±  5%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.10 ±  4%      -0.0        0.06 ±  7%      -0.0        0.06 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.rmqueue
      0.10 ±  4%      -0.0        0.07 ±  8%      -0.0        0.07 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.alloc_pages_mpol
      0.12 ±  3%      -0.0        0.09 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.xas_load
      0.11 ±  4%      -0.0        0.08 ±  7%      -0.0        0.08 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.folio_unlock
      0.15 ±  2%      -0.0        0.12 ±  5%      -0.0        0.12 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.10            -0.0        0.07            -0.0        0.08 ±  7%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.16 ±  2%      -0.0        0.13 ±  6%      -0.0        0.14            -0.0        0.14        perf-profile.self.cycles-pp.page_counter_uncharge
      0.12 ±  5%      -0.0        0.09 ±  4%      -0.0        0.09 ±  7%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__cond_resched
      0.06 ±  6%      -0.0        0.03 ± 70%      -0.0        0.04 ± 44%      -0.0        0.05        perf-profile.self.cycles-pp.filemap_free_folio
      0.12            -0.0        0.09 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.noop_dirty_folio
      0.12 ±  3%      -0.0        0.10 ±  5%      -0.0        0.10 ±  7%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.free_unref_page_list
      0.10 ±  3%      -0.0        0.07 ±  5%      -0.0        0.07 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.filemap_remove_folio
      0.10 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.try_charge_memcg
      0.12 ±  3%      -0.0        0.10 ±  8%      -0.0        0.10            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.09 ±  4%      -0.0        0.07 ±  7%      -0.0        0.07 ±  5%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.08 ±  4%      -0.0        0.06 ±  8%      -0.0        0.06 ±  6%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.08 ±  5%      -0.0        0.06            -0.0        0.06            -0.0        0.06        perf-profile.self.cycles-pp._raw_spin_trylock
      0.08            -0.0        0.06 ±  6%      -0.0        0.06 ±  8%      -0.0        0.06        perf-profile.self.cycles-pp.folio_add_lru
      0.07 ±  5%      -0.0        0.05            -0.0        0.05            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.xas_find_conflict
      0.08 ±  8%      -0.0        0.06 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.56 ±  6%      -0.0        0.54 ±  9%      -0.0        0.55 ±  5%      -0.2        0.40 ±  3%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.08 ± 10%      -0.0        0.06 ±  9%      -0.0        0.06            -0.0        0.06        perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.07 ± 10%      -0.0        0.05            -0.0        0.05 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.xas_init_marks
      0.08 ±  4%      -0.0        0.06 ±  7%      +0.0        0.08 ±  4%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.__percpu_counter_limited_add
      0.07 ±  7%      -0.0        0.05            -0.0        0.05 ±  7%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.07 ±  5%      -0.0        0.06 ±  8%      -0.0        0.06 ±  6%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.07 ±  5%      -0.0        0.06 ±  9%      -0.0        0.06 ±  7%      -0.0        0.06        perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.08 ±  4%      -0.0        0.07 ±  5%      -0.0        0.06            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.filemap_get_entry
      0.00            +0.0        0.00            +0.0        0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.__file_remove_privs
      0.14 ±  2%      +0.0        0.16 ±  6%      +0.0        0.17 ±  3%      +0.0        0.16        perf-profile.self.cycles-pp.uncharge_folio
      0.02 ±141%      +0.0        0.06 ±  8%      +0.0        0.06            +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.uncharge_batch
      0.21 ±  9%      +0.1        0.31 ±  7%      +0.1        0.32 ±  5%      +0.1        0.30 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.69 ±  5%      +0.1        0.83 ±  4%      +0.2        0.86 ±  5%      +0.1        0.79 ±  2%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.06 ±  6%      +0.2        0.22 ±  2%      +0.1        0.13 ±  5%      +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.14 ±  8%      +0.3        0.42 ±  7%      +0.3        0.44 ±  6%      +0.3        0.40 ±  3%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.13 ±  7%      +0.4        0.49 ±  3%      +0.4        0.51 ±  2%      +0.4        0.51 ±  2%  perf-profile.self.cycles-pp.__count_memcg_events
     84.24            +1.0       85.21            +0.8       85.04            +1.0       85.21        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.12 ±  5%      +1.4        2.50 ±  2%      +1.4        2.55 ±  2%      +1.3        2.43        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state


[2]
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-20220510.cgz/lkp-skl-fpga01/fallocate1/will-it-scale

130617edc1cd1ba1 51d74c18a9c61e7ee33bc90b522 c5f50d8b23c7982ac875791755b ac6a9444dec85dc50c6bfbc4ee7
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
  10544810 ± 11%      +1.7%   10720938 ±  4%      +1.7%   10719232 ±  4%     +24.8%   13160448        meminfo.DirectMap2M
      1.87            -0.4        1.43 ±  3%      -0.4        1.47 ±  2%      -0.4        1.46        mpstat.cpu.all.usr%
      3171            -5.3%       3003 ±  2%     +17.4%       3725 ± 30%      +2.6%       3255 ±  5%  vmstat.system.cs
     93.97 ±130%    +360.8%     433.04 ± 83%   +5204.4%       4984 ±150%   +1540.1%       1541 ± 56%  boot-time.boot
      6762 ±101%     +96.3%      13275 ± 75%   +3212.0%     223971 ±150%    +752.6%      57655 ± 60%  boot-time.idle
     84.83 ±  9%     +55.8%     132.17 ± 16%     +75.6%     149.00 ± 11%     +98.0%     168.00 ±  6%  perf-c2c.DRAM.local
    484.17 ±  3%     +37.1%     663.67 ± 10%     +44.1%     697.67 ±  7%      -0.2%     483.00 ±  5%  perf-c2c.DRAM.remote
     72763 ±  5%     +14.4%      83212 ± 12%    +141.5%     175744 ± 83%     +55.7%     113321 ± 21%  turbostat.C1
      0.08           -25.0%       0.06           -27.1%       0.06 ±  6%     -25.0%       0.06        turbostat.IPC
     27.90            +4.6%      29.18            +4.9%      29.27            +3.9%      29.00        turbostat.RAMWatt
   3982212           -30.0%    2785941           -28.9%    2829631           -26.7%    2919929        will-it-scale.52.threads
     76580           -30.0%      53575           -28.9%      54415           -26.7%      56152        will-it-scale.per_thread_ops
   3982212           -30.0%    2785941           -28.9%    2829631           -26.7%    2919929        will-it-scale.workload
 1.175e+09 ±  2%     -28.6%  8.392e+08 ±  2%     -28.2%  8.433e+08 ±  2%     -25.4%  8.762e+08        numa-numastat.node0.local_node
 1.175e+09 ±  2%     -28.6%  8.394e+08 ±  2%     -28.3%  8.434e+08 ±  2%     -25.4%  8.766e+08        numa-numastat.node0.numa_hit
 1.231e+09 ±  2%     -31.3%  8.463e+08 ±  3%     -29.5%  8.683e+08 ±  3%     -27.7%  8.901e+08        numa-numastat.node1.local_node
 1.232e+09 ±  2%     -31.3%  8.466e+08 ±  3%     -29.5%  8.688e+08 ±  3%     -27.7%  8.907e+08        numa-numastat.node1.numa_hit
 2.408e+09           -30.0%  1.686e+09           -28.9%  1.712e+09           -26.6%  1.767e+09        proc-vmstat.numa_hit
 2.406e+09           -30.0%  1.685e+09           -28.9%  1.712e+09           -26.6%  1.766e+09        proc-vmstat.numa_local
 2.404e+09           -29.9%  1.684e+09           -28.8%   1.71e+09           -26.6%  1.765e+09        proc-vmstat.pgalloc_normal
 2.404e+09           -29.9%  1.684e+09           -28.8%   1.71e+09           -26.6%  1.765e+09        proc-vmstat.pgfree
   2302080            -0.9%    2280448            -0.5%    2290432            -1.2%    2274688        proc-vmstat.unevictable_pgs_scanned
     83444 ± 71%     +34.2%     111978 ± 65%      -9.1%      75877 ± 86%     -76.2%      19883 ± 12%  numa-meminfo.node0.AnonHugePages
    150484 ± 55%      +9.3%     164434 ± 46%      -9.3%     136435 ± 53%     -62.4%      56548 ± 18%  numa-meminfo.node0.AnonPages
    167427 ± 50%      +8.2%     181159 ± 41%      -8.3%     153613 ± 47%     -56.1%      73487 ± 14%  numa-meminfo.node0.Inactive
    166720 ± 50%      +8.7%     181159 ± 41%      -8.3%     152902 ± 48%     -56.6%      72379 ± 14%  numa-meminfo.node0.Inactive(anon)
    111067 ± 62%     -13.7%      95819 ± 59%     +14.6%     127294 ± 60%     +86.1%     206693 ±  8%  numa-meminfo.node1.AnonHugePages
    179594 ± 47%      -4.2%     172027 ± 43%      +9.3%     196294 ± 39%     +55.8%     279767 ±  3%  numa-meminfo.node1.AnonPages
    257406 ± 30%      -2.1%     251990 ± 32%      +9.9%     282766 ± 26%     +42.2%     366131 ±  8%  numa-meminfo.node1.AnonPages.max
    196741 ± 43%      -3.6%     189753 ± 39%      +8.1%     212645 ± 36%     +50.9%     296827 ±  3%  numa-meminfo.node1.Inactive
    196385 ± 43%      -3.9%     188693 ± 39%      +8.1%     212288 ± 36%     +51.1%     296827 ±  3%  numa-meminfo.node1.Inactive(anon)
     37621 ± 55%      +9.3%      41115 ± 46%      -9.3%      34116 ± 53%     -62.4%      14141 ± 18%  numa-vmstat.node0.nr_anon_pages
     41664 ± 50%      +8.6%      45233 ± 41%      -8.2%      38240 ± 47%     -56.6%      18079 ± 14%  numa-vmstat.node0.nr_inactive_anon
     41677 ± 50%      +8.6%      45246 ± 41%      -8.2%      38250 ± 47%     -56.6%      18092 ± 14%  numa-vmstat.node0.nr_zone_inactive_anon
 1.175e+09 ±  2%     -28.6%  8.394e+08 ±  2%     -28.3%  8.434e+08 ±  2%     -25.4%  8.766e+08        numa-vmstat.node0.numa_hit
 1.175e+09 ±  2%     -28.6%  8.392e+08 ±  2%     -28.2%  8.433e+08 ±  2%     -25.4%  8.762e+08        numa-vmstat.node0.numa_local
     44903 ± 47%      -4.2%      43015 ± 43%      +9.3%      49079 ± 39%     +55.8%      69957 ±  3%  numa-vmstat.node1.nr_anon_pages
     49030 ± 43%      -3.9%      47139 ± 39%      +8.3%      53095 ± 36%     +51.4%      74210 ±  3%  numa-vmstat.node1.nr_inactive_anon
     49035 ± 43%      -3.9%      47135 ± 39%      +8.3%      53098 ± 36%     +51.3%      74212 ±  3%  numa-vmstat.node1.nr_zone_inactive_anon
 1.232e+09 ±  2%     -31.3%  8.466e+08 ±  3%     -29.5%  8.688e+08 ±  3%     -27.7%  8.907e+08        numa-vmstat.node1.numa_hit
 1.231e+09 ±  2%     -31.3%  8.463e+08 ±  3%     -29.5%  8.683e+08 ±  3%     -27.7%  8.901e+08        numa-vmstat.node1.numa_local
   5256095 ± 59%    +557.5%   34561019 ± 89%   +4549.1%  2.444e+08 ±146%   +1646.7%   91810708 ± 50%  sched_debug.cfs_rq:/.avg_vruntime.avg
   8288083 ± 52%    +365.0%   38543329 ± 81%   +3020.3%  2.586e+08 ±145%   +1133.9%  1.023e+08 ± 49%  sched_debug.cfs_rq:/.avg_vruntime.max
   1364475 ± 40%     +26.7%    1728262 ± 29%    +346.8%    6096205 ±118%    +180.4%    3826288 ± 41%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    161.62 ± 99%     -42.4%      93.09 ±144%     -57.3%      69.01 ± 74%     -86.6%      21.73 ± 10%  sched_debug.cfs_rq:/.load_avg.avg
    902.70 ±107%     -46.8%     480.28 ±171%     -57.3%     385.28 ±120%     -94.8%      47.03 ±  8%  sched_debug.cfs_rq:/.load_avg.stddev
   5256095 ± 59%    +557.5%   34561019 ± 89%   +4549.1%  2.444e+08 ±146%   +1646.7%   91810708 ± 50%  sched_debug.cfs_rq:/.min_vruntime.avg
   8288083 ± 52%    +365.0%   38543329 ± 81%   +3020.3%  2.586e+08 ±145%   +1133.9%  1.023e+08 ± 49%  sched_debug.cfs_rq:/.min_vruntime.max
   1364475 ± 40%     +26.7%    1728262 ± 29%    +346.8%    6096205 ±118%    +180.4%    3826288 ± 41%  sched_debug.cfs_rq:/.min_vruntime.stddev
     31.84 ±161%     -71.8%       8.98 ± 44%     -84.0%       5.10 ± 43%     -79.0%       6.68 ± 24%  sched_debug.cfs_rq:/.removed.load_avg.avg
    272.14 ±192%     -84.9%      41.10 ± 29%     -89.7%      28.08 ± 21%     -87.8%      33.19 ± 12%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    334.70 ± 17%     +32.4%     443.13 ± 19%     +34.3%     449.66 ± 11%     +14.6%     383.66 ± 24%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    322.95 ± 23%     +12.5%     363.30 ± 19%     +27.9%     412.92 ±  6%     +11.2%     359.17 ± 18%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    240924 ± 52%    +136.5%     569868 ± 62%   +2031.9%    5136297 ±145%    +600.7%    1688103 ± 51%  sched_debug.cpu.clock.avg
    240930 ± 52%    +136.5%     569874 ± 62%   +2031.9%    5136304 ±145%    +600.7%    1688109 ± 51%  sched_debug.cpu.clock.max
    240917 ± 52%    +136.5%     569861 ± 62%   +2032.0%    5136290 ±145%    +600.7%    1688095 ± 51%  sched_debug.cpu.clock.min
    239307 ± 52%    +136.6%     566140 ± 62%   +2009.9%    5049095 ±145%    +600.7%    1676912 ± 51%  sched_debug.cpu.clock_task.avg
    239479 ± 52%    +136.5%     566334 ± 62%   +2014.9%    5064818 ±145%    +600.4%    1677208 ± 51%  sched_debug.cpu.clock_task.max
    232462 ± 53%    +140.6%     559281 ± 63%   +2064.0%    5030381 ±146%    +617.9%    1668793 ± 52%  sched_debug.cpu.clock_task.min
    683.22 ±  3%      +0.7%     688.14 ±  4%   +1762.4%      12724 ±138%     +19.2%     814.55 ±  8%  sched_debug.cpu.clock_task.stddev
      3267 ± 57%    +146.0%       8040 ± 63%   +2127.2%      72784 ±146%    +652.5%      24591 ± 52%  sched_debug.cpu.curr->pid.avg
     10463 ± 39%    +101.0%      21030 ± 54%   +1450.9%     162275 ±143%    +448.5%      57391 ± 49%  sched_debug.cpu.curr->pid.max
      3373 ± 57%    +149.1%       8403 ± 64%   +2141.6%      75621 ±146%    +657.7%      25561 ± 52%  sched_debug.cpu.curr->pid.stddev
     58697 ± 14%      +1.6%      59612 ±  7%  +1.9e+05%  1.142e+08 ±156%    +105.4%     120565 ± 32%  sched_debug.cpu.nr_switches.max
      6023 ± 10%     +13.6%       6843 ± 11%  +2.9e+05%   17701514 ±151%    +124.8%      13541 ± 32%  sched_debug.cpu.nr_switches.stddev
    240917 ± 52%    +136.5%     569862 ± 62%   +2032.0%    5136291 ±145%    +600.7%    1688096 ± 51%  sched_debug.cpu_clk
    240346 ± 52%    +136.9%     569288 ± 62%   +2036.8%    5135723 ±145%    +602.1%    1687529 ± 51%  sched_debug.ktime
    241481 ± 51%    +136.2%     570443 ± 62%   +2027.2%    5136856 ±145%    +599.3%    1688672 ± 51%  sched_debug.sched_clk
      0.04 ±  9%     -19.3%       0.03 ±  6%     -19.7%       0.03 ±  6%     -14.3%       0.03 ±  8%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.04 ± 11%     -18.0%       0.03 ± 13%     -22.8%       0.03 ± 10%     -14.0%       0.04 ± 15%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.04 ±  8%     -22.3%       0.03 ±  5%     -19.4%       0.03 ±  3%     -12.6%       0.04 ±  9%  perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      0.91 ±  2%     +11.3%       1.01 ±  5%     +65.3%       1.51 ± 53%     +28.8%       1.17 ± 11%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 13%     -90.3%       0.00 ±223%     -66.4%       0.01 ±101%     -83.8%       0.01 ±223%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     24.11 ±  3%      -8.5%      22.08 ± 11%     -25.2%      18.04 ± 50%     -29.5%      17.01 ± 21%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.14           +15.1%       1.31           -24.1%       0.86 ± 70%     +13.7%       1.29        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    189.94 ±  3%     +18.3%     224.73 ±  4%     +20.3%     228.52 ±  3%     +22.1%     231.82 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1652 ±  4%     -13.4%       1431 ±  4%     -13.4%       1431 ±  2%     -14.3%       1416 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      1628 ±  8%     -15.0%       1383 ±  9%     -16.6%       1357 ±  2%     -16.6%       1358 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
     83.67 ±  7%     -87.6%      10.33 ±223%     -59.2%      34.17 ±100%     -85.5%      12.17 ±223%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      2835 ±  3%     +10.6%       3135 ± 10%    +123.8%       6345 ± 80%     +48.4%       4207 ± 19%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      3827 ±  4%     -13.0%       3328 ±  3%     -12.9%       3335 ±  2%     -14.7%       3264 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.71 ±165%     -83.4%       0.28 ± 21%     -82.3%       0.30 ± 16%     -74.6%       0.43 ± 60%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.43 ± 17%     -43.8%       0.24 ± 26%     -44.4%       0.24 ± 27%     -32.9%       0.29 ± 23%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.46 ± 17%     -36.7%       0.29 ± 12%     -35.7%       0.30 ± 19%     -35.3%       0.30 ± 21%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
     45.41 ±  4%     +13.4%      51.51 ± 12%    +148.6%     112.88 ± 86%     +56.7%      71.18 ± 21%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.30 ± 34%     -90.7%       0.03 ±223%     -66.0%       0.10 ±110%     -88.2%       0.04 ±223%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      2.39           +10.7%       2.65 ±  2%     -24.3%       1.81 ± 70%     +12.1%       2.68 ±  2%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.04 ±  9%     -19.3%       0.03 ±  6%     -19.7%       0.03 ±  6%     -14.3%       0.03 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.04 ± 11%     -18.0%       0.03 ± 13%     -22.8%       0.03 ± 10%     -14.0%       0.04 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.04 ±  8%     -22.3%       0.03 ±  5%     -19.4%       0.03 ±  3%     -12.6%       0.04 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      0.04 ± 11%     -33.1%       0.03 ± 17%     -32.3%       0.03 ± 22%     -16.3%       0.04 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.90 ±  2%     +11.5%       1.00 ±  5%     +66.1%       1.50 ± 53%     +29.2%       1.16 ± 11%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 13%     -26.6%       0.03 ± 12%     -33.6%       0.03 ± 11%     -18.1%       0.04 ± 16%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     24.05 ±  3%      -9.0%      21.90 ± 10%     -25.0%      18.04 ± 50%     -29.4%      16.97 ± 21%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.13           +15.2%       1.30           +15.0%       1.30           +13.7%       1.29        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    189.93 ±  3%     +18.3%     224.72 ±  4%     +20.3%     228.50 ±  3%     +22.1%     231.81 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.71 ±165%     -83.4%       0.28 ± 21%     -82.3%       0.30 ± 16%     -74.6%       0.43 ± 60%  perf-sched.wait_time.max.ms.__cond_resched.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.43 ± 17%     -43.8%       0.24 ± 26%     -44.4%       0.24 ± 27%     -32.9%       0.29 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.46 ± 17%     -36.7%       0.29 ± 12%     -35.7%       0.30 ± 19%     -35.3%       0.30 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      0.31 ± 26%     -42.1%       0.18 ± 58%     -64.1%       0.11 ± 40%     -28.5%       0.22 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     45.41 ±  4%     +13.4%      51.50 ± 12%    +148.6%     112.87 ± 86%     +56.8%      71.18 ± 21%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2.39           +10.7%       2.64 ±  2%     +12.9%       2.69 ±  2%     +12.1%       2.68 ±  2%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.75          +142.0%       1.83 ±  2%    +146.9%       1.86          +124.8%       1.70        perf-stat.i.MPKI
  8.47e+09           -24.4%  6.407e+09           -23.2%  6.503e+09           -21.2%  6.674e+09        perf-stat.i.branch-instructions
      0.66            -0.0        0.63            -0.0        0.64            -0.0        0.63        perf-stat.i.branch-miss-rate%
  56364992           -28.3%   40421603 ±  3%     -26.0%   41734061 ±  2%     -25.8%   41829975        perf-stat.i.branch-misses
     14.64            +6.7       21.30            +6.9       21.54            +6.5       21.10        perf-stat.i.cache-miss-rate%
  30868184           +81.3%   55977240 ±  3%     +87.7%   57950237           +76.2%   54404466        perf-stat.i.cache-misses
 2.107e+08           +24.7%  2.627e+08 ±  2%     +27.6%   2.69e+08           +22.3%  2.578e+08        perf-stat.i.cache-references
      3106            -5.5%       2934 ±  2%     +16.4%       3615 ± 29%      +2.4%       3181 ±  5%  perf-stat.i.context-switches
      3.55           +33.4%       4.74           +31.5%       4.67           +27.4%       4.52        perf-stat.i.cpi
      4722           -44.8%       2605 ±  3%     -46.7%       2515           -43.3%       2675        perf-stat.i.cycles-between-cache-misses
      0.04            -0.0        0.04            -0.0        0.04            -0.0        0.04        perf-stat.i.dTLB-load-miss-rate%
   4117232           -29.1%    2917107           -28.1%    2961876           -25.8%    3056956        perf-stat.i.dTLB-load-misses
 1.051e+10           -24.1%  7.979e+09           -23.0%    8.1e+09           -19.7%   8.44e+09        perf-stat.i.dTLB-loads
      0.00 ±  3%      +0.0        0.00 ±  6%      +0.0        0.00 ±  5%      +0.0        0.00 ±  4%  perf-stat.i.dTLB-store-miss-rate%
 5.886e+09           -27.5%  4.269e+09           -26.3%   4.34e+09           -24.1%  4.467e+09        perf-stat.i.dTLB-stores
     78.16            -6.6       71.51            -6.4       71.75            -5.9       72.23        perf-stat.i.iTLB-load-miss-rate%
   4131074 ±  3%     -30.0%    2891515           -29.2%    2922789           -26.2%    3048227        perf-stat.i.iTLB-load-misses
 4.098e+10           -25.0%  3.072e+10           -23.9%  3.119e+10           -21.6%  3.214e+10        perf-stat.i.instructions
      9929 ±  2%      +7.0%      10627            +7.5%      10673            +6.2%      10547        perf-stat.i.instructions-per-iTLB-miss
      0.28           -25.0%       0.21           -23.9%       0.21           -21.5%       0.22        perf-stat.i.ipc
     63.49           +43.8%      91.27 ±  3%     +48.2%      94.07           +38.6%      87.97        perf-stat.i.metric.K/sec
    241.12           -24.6%     181.87           -23.4%     184.70           -20.9%     190.75        perf-stat.i.metric.M/sec
     90.84            -0.4       90.49            -0.9       89.98            -2.9       87.93        perf-stat.i.node-load-miss-rate%
   3735316           +78.6%    6669641 ±  3%     +83.1%    6839047           +62.4%    6067727        perf-stat.i.node-load-misses
    377465 ±  4%     +86.1%     702512 ± 11%    +101.7%     761510 ±  4%    +120.8%     833359        perf-stat.i.node-loads
   1322217           -27.6%     957081 ±  5%     -22.9%    1019779 ±  2%     -19.4%    1066178        perf-stat.i.node-store-misses
     37459 ±  3%     -23.0%      28826 ±  5%     -19.2%      30253 ±  6%     -23.4%      28682 ±  3%  perf-stat.i.node-stores
      0.75          +141.8%       1.82 ±  2%    +146.6%       1.86          +124.7%       1.69        perf-stat.overall.MPKI
      0.67            -0.0        0.63            -0.0        0.64            -0.0        0.63        perf-stat.overall.branch-miss-rate%
     14.65            +6.7       21.30            +6.9       21.54            +6.5       21.11        perf-stat.overall.cache-miss-rate%
      3.55           +33.4%       4.73           +31.4%       4.66           +27.4%       4.52        perf-stat.overall.cpi
      4713           -44.8%       2601 ±  3%     -46.7%       2511           -43.3%       2671        perf-stat.overall.cycles-between-cache-misses
      0.04            -0.0        0.04            -0.0        0.04            -0.0        0.04        perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  3%      +0.0        0.00 ±  5%      +0.0        0.00 ±  5%      +0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
     78.14            -6.7       71.47            -6.4       71.70            -5.9       72.20        perf-stat.overall.iTLB-load-miss-rate%
      9927 ±  2%      +7.0%      10624            +7.5%      10672            +6.2%      10547        perf-stat.overall.instructions-per-iTLB-miss
      0.28           -25.0%       0.21           -23.9%       0.21           -21.5%       0.22        perf-stat.overall.ipc
     90.82            -0.3       90.49            -0.8       89.98            -2.9       87.92        perf-stat.overall.node-load-miss-rate%
   3098901            +7.1%    3318983            +6.9%    3313112            +7.0%    3316044        perf-stat.overall.path-length
 8.441e+09           -24.4%  6.385e+09           -23.2%   6.48e+09           -21.2%  6.652e+09        perf-stat.ps.branch-instructions
  56179581           -28.3%   40286337 ±  3%     -26.0%   41593521 ±  2%     -25.8%   41687151        perf-stat.ps.branch-misses
  30759982           +81.3%   55777812 ±  3%     +87.7%   57746279           +76.3%   54217757        perf-stat.ps.cache-misses
   2.1e+08           +24.6%  2.618e+08 ±  2%     +27.6%   2.68e+08           +22.3%  2.569e+08        perf-stat.ps.cache-references
      3095            -5.5%       2923 ±  2%     +16.2%       3597 ± 29%      +2.3%       3167 ±  5%  perf-stat.ps.context-switches
    135.89            -0.8%     134.84            -0.7%     134.99            -1.0%     134.55        perf-stat.ps.cpu-migrations
   4103292           -29.1%    2907270           -28.1%    2951746           -25.7%    3046739        perf-stat.ps.dTLB-load-misses
 1.048e+10           -24.1%  7.952e+09           -23.0%  8.072e+09           -19.7%  8.412e+09        perf-stat.ps.dTLB-loads
 5.866e+09           -27.5%  4.255e+09           -26.3%  4.325e+09           -24.1%  4.452e+09        perf-stat.ps.dTLB-stores
   4117020 ±  3%     -30.0%    2881750           -29.3%    2912744           -26.2%    3037970        perf-stat.ps.iTLB-load-misses
 4.084e+10           -25.0%  3.062e+10           -23.9%  3.109e+10           -21.6%  3.203e+10        perf-stat.ps.instructions
   3722149           +78.5%    6645867 ±  3%     +83.1%    6814976           +62.5%    6046854        perf-stat.ps.node-load-misses
    376240 ±  4%     +86.1%     700053 ± 11%    +101.7%     758898 ±  4%    +120.8%     830575        perf-stat.ps.node-loads
   1317772           -27.6%     953773 ±  5%     -22.9%    1016183 ±  2%     -19.4%    1062457        perf-stat.ps.node-store-misses
     37408 ±  3%     -23.2%      28748 ±  5%     -19.3%      30192 ±  6%     -23.5%      28607 ±  3%  perf-stat.ps.node-stores
 1.234e+13           -25.1%  9.246e+12           -24.0%  9.375e+12           -21.5%  9.683e+12        perf-stat.total.instructions
      1.28            -0.4        0.90 ±  2%      -0.4        0.91            -0.3        0.94 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.fallocate64
      1.26 ±  2%      -0.4        0.90 ±  3%      -0.3        0.92 ±  2%      -0.3        0.94 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      1.08 ±  2%      -0.3        0.77 ±  3%      -0.3        0.79 ±  2%      -0.3        0.81 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.92 ±  2%      -0.3        0.62 ±  3%      -0.3        0.63            -0.3        0.66 ±  2%  perf-profile.calltrace.cycles-pp.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.84 ±  3%      -0.2        0.61 ±  3%      -0.2        0.63 ±  2%      -0.2        0.65 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     29.27            -0.2       29.09            -1.0       28.32            -0.2       29.04        perf-profile.calltrace.cycles-pp.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      1.26            -0.2        1.08            -0.2        1.07            -0.2        1.10        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr
      1.26            -0.2        1.08            -0.2        1.07            -0.2        1.10        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change
      1.24            -0.2        1.06            -0.2        1.05            -0.2        1.08        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.shmem_undo_range
      1.23            -0.2        1.06            -0.2        1.05            -0.2        1.08        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      1.24            -0.2        1.06            -0.2        1.05            -0.2        1.08        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
     29.15            -0.2       28.99            -0.9       28.23            -0.2       28.94        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      1.20            -0.2        1.04 ±  2%      -0.2        1.05            -0.2        1.02 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     27.34            -0.1       27.22 ±  2%      -0.9       26.49            -0.1       27.20        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
     27.36            -0.1       27.24 ±  2%      -0.9       26.51            -0.1       27.22        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
     27.28            -0.1       27.17 ±  2%      -0.8       26.44            -0.1       27.16        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
     25.74            -0.1       25.67 ±  2%      +0.2       25.98            +0.9       26.62        perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr.notify_change
     23.43            +0.0       23.43 ±  2%      +0.3       23.70            +0.9       24.34        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.shmem_undo_range
     23.45            +0.0       23.45 ±  2%      +0.3       23.73            +0.9       24.35        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
     23.37            +0.0       23.39 ±  2%      +0.3       23.67            +0.9       24.30        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release
      0.68 ±  3%      +0.0        0.72 ±  4%      +0.1        0.73 ±  3%      +0.1        0.74        perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_list.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
      1.08            +0.1        1.20            +0.1        1.17            +0.1        1.15 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      2.91            +0.3        3.18 ±  2%      +0.3        3.23            +0.1        3.02        perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change.do_truncate
      2.56            +0.4        2.92 ±  2%      +0.4        2.98            +0.2        2.75        perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr.notify_change
      1.36 ±  3%      +0.4        1.76 ±  9%      +0.4        1.75 ±  5%      +0.3        1.68 ±  3%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      2.22            +0.5        2.68 ±  2%      +0.5        2.73            +0.3        2.50        perf-profile.calltrace.cycles-pp.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_setattr
      0.00            +0.6        0.60 ±  2%      +0.6        0.61 ±  2%      +0.6        0.61        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.release_pages.__folio_batch_release.shmem_undo_range.shmem_setattr
      2.33            +0.6        2.94            +0.6        2.96 ±  3%      +0.3        2.59        perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      0.00            +0.7        0.72 ±  2%      +0.7        0.72 ±  2%      +0.7        0.68 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.lru_add_fn.folio_batch_move_lru.folio_add_lru.shmem_alloc_and_add_folio
      0.69 ±  4%      +0.8        1.47 ±  3%      +0.8        1.48 ±  2%      +0.7        1.42        perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio
      1.24 ±  2%      +0.8        2.04 ±  2%      +0.8        2.07 ±  2%      +0.6        1.82        perf-profile.calltrace.cycles-pp.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio.shmem_undo_range
      0.00            +0.8        0.82 ±  4%      +0.8        0.85 ±  3%      +0.8        0.78 ±  2%  perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.17 ±  2%      +0.8        2.00 ±  2%      +0.9        2.04 ±  2%      +0.6        1.77        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.filemap_unaccount_folio.__filemap_remove_folio.filemap_remove_folio.truncate_inode_folio
      0.59 ±  4%      +0.9        1.53            +0.9        1.53 ±  4%      +0.8        1.37 ±  2%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      1.38            +1.0        2.33 ±  2%      +1.0        2.34 ±  3%      +0.6        1.94 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
      0.62 ±  3%      +1.0        1.66 ±  5%      +1.1        1.68 ±  4%      +1.0        1.57 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_commit_charge.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate
     38.70            +1.2       39.90            +0.5       39.23            +0.7       39.45        perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     38.34            +1.3       39.65            +0.6       38.97            +0.9       39.20        perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.24            +1.6       38.86            +0.9       38.17            +1.1       38.35        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     36.64            +1.8       38.40            +1.1       37.72            +1.2       37.88        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      2.47 ±  2%      +2.1        4.59 ±  8%      +2.1        4.61 ±  5%      +1.9        4.37 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fallocate.vfs_fallocate
      1.30            -0.4        0.92 ±  2%      -0.4        0.93            -0.4        0.96        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.28 ±  2%      -0.4        0.90 ±  3%      -0.3        0.93 ±  2%      -0.3        0.95 ±  2%  perf-profile.children.cycles-pp.shmem_alloc_folio
     30.44            -0.3       30.11            -1.1       29.33            -0.4       30.07        perf-profile.children.cycles-pp.folio_batch_move_lru
      1.10 ±  2%      -0.3        0.78 ±  3%      -0.3        0.81 ±  2%      -0.3        0.82 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol
      0.96 ±  2%      -0.3        0.64 ±  3%      -0.3        0.65            -0.3        0.68 ±  2%  perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.88            -0.3        0.58 ±  2%      -0.3        0.60 ±  2%      -0.3        0.62 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.88 ±  3%      -0.2        0.64 ±  3%      -0.2        0.66 ±  2%      -0.2        0.67 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
     29.29            -0.2       29.10            -1.0       28.33            -0.2       29.06        perf-profile.children.cycles-pp.folio_add_lru
      0.61 ±  2%      -0.2        0.43 ±  3%      -0.2        0.44 ±  2%      -0.2        0.45 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      1.26            -0.2        1.09            -0.2        1.08            -0.2        1.10        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.56            -0.2        0.39 ±  4%      -0.2        0.40 ±  3%      -0.2        0.40 ±  3%  perf-profile.children.cycles-pp.free_unref_page_list
      1.22            -0.2        1.06 ±  2%      -0.2        1.06            -0.2        1.04 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.46            -0.1        0.32 ±  3%      -0.1        0.32            -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.41 ±  3%      -0.1        0.28 ±  4%      -0.1        0.28 ±  3%      -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.44 ±  4%      -0.1        0.31 ±  4%      -0.1        0.32 ±  2%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.find_lock_entries
      0.50 ±  3%      -0.1        0.37 ±  2%      -0.1        0.39 ±  4%      -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.24 ±  7%      -0.1        0.12 ±  5%      -0.1        0.13 ±  2%      -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.__list_add_valid_or_report
     25.89            -0.1       25.78 ±  2%      +0.2       26.08            +0.8       26.73        perf-profile.children.cycles-pp.release_pages
      0.34 ±  2%      -0.1        0.24 ±  4%      -0.1        0.23 ±  2%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.38 ±  3%      -0.1        0.28 ±  4%      -0.1        0.29 ±  3%      -0.1        0.28        perf-profile.children.cycles-pp._raw_spin_lock
      0.32 ±  2%      -0.1        0.22 ±  5%      -0.1        0.23 ±  2%      -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.26 ±  2%      -0.1        0.17 ±  2%      -0.1        0.18 ±  3%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.xas_descend
      0.22 ±  3%      -0.1        0.14 ±  4%      -0.1        0.14 ±  3%      -0.1        0.14 ±  2%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.25            -0.1        0.17 ±  3%      -0.1        0.18 ±  4%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.xas_clear_mark
      0.32 ±  4%      -0.1        0.25 ±  3%      -0.1        0.26 ±  4%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.23 ±  2%      -0.1        0.16 ±  2%      -0.1        0.16 ±  4%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.xas_init_marks
      0.24 ±  2%      -0.1        0.17 ±  5%      -0.1        0.17 ±  4%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.25 ±  4%      -0.1        0.18 ±  2%      -0.1        0.18 ±  2%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.30 ±  3%      -0.1        0.23 ±  4%      -0.1        0.22 ±  3%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.filemap_get_entry
      0.20 ±  2%      -0.1        0.13 ±  5%      -0.1        0.13 ±  3%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.folio_unlock
      0.16 ±  4%      -0.1        0.10 ±  5%      -0.1        0.10 ±  7%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.xas_find_conflict
      0.19 ±  3%      -0.1        0.13 ±  5%      -0.0        0.14 ± 12%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.17 ±  5%      -0.1        0.12 ±  3%      -0.1        0.12 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.13 ±  4%      -0.1        0.08 ±  9%      -0.1        0.08 ±  8%      -0.0        0.09        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.18 ±  8%      -0.1        0.13 ±  4%      -0.0        0.13 ±  5%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.shmem_recalc_inode
      0.16 ±  2%      -0.1        0.11 ±  3%      -0.0        0.12 ±  4%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.09 ±  5%      -0.1        0.04 ± 45%      -0.0        0.05            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.10 ±  7%      -0.0        0.05 ± 45%      -0.0        0.06 ± 13%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.14 ±  5%      -0.0        0.10            -0.0        0.10 ±  4%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.14 ±  5%      -0.0        0.10 ±  4%      -0.0        0.10 ±  3%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.security_file_permission
      0.10 ±  5%      -0.0        0.06 ±  6%      -0.0        0.06 ±  7%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.xas_find
      0.15 ±  4%      -0.0        0.11 ±  3%      -0.0        0.11 ±  6%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.12 ±  3%      -0.0        0.09 ±  7%      -0.0        0.09 ±  7%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.12 ±  3%      -0.0        0.09 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.12 ±  3%      -0.0        0.08 ±  5%      -0.0        0.08 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.14 ±  5%      -0.0        0.11 ±  3%      -0.0        0.11 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.file_modified
      0.12 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08 ±  7%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.xas_start
      0.09            -0.0        0.06 ±  8%      -0.0        0.04 ± 45%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.12 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__percpu_counter_limited_add
      0.12 ±  6%      -0.0        0.08 ±  8%      -0.0        0.08 ±  8%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.12 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.inode_add_bytes
      0.20 ±  2%      -0.0        0.17 ±  7%      -0.0        0.17 ±  4%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      0.10 ±  5%      -0.0        0.07 ±  7%      -0.0        0.07 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.policy_nodemask
      0.09 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.09 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06 ±  7%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.filemap_free_folio
      0.07 ±  6%      -0.0        0.05 ±  7%      -0.0        0.06 ±  9%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.down_write
      0.08 ±  4%      -0.0        0.06 ±  8%      -0.0        0.06 ±  9%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.get_task_policy
      0.09 ±  7%      -0.0        0.07            -0.0        0.07 ±  7%      -0.0        0.07        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09 ±  7%      -0.0        0.07            -0.0        0.07 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.09 ±  5%      -0.0        0.07 ±  5%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xas_create
      0.16 ±  2%      -0.0        0.14 ±  5%      -0.0        0.14 ±  2%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.08 ±  7%      -0.0        0.06 ±  9%      -0.0        0.06 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.07 ±  5%      -0.0        0.05 ±  7%      -0.0        0.03 ± 70%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.08 ± 10%      -0.0        0.06 ±  6%      -0.0        0.06 ± 13%      -0.0        0.05        perf-profile.children.cycles-pp.shmem_is_huge
      0.07 ±  6%      +0.0        0.09 ± 10%      +0.0        0.09 ±  5%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.43 ±  3%      +0.0        0.46 ±  5%      +0.0        0.47 ±  3%      +0.0        0.48 ±  2%  perf-profile.children.cycles-pp.uncharge_batch
      0.68 ±  3%      +0.0        0.73 ±  4%      +0.0        0.74 ±  3%      +0.1        0.74        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      1.11            +0.1        1.22            +0.1        1.19            +0.1        1.17 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
      2.91            +0.3        3.18 ±  2%      +0.3        3.23            +0.1        3.02        perf-profile.children.cycles-pp.truncate_inode_folio
      2.56            +0.4        2.92 ±  2%      +0.4        2.98            +0.2        2.75        perf-profile.children.cycles-pp.filemap_remove_folio
      1.37 ±  3%      +0.4        1.76 ±  9%      +0.4        1.76 ±  5%      +0.3        1.69 ±  2%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      2.24            +0.5        2.70 ±  2%      +0.5        2.75            +0.3        2.51        perf-profile.children.cycles-pp.__filemap_remove_folio
      2.38            +0.6        2.97            +0.6        2.99 ±  3%      +0.2        2.63        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.18 ±  4%      +0.7        0.91 ±  4%      +0.8        0.94 ±  4%      +0.7        0.87 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
      1.26            +0.8        2.04 ±  2%      +0.8        2.08 ±  2%      +0.6        1.82        perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.63 ±  2%      +1.0        1.67 ±  5%      +1.1        1.68 ±  5%      +1.0        1.58 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
     38.71            +1.2       39.91            +0.5       39.23            +0.7       39.46        perf-profile.children.cycles-pp.vfs_fallocate
     38.37            +1.3       39.66            +0.6       38.99            +0.8       39.21        perf-profile.children.cycles-pp.shmem_fallocate
     37.28            +1.6       38.89            +0.9       38.20            +1.1       38.39        perf-profile.children.cycles-pp.shmem_get_folio_gfp
     36.71            +1.7       38.45            +1.1       37.77            +1.2       37.94        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      2.58            +1.8        4.36 ±  2%      +1.8        4.40 ±  3%      +1.2        3.74        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      2.48 ±  2%      +2.1        4.60 ±  8%      +2.1        4.62 ±  5%      +1.9        4.38 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.93 ±  3%      +2.4        4.36 ±  2%      +2.5        4.38 ±  3%      +2.2        4.09        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.30            -0.4        0.92 ±  2%      -0.4        0.93            -0.3        0.95        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.73            -0.2        0.52 ±  2%      -0.2        0.53            -0.2        0.54 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.54 ±  2%      -0.2        0.36 ±  3%      -0.2        0.36 ±  3%      -0.2        0.37 ±  2%  perf-profile.self.cycles-pp.release_pages
      0.48            -0.2        0.30 ±  3%      -0.2        0.32 ±  3%      -0.2        0.33 ±  2%  perf-profile.self.cycles-pp.xas_store
      0.54 ±  2%      -0.2        0.38 ±  3%      -0.1        0.39 ±  2%      -0.1        0.39 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      1.17            -0.1        1.03 ±  2%      -0.1        1.03            -0.2        1.00 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.36 ±  2%      -0.1        0.22 ±  3%      -0.1        0.22 ±  3%      -0.1        0.24 ±  2%  perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.43 ±  5%      -0.1        0.30 ±  7%      -0.2        0.27 ±  7%      -0.1        0.29 ±  2%  perf-profile.self.cycles-pp.lru_add_fn
      0.24 ±  7%      -0.1        0.12 ±  6%      -0.1        0.13 ±  2%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.38 ±  4%      -0.1        0.27 ±  4%      -0.1        0.28 ±  3%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.52 ±  3%      -0.1        0.41            -0.1        0.41            -0.1        0.43 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.32 ±  2%      -0.1        0.22 ±  4%      -0.1        0.22 ±  3%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.36 ±  2%      -0.1        0.26 ±  2%      -0.1        0.26 ±  2%      -0.1        0.27        perf-profile.self.cycles-pp.shmem_fallocate
      0.36 ±  4%      -0.1        0.26 ±  4%      -0.1        0.26 ±  3%      -0.1        0.27 ±  3%  perf-profile.self.cycles-pp.find_lock_entries
      0.28 ±  3%      -0.1        0.20 ±  5%      -0.1        0.20 ±  2%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.__alloc_pages
      0.24 ±  2%      -0.1        0.16 ±  4%      -0.1        0.16 ±  4%      -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.xas_descend
      0.09 ±  5%      -0.1        0.01 ±223%      -0.1        0.03 ± 70%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.23 ±  2%      -0.1        0.16 ±  3%      -0.1        0.16 ±  2%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.xas_clear_mark
      0.18 ±  3%      -0.1        0.11 ±  6%      -0.1        0.12 ±  4%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.18 ±  3%      -0.1        0.12 ±  4%      -0.1        0.12 ±  3%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.shmem_inode_acct_blocks
      0.21 ±  3%      -0.1        0.15 ±  2%      -0.1        0.15 ±  2%      -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.shmem_alloc_and_add_folio
      0.18 ±  2%      -0.1        0.12 ±  3%      -0.1        0.12 ±  4%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__filemap_remove_folio
      0.18 ±  7%      -0.1        0.12 ±  7%      -0.0        0.13 ±  5%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.vfs_fallocate
      0.18 ±  2%      -0.1        0.13 ±  3%      -0.1        0.13            -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.folio_unlock
      0.20 ±  2%      -0.1        0.14 ±  6%      -0.1        0.15 ±  3%      -0.1        0.15 ±  6%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.18 ±  2%      -0.1        0.12 ±  3%      -0.1        0.13 ±  3%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.15 ±  3%      -0.1        0.10 ±  7%      -0.0        0.10 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.xas_load
      0.17 ±  3%      -0.1        0.12 ±  8%      -0.1        0.12 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.17 ±  2%      -0.1        0.12 ±  3%      -0.1        0.12 ±  7%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.17 ±  5%      -0.1        0.12 ±  3%      -0.0        0.12 ±  4%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.10 ±  7%      -0.0        0.05 ± 45%      -0.0        0.06 ± 13%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.12 ±  3%      -0.0        0.08 ±  4%      -0.0        0.08            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.rmqueue
      0.06            -0.0        0.02 ±141%      -0.0        0.03 ± 70%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.07 ±  5%      -0.0        0.02 ± 99%      -0.0        0.05            -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.xas_find
      0.13 ±  3%      -0.0        0.09 ±  6%      -0.0        0.10 ±  5%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.alloc_pages_mpol
      0.07 ±  6%      -0.0        0.03 ± 70%      -0.0        0.04 ± 44%      -0.0        0.05        perf-profile.self.cycles-pp.xas_find_conflict
      0.16 ±  2%      -0.0        0.12 ±  6%      -0.0        0.12 ±  3%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.free_unref_page_list
      0.12 ±  5%      -0.0        0.08 ±  4%      -0.0        0.08 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.fallocate64
      0.20 ±  4%      -0.0        0.16 ±  3%      -0.0        0.16 ±  3%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.06 ±  7%      -0.0        0.02 ± 99%      -0.0        0.02 ± 99%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.shmem_recalc_inode
      0.13 ±  3%      -0.0        0.09            -0.0        0.09 ±  6%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.22 ±  3%      -0.0        0.19 ±  6%      -0.0        0.20 ±  3%      -0.0        0.21 ±  4%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.14 ±  3%      -0.0        0.10 ±  6%      -0.0        0.10 ±  8%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.filemap_remove_folio
      0.15 ±  5%      -0.0        0.11 ±  3%      -0.0        0.11 ±  6%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.12 ±  4%      -0.0        0.08            -0.0        0.08 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.11 ±  4%      -0.0        0.08 ±  7%      -0.0        0.08 ±  8%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.11 ±  3%      -0.0        0.08 ±  6%      -0.0        0.07 ±  9%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.xas_start
      0.11 ±  3%      -0.0        0.08 ±  6%      -0.0        0.08 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__percpu_counter_limited_add
      0.12 ±  3%      -0.0        0.09 ±  5%      -0.0        0.08 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.11 ±  5%      -0.0        0.08 ±  4%      -0.0        0.08 ±  6%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.10 ±  6%      -0.0        0.07 ±  5%      -0.0        0.07 ±  7%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.xas_init_marks
      0.09 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.11            -0.0        0.08 ±  5%      -0.0        0.08            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.folio_add_lru
      0.09 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06 ±  7%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.filemap_free_folio
      0.09 ±  4%      -0.0        0.06 ±  6%      -0.0        0.06 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.shmem_alloc_folio
      0.10 ±  4%      -0.0        0.08 ±  4%      -0.0        0.08 ±  6%      -0.0        0.08 ±  7%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.14 ±  5%      -0.0        0.12 ±  5%      -0.0        0.12 ±  3%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.07 ±  7%      -0.0        0.04 ± 44%      -0.0        0.04 ± 44%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.policy_nodemask
      0.07 ± 11%      -0.0        0.04 ± 45%      -0.0        0.05 ±  7%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.shmem_is_huge
      0.08 ±  4%      -0.0        0.06 ±  8%      -0.0        0.06 ±  9%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.get_task_policy
      0.08 ±  6%      -0.0        0.05 ±  8%      -0.0        0.06 ±  8%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__x64_sys_fallocate
      0.12 ±  3%      -0.0        0.10 ±  6%      -0.0        0.10 ±  6%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
      0.07            -0.0        0.05            -0.0        0.05            -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.07 ±  6%      -0.0        0.06 ±  9%      -0.0        0.06 ±  8%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.08 ±  4%      -0.0        0.06            -0.0        0.06 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09 ±  7%      -0.0        0.07 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.filemap_get_entry
      0.07 ±  9%      +0.0        0.09 ± 10%      +0.0        0.09 ±  5%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.96 ±  2%      +0.2        1.12 ±  7%      +0.2        1.16 ±  4%      -0.2        0.72 ±  2%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.45 ±  4%      +0.4        0.82 ±  8%      +0.4        0.81 ±  6%      +0.3        0.77 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      1.36 ±  3%      +0.4        1.75 ±  9%      +0.4        1.75 ±  5%      +0.3        1.68 ±  2%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.29            +0.7        1.00 ± 10%      +0.7        1.01 ±  7%      +0.6        0.93 ±  2%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.16 ±  4%      +0.7        0.90 ±  4%      +0.8        0.92 ±  4%      +0.7        0.85 ±  2%  perf-profile.self.cycles-pp.__count_memcg_events
      1.80 ±  2%      +2.5        4.26 ±  2%      +2.5        4.28 ±  3%      +2.2        3.98        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state




