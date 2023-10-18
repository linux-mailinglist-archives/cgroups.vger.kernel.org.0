Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A987CD64F
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjJRIWo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjJRIWj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 04:22:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C611C;
        Wed, 18 Oct 2023 01:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697617350; x=1729153350;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=10qQzT8Z4OMC89mazo6hvethrMO9wp7k+HYsOTYvnSw=;
  b=Xyi8pwzENpKrJuBsbMqDKkL9zovZSVgFAADXakJXyU02leJhZqD/VEnS
   ipTreN0Ut8CfAxWdgTpdCv3gl9iSA2Tc2WEFf7Jsv0UO1yiNu6bKn2vXe
   dPbfO0K/ZTf6qUvTPHTxuLyVAXSJTPzrRMyko3XPXMacuCfpM2Jh5XhJT
   ag8ZFvU7Jt4qGD0XGY7Zqjk5b7QZzFYp5iepsAN5bAbaBNTlUgOixpRgy
   31h8GewNPxyS0ozf/6DZu9Cn8K41n2h9+ngnPTQuJl4CkDk7WTA/+65hH
   pUqpZXtv3SP7FM3cpKXv7BlCZMKvZOpmvxv3EsKBUKDgTfkN89JMb1oGn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389841478"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="389841478"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 01:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="880136709"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="880136709"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 01:22:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 01:22:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 01:22:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 01:22:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 01:22:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iySpTSk0umRY9srUcoCb3KAqJ5kITO/H2Psx0245pQ6Hce83S3Iv5/BQ5EXo+l8rEofauAZkNZZxsGpDOWTgI+pe05hMnzuNLy/jeGcUXZFkpqC46BqgUg+B3sTXB269ybUNETBBwZcZ2YM2BnmRSk9t8a8SN7+ucVG85GIuWLq8jnC+NRE5MFUqXkKw0r5Wd5qAOf1cr/VutaG2Z5GyWrPr6+JyId90bN1YAUD5hdlLjRfuq4yvJwHS9NgHQM38+FCQefxpeoUt6agOC3NgqhmTJFoIpYdZAfOdwgSW4XjEDTmMULPCQYvvIptoGbabOGyEpXTQviBnH+rcPMOQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmXAnCuaXGrX4SY305m5imab1ILBl7jSnDsDzLQjZ2U=;
 b=IolucB/LggPA2l2cd+/q32BqJIydYbhIwh5f7EF5P8H7+UmlnH9Oa8X9YZTFPF2LGqhw1D81M/UQnIXqgOUdc3qE0ADYDQR5H7qY+8FJnDOQx6hvPNaYZuBuoCIJtzGE2BTNgcOFZ0ZkRWoEk5TuOoOdFVDWRixAwQ5y+IkVDs6u0vn1CK9N0QlwKUmVszeniPKH+2lH2hwHGxAfM+z2989iRpZBKJZ9oTMdnORfoN8P8pMDy3KyIr4g7vR29UKqPSTP78lUh9WP3Xx01FnlByEUAKqFTGvhatVw5WAXhkMVrfX2yU/tgCUcaFVQbnVnADs18VuenYIswORrmGsY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 08:22:16 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Wed, 18 Oct 2023
 08:22:15 +0000
Date:   Wed, 18 Oct 2023 16:22:02 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <michael@phoronix.com>, Feng Tang <feng.tang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "Waiman Long" <longman@redhat.com>, <kernel-team@cloudflare.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
Message-ID: <ZS+VqgmMVStQ9X8m@xsang-OptiPlex-9020>
References: <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
 <CALvZod6zssp88j6e6EKTbu_oHS7iW5ocdTWH7f27Hg0byzut6g@mail.gmail.com>
 <CAJD7tkZbUrs_6r9QcouHNnDbLKiZHdSA=2zyi3A41aqOW6kTNA@mail.gmail.com>
 <CAJD7tkbSwNOZu1r8VfUAD5v-g_NK3oASfO51FJDX4pdMYh9mjw@mail.gmail.com>
 <CALvZod5fWDWZDa=WoyOyckvx5ptjmFBMO9sOG0Sk0MgiDX4DSQ@mail.gmail.com>
 <CAJD7tkY9LrWHX3rjYwNnVK9sjtYPJyx6j_Y3DexTXfS9wwr+xA@mail.gmail.com>
 <CALvZod6cu6verk=vHVFrOUoA-gj_yBVzU9_vv7eUfcjhzfvtcA@mail.gmail.com>
 <CAJD7tkavJDMSZdwtfxUc67mNBSkrz7XCa_z8FGH0FGg6m4RuAA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkavJDMSZdwtfxUc67mNBSkrz7XCa_z8FGH0FGg6m4RuAA@mail.gmail.com>
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|LV2PR11MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c40863-97ca-46dd-487d-08dbcfb355f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuOuAvstxHh4dQ2+ggJ9xGupS9ZK9gFhWtmUmqYkRlU7neX50/9Y/uIOYYZZjRePbN9QhtQttWeJPTgfHCmoMaV4Rb3F2EaiY3rcH2rAnGGB6TefUq76QjMXvXEHSbn7VsY3N9qU99IMIr5HqXjteQHYRPwEJFy4LJSuHwF7mjwaIqp9q2rlqF7UblvC7qLqP+irBsvxLbKsXCVG7+Eti3Lnw22D6dy0oHE2DwwLQR5ArljSrz2FOFNxtI03BMFC9fxN6X3QeTU4AjLGrs0r/zDjU6j1kht4OdLPfE1gF6lHYYcoQKY98Hnrv1TYWXSsfC3UlcOa4cSUvkPXWas/mUX7j5M44003vhB6zDGBWLAD+W5+TjOnny43peVAA16XzZPtNB/i2rWFJPKpJnLYtYbLWvdAwGIhYj1/EwtGIlw5zizZCzg/GloXZA3Wzb6IW1VsUnGqueZ8twI5n6900SLjh5SDZUG8rZQlO7ul/N8qyxbg04nLMY8/7ydKm3yQHuFyFcg3e9W9VbMZgmTuEsweELSf7PqpjVHR/mFHP9UWB8IyISrRmvM/Iy/wflBrnZv1G/9/Mdm1o+QVY9FcdsRsg2ADGizTntagrCy02mvOHKv++i34Qo+9v0VynB41wC5I+DrPCSWA5++4iaA64g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(107886003)(66556008)(66946007)(6486002)(54906003)(6666004)(478600001)(966005)(66476007)(6916009)(83380400001)(38100700002)(6512007)(316002)(26005)(9686003)(86362001)(6506007)(53546011)(82960400001)(41300700001)(5660300002)(7416002)(8936002)(8676002)(33716001)(2906002)(4326008)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWVvRUNtS0pIODZiSHBqVURmQ0JwMVpnaEhMZE1GQzVubHF4ckJpa3ZQQXdl?=
 =?utf-8?B?dENiazVrVm1kR0RUNldGbWhNZXYrSkp3aVNPTXJjSGR4Qzg3bk94QTZqWU10?=
 =?utf-8?B?YjBOTzY2ZThWQkdJNnlTUURIYldIVkNRZ1ZKaDlrWnA3T0JuNDRlc29KZ0N6?=
 =?utf-8?B?M1JFUlNTL0NCbndia2ozdzNSVFBlbS9uTFVTSnVoMEJNOVBUWmd3WXU4ZHpY?=
 =?utf-8?B?bStMMXhnRGhwM1FEV0hWTmU1T3EvZlhDQTcraUJLbysyQ0ZiVGxldDJScDZW?=
 =?utf-8?B?OElXak5lK0lCUGU2Nm5MTEUwekczM01DMmNFUTRjcVlRTHhIbXV0TEc5enZE?=
 =?utf-8?B?WEhEZVF0YWsraW54WWt2TEhTQXkxWnoxKzZiamNXTWh4WEpXam81TFA3eXlh?=
 =?utf-8?B?MmpKOWx1ZCtEZmx0TFZUVk9TbFVyVklnU05lM0dtOFVDbkY0N0EwMkVFenpX?=
 =?utf-8?B?S1l2TWkwQU0rWEFxQTQ3eWFlaXJGTVNFQytDdVFzTElyWTVPbWhNSVJYS3BQ?=
 =?utf-8?B?aDdlOTFaTCs2R2pqZXRHZ0E4c0dnb3JuN1BrR3ZNaEYrRnB6K3VoZzhFVVpK?=
 =?utf-8?B?TW1iQVRTbjVuRWRoMnp5U0I1NVhoanl2RDVLV2RqRDdaNGR2eVJiZnJCTTFQ?=
 =?utf-8?B?ZTJobiszWXY3eWUzYk5CcEN3alZRazBCUkxxR3Y0N2F5NHVpUHZObWdwd1Fw?=
 =?utf-8?B?dlRBcjUydFRFNjI0Wng2RHkvOW1DNDB0Z2kydm96RzcrOWZnOG1xY1Z0U3pv?=
 =?utf-8?B?dDNkUFpKZC84cnUyOFUvOTBTTmNmWEJ6Q05EZmlnTWcwM2hNQlRVbmZDZXpv?=
 =?utf-8?B?ekJtZmtNZ0pqRGUxdEVwdjRUYjNSMnRsZHdPR1FRQlFHNVdEZFpMdTN6c0w3?=
 =?utf-8?B?OTdVYWxqRUlGSmp0NGFQODB0N1p4UTBxcFBlaGVsYzkzS21Cc3FadnI5Zmph?=
 =?utf-8?B?Tm8vb1JpVXcwMHZCK2thSEV3R0x4TG16NXRwamtmOW81YkpTTjA0NUdBRnRX?=
 =?utf-8?B?ZnU1OEdsbGVpblFPenUya3pMOEpaK1VobW8xZHMwdnFkbC96a3FQSHBlTVM3?=
 =?utf-8?B?R0J2ZFRwbmF1c1FpVFNDenBYWjBaeXRmL1E1WDdtMHNnVWJ0VC8xNlRINEZO?=
 =?utf-8?B?M1diNDFLZnlsSUpQNERZc0hDSHdBVVFQRjNyUEpCTlFVSnpmejdqOFJwNE1Z?=
 =?utf-8?B?TzF1dVhpbDBWRUt4KzVuMUFTSXUrZ2VqdGhDbkg4cVU0MUZvbEU3UHZ0YU9K?=
 =?utf-8?B?aEZ6Yk95WllnNy93T2R6VU1WSjhsR0g0Rm1FRFR2emozalVYTHF6WGxveHZs?=
 =?utf-8?B?NFBqZGFjMzk3ei9JNWE5MGdNSFdtTFEwWDBwWnBBVlhpTUd0UDFaMElwc2o1?=
 =?utf-8?B?OHpqeUFWelRWKzRTWk9tMXpUdzBpMUI4S1dzMkk0NkZ5QnR5YkpCbHFDL0Mv?=
 =?utf-8?B?citTRVlxaXJFNFNnWElsYStZMm85aWlybUxqenhHdllJZmN6WFJSZkoyS3hz?=
 =?utf-8?B?clJ5OThMZVVTNHhYbkt0TzVRb2xNZDFLWkRycGtIN1ppdjBzNmFSdGs2ZjVo?=
 =?utf-8?B?NllrR0tIRThpd2VFWDR5TDVSN2ZhOFAwdmJOQ2NYYUJ1dEFvYTZTcWh6Z3Z2?=
 =?utf-8?B?eS95MitwbFB2TnFaTW5tejBlRTVaNmNiUlhnK1pwVlh2WlJYeXhZVS9OcTg1?=
 =?utf-8?B?MXJ0UCs0ZEI0dndXMFZrOXJiWStIeUU3L3VUbFNkMDRqcmovNHBDeXhlOHpq?=
 =?utf-8?B?SVE2REIxYTNRWG50MTVnS3JrRGdvZXY5Z1FQeW1OUEtvTmlER2tURzY0d3Jm?=
 =?utf-8?B?c1JtcWM3MVoxb1NRZWM2ZnFLN3BTZ00vS0xFdSszQzZQeThvVmJUWVI5eFEy?=
 =?utf-8?B?Rm9yMXNqc2R0WnVoaGFaV216WFlzSlpQYnZQRTllaXVkLzV2eDBUVkNzbzJZ?=
 =?utf-8?B?SnJwZUZZMldXcGFVUkRqOTVrWG9oUmhKaWZ0dkt4MXNZN25vZGZnaysvcXJn?=
 =?utf-8?B?YXorN3dJWXVNaHFCdGJ5T2lYRTFHNTNTeFVCNHFxa0xzV1dVVXBpWXdWNnQ0?=
 =?utf-8?B?SHZmYmp5Z21JSkZDb2FyT1BhQXBoWGc2NmRIQVRuWk16OFgxUEExVlNKdWp4?=
 =?utf-8?B?b2c4aVUwNXNGY2gvNnhOV2l4Sm1kLzdYTVIzelk4VHVIWUJ4Q094cVdHT1oz?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c40863-97ca-46dd-487d-08dbcfb355f4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:22:15.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nzj48W9dlcCPMQoamm/AsvfgLO/SIN+OyFLeEM5iv4262ULun7Hoas6GkfB0I4N2cvTBEFKBaemELUOejKe2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

hi, Yosry Ahmed, hi, Shakeel Butt,

On Thu, Oct 12, 2023 at 03:23:06PM -0700, Yosry Ahmed wrote:
> On Thu, Oct 12, 2023 at 2:39 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Thu, Oct 12, 2023 at 2:20 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > [...]
> > > >
> > > > Yes this looks better. I think we should also ask intel perf and
> > > > phoronix folks to run their benchmarks as well (but no need to block
> > > > on them).
> > >
> > > Anything I need to do for this to happen? (I thought such testing is
> > > already done on linux-next)
> >
> > Just Cced the relevant folks.
> >
> > Michael, Oliver & Feng, if you have some time/resource available,
> > please do trigger your performance benchmarks on the following series
> > (but nothing urgent):
> >
> > https://lore.kernel.org/all/20231010032117.1577496-1-yosryahmed@google.com/
> 
> Thanks for that.

we (0day team) have already applied the patch-set as:

c5f50d8b23c79 (linux-review/Yosry-Ahmed/mm-memcg-change-flush_next_time-to-flush_last_time/20231010-112257) mm: memcg: restore subtree stats flushing
ac8a48ba9e1ca mm: workingset: move the stats flush into workingset_test_recent()
51d74c18a9c61 mm: memcg: make stats flushing threshold per-memcg
130617edc1cd1 mm: memcg: move vmstats structs definition above flushing code
26d0ee342efc6 mm: memcg: change flush_next_time to flush_last_time
25478183883e6 Merge branch 'mm-nonmm-unstable' into mm-everything   <---- the base our tool picked for the patch set

they've already in our so-called hourly-kernel which under various function
and performance tests.

our 0day test logic is if we found any regression by these hourly-kernels
comparing to base (e.g. milestone release), auto-bisect will be triggnered.
then we only report when we capture a first bad commit for a regression.

based on this, if you don't receive any report in following 2-3 weeks, you
could think 0day cannot capture any regression from your patch-set.

*However*, please be aware that 0day is not a traditional CI system, and also
due to resource constraints, we cannot guaratee coverage, we cannot tigger
specific tests for your patchset, either.
(sorry if this is not your expectation)


> 
> >
> > >
> > > Also, any further comments on the patch (or the series in general)? If
> > > not, I can send a new commit message for this patch in-place.
> >
> > Sorry, I haven't taken a look yet but will try in a week or so.
> 
> Sounds good, thanks.
> 
> Meanwhile, Andrew, could you please replace the commit log of this
> patch as follows for more updated testing info:
> 
> Subject: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
> 
> A global counter for the magnitude of memcg stats update is maintained
> on the memcg side to avoid invoking rstat flushes when the pending
> updates are not significant. This avoids unnecessary flushes, which are
> not very cheap even if there isn't a lot of stats to flush. It also
> avoids unnecessary lock contention on the underlying global rstat lock.
> 
> Make this threshold per-memcg. The scheme is followed where percpu (now
> also per-memcg) counters are incremented in the update path, and only
> propagated to per-memcg atomics when they exceed a certain threshold.
> 
> This provides two benefits:
> (a) On large machines with a lot of memcgs, the global threshold can be
> reached relatively fast, so guarding the underlying lock becomes less
> effective. Making the threshold per-memcg avoids this.
> 
> (b) Having a global threshold makes it hard to do subtree flushes, as we
> cannot reset the global counter except for a full flush. Per-memcg
> counters removes this as a blocker from doing subtree flushes, which
> helps avoid unnecessary work when the stats of a small subtree are
> needed.
> 
> Nothing is free, of course. This comes at a cost:
> (a) A new per-cpu counter per memcg, consuming NR_CPUS * NR_MEMCGS * 4
> bytes. The extra memory usage is insigificant.
> 
> (b) More work on the update side, although in the common case it will
> only be percpu counter updates. The amount of work scales with the
> number of ancestors (i.e. tree depth). This is not a new concept, adding
> a cgroup to the rstat tree involves a parent loop, so is charging.
> Testing results below show no significant regressions.
> 
> (c) The error margin in the stats for the system as a whole increases
> from NR_CPUS * MEMCG_CHARGE_BATCH to NR_CPUS * MEMCG_CHARGE_BATCH *
> NR_MEMCGS. This is probably fine because we have a similar per-memcg
> error in charges coming from percpu stocks, and we have a periodic
> flusher that makes sure we always flush all the stats every 2s anyway.
> 
> This patch was tested to make sure no significant regressions are
> introduced on the update path as follows. The following benchmarks were
> ran in a cgroup that is 2 levels deep (/sys/fs/cgroup/a/b/):
> 
> (1) Running 22 instances of netperf on a 44 cpu machine with
> hyperthreading disabled. All instances are run in a level 2 cgroup, as
> well as netserver:
>   # netserver -6
>   # netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K
> 
> Averaging 20 runs, the numbers are as follows:
> Base: 40198.0 mbps
> Patched: 38629.7 mbps (-3.9%)
> 
> The regression is minimal, especially for 22 instances in the same
> cgroup sharing all ancestors (so updating the same atomics).
> 
> (2) will-it-scale page_fault tests. These tests (specifically
> per_process_ops in page_fault3 test) detected a 25.9% regression before
> for a change in the stats update path [1]. These are the
> numbers from 10 runs (+ is good) on a machine with 256 cpus:
> 
>                LABEL            |     MEAN    |   MEDIAN    |   STDDEV   |
> ------------------------------+-------------+-------------+-------------
>   page_fault1_per_process_ops |             |             |            |
>   (A) base                    | 270249.164  | 265437.000  | 13451.836  |
>   (B) patched                 | 261368.709  | 255725.000  | 13394.767  |
>                               | -3.29%      | -3.66%      |            |
>   page_fault1_per_thread_ops  |             |             |            |
>   (A) base                    | 242111.345  | 239737.000  | 10026.031  |
>   (B) patched                 | 237057.109  | 235305.000  | 9769.687   |
>                               | -2.09%      | -1.85%      |            |
>   page_fault1_scalability     |             |             |
>   (A) base                    | 0.034387    | 0.035168    | 0.0018283  |
>   (B) patched                 | 0.033988    | 0.034573    | 0.0018056  |
>                               | -1.16%      | -1.69%      |            |
>   page_fault2_per_process_ops |             |             |
>   (A) base                    | 203561.836  | 203301.000  | 2550.764   |
>   (B) patched                 | 197195.945  | 197746.000  | 2264.263   |
>                               | -3.13%      | -2.73%      |            |
>   page_fault2_per_thread_ops  |             |             |
>   (A) base                    | 171046.473  | 170776.000  | 1509.679   |
>   (B) patched                 | 166626.327  | 166406.000  | 768.753    |
>                               | -2.58%      | -2.56%      |            |
>   page_fault2_scalability     |             |             |
>   (A) base                    | 0.054026    | 0.053821    | 0.00062121 |
>   (B) patched                 | 0.053329    | 0.05306     | 0.00048394 |
>                               | -1.29%      | -1.41%      |            |
>   page_fault3_per_process_ops |             |             |
>   (A) base                    | 1295807.782 | 1297550.000 | 5907.585   |
>   (B) patched                 | 1275579.873 | 1273359.000 | 8759.160   |
>                               | -1.56%      | -1.86%      |            |
>   page_fault3_per_thread_ops  |             |             |
>   (A) base                    | 391234.164  | 390860.000  | 1760.720   |
>   (B) patched                 | 377231.273  | 376369.000  | 1874.971   |
>                               | -3.58%      | -3.71%      |            |
>   page_fault3_scalability     |             |             |
>   (A) base                    | 0.60369     | 0.60072     | 0.0083029  |
>   (B) patched                 | 0.61733     | 0.61544     | 0.009855   |
>                               | +2.26%      | +2.45%      |            |
> 
> All regressions seem to be minimal, and within the normal variance for
> the benchmark. The fix for [1] assumes that 3% is noise -- and there were no
> further practical complaints), so hopefully this means that such variations
> in these microbenchmarks do not reflect on practical workloads.
> 
> (3) I also ran stress-ng in a nested cgroup and did not observe any
> obvious regressions.
> 
> [1]https://lore.kernel.org/all/20190520063534.GB19312@shao2-debian/
