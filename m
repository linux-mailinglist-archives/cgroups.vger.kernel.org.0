Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FA257E61C
	for <lists+cgroups@lfdr.de>; Fri, 22 Jul 2022 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiGVR6E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Jul 2022 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiGVR6D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Jul 2022 13:58:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B65A14B;
        Fri, 22 Jul 2022 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658512682; x=1690048682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xW2SYVOgh4nIyD0QWhReFtVoFFXTUHDlPI8kPQCqskY=;
  b=CjMmDdiHe81cMSlA0BTyST43kDIJOD7OUaq+lRvMc9jxc167AA2a5xPL
   8JNyK+xsDItk9v/pIqoiQcSQuh03PwpZGZ3JL735x9VlrXRJNnlvgNS6B
   /oK/J8e8KRLI0GD998Und+yyDTtKPnNRsQ6dBwSX+yijYXEFOpf24EWml
   6omqJTB/cdb8sgDnjC/T6O6ajt1fkXUOYFkbnwrrDzWwVeZUVa85YI0px
   EBUNNrqvMaeYBmsJK90EXV3jgaIGgSmReP6AoEMbmpUUPZBhVSheZahqH
   fjp0iu3z7NE4gH3EO0yb6jL91jHVAS1wxIcuj/MI142pa6sd97sYnOu8b
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="286134671"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="286134671"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 10:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="725497569"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 22 Jul 2022 10:57:59 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 10:57:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 10:57:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 22 Jul 2022 10:57:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 22 Jul 2022 10:57:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff8b5VjiPQ7Lr1+NoEv3rDVAxaGPJ7by6mT07lYknob1MNOMzetwyQveHsP4QHCDssjdT/SjRZaFuO82sHr0N6zfi41usG43R0W7nOyFomPuh/XWQEcy1Ai97xRklkRak1QhGO0H6wM8yEhGj0L41YhGnilfd3V1grQ1LIdkxhsNInj5Enw8UjpxlobggkPB2KuualSSDK1XQBp4NFGJ+sN2CjQLQX1d+1WY2YdHUjSiRbyYZlQ7lvaE1PbkN7PYN7guNAmn3Jp8qj7TuVakR/pQfxf+5B6Ghi+294SqAYJ0P7BsBPd7BZTAQfZVTLwKzsYWuPVRpbBSMEnTPnWThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW2SYVOgh4nIyD0QWhReFtVoFFXTUHDlPI8kPQCqskY=;
 b=W22mju6Gw9z3EQaSO9blk4OeZjFYrA4YO63CPHd6r426T2UjDSk4ZT8SLLoSdFjrQTpBwb86h3zPHKTDiY0TAJIaK/uuluB0nt4O46QB6WYGacesb+JlGXS7ictndXKE7koAbppppuf8goVNtEOnuns31AZOjr/d2K2uQsp6wzXYWjGce/zmUdzWHiBnUypldpShukGA+TIM2knPXej2KZuXFWrv5tu/3LrYD3PBnXyVrGcCuPxvZb1HgB0O/f3ycqCYuROs0oYtbYEaGoQ7XT2GRO9XeEnPNpBrwgxT0fFXL+JgQD4VaiKUSC1P88VOoPkyfpP6+IqPPNrK4N/TQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4107.namprd11.prod.outlook.com (2603:10b6:5:198::24)
 by SJ0PR11MB5005.namprd11.prod.outlook.com (2603:10b6:a03:2d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 17:57:56 +0000
Received: from DM6PR11MB4107.namprd11.prod.outlook.com
 ([fe80::fc6e:95eb:15c0:847c]) by DM6PR11MB4107.namprd11.prod.outlook.com
 ([fe80::fc6e:95eb:15c0:847c%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 17:57:56 +0000
From:   "Chen, Tim C" <tim.c.chen@intel.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        "Sun, Jiebin" <jiebin.sun@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "amadeuszx.slawinski@linux.intel.com" 
        <amadeuszx.slawinski@linux.intel.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "Guo, Wangyang" <wangyang.guo@intel.com>
Subject: RE: [PATCH] mm: Remove the redundant updating of
 stats_flush_threshold
Thread-Topic: [PATCH] mm: Remove the redundant updating of
 stats_flush_threshold
Thread-Index: AQHYnaWE7yyZOgM2eEyGrUJNmSgBKa2Kn0CAgAAOJCA=
Date:   Fri, 22 Jul 2022 17:57:56 +0000
Message-ID: <DM6PR11MB410736BFD198D38BBCE9E064DC909@DM6PR11MB4107.namprd11.prod.outlook.com>
References: <20220722164949.47760-1-jiebin.sun@intel.com>
 <YtrY5V+dZl4+Gtz4@castle>
In-Reply-To: <YtrY5V+dZl4+Gtz4@castle>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58dc55e7-ad14-4f38-9c2d-08da6c0bb52a
x-ms-traffictypediagnostic: SJ0PR11MB5005:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3blp/63hNoUdwfKVFBEmGqAZdKhG5R6ZPvJlSPIVZ/Pl+0iW9LVTobDqv8+NdX4dUcnoxUSzYgg+Ufuj0zT7eBtPhkNmnko3IuN/5FF8llre0lqj8iBb12CRecSiNHDH9PJkhR63Koo5VXNLm1na8iBdtGeUHcyhjvYFlRFyvBR8onAciWQoGG0wtX9nXD/+BFTqX70FXDIrFTIkwp4AOk40X7cKDupnlmZHJ3LQzlqxy8ZflDnvl4BXQv8seuDU7sbnXMvHReE9Q8ySM4WyIdor8b1f9cJqGMQnBKl0q8vB65cDLmZfmbvZiGQ6COXdrEppD0JU/Pr+GKfbCQSj41jEFfqr43c5xjimUkGUCyl4ArJwoPC+d4Nc0fuos+VayNkGEBWMr3GFvQEzIb4IBRNMGNi9MmQ12JDLuz+qoZGjA9Fzjbl8ny3ogo1+aCvUZypITp+ncodabZOkItS6aQYMtEjbeMcwKZnA5hHbyIFBHgLawP9K+WiOeh8hXOK7oKxGRlGQYpIU2K8HMX8dqoiih25Lj1NQOYLPOL79X+obf2Xs+Q+rAjq/TEuM0jeszeviiFY76exFrAYjFHdER8hODgceRAE45BhzLa1888h5kbweYp+o+j3FLa5UoKjmSZibbqEYOr2QwRvOizJYelwSG6f1nSXYBeL5Nz4hvkXiYy3cv6UwxZRdp6WR35eaE+Kk0FHacC+NeyjIp5B7ESkDqA4tzKXr3K5CHTGYuNRwN/zG1Wx6nGVPBVTIbhYgNNcwesEYCuHk4wV5kzmSvtZrtvjHUYWtAMY+7KqH8mvKF5R2UMGvP+THuGq8qoPq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(136003)(366004)(346002)(54906003)(6636002)(110136005)(41300700001)(316002)(71200400001)(38100700002)(478600001)(122000001)(83380400001)(26005)(38070700005)(7696005)(6506007)(9686003)(82960400001)(186003)(4744005)(2906002)(5660300002)(52536014)(33656002)(7416002)(8936002)(76116006)(66476007)(66446008)(66946007)(4326008)(86362001)(66556008)(64756008)(8676002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vXeCIb3tu05ao2n5HtsVg45Ma/6NJ2s0OaTJzJBD55Lozj0z6OFFGtvtQr9I?=
 =?us-ascii?Q?7v+V2ClEOS1G+j0QjyKN5MbNq1GMnrT43V4MGD3eaIJ4z5ODYUlpvJLYMF5V?=
 =?us-ascii?Q?JjAuCMKYOVDsYpbkwTzNupYEc14iN1Zb3Uzjx/fzCIOZ8ySYb1N+sVeE0x7K?=
 =?us-ascii?Q?ZpZetihoNHDCwto+wl7TD+xQ7ncl0HzZUgyOimOPmZQVzzEBdVZ6ozMRTlNB?=
 =?us-ascii?Q?a1FBlQ4Zq0Zv8zT3KNcMtGgc5aPefqgRIMN3f99uE0r+NheTu31jBafRstVS?=
 =?us-ascii?Q?8BKcnVWSLeYEGjFBJXC66aM2ixZZhWRByAlhuBTJ6iCwt2T9eqxurV0wDGMh?=
 =?us-ascii?Q?LHsBcAQAjKJlo/inVhPVbOItIPF+Q8PW7yvXje2bKnDh5qlNaPvrLhSJt9Hl?=
 =?us-ascii?Q?DFnqDsJ1q9XquIg56MEZyFXjBGWq+b9FW+BGnDch8qemUgw5WFM+saeWl8KH?=
 =?us-ascii?Q?1AIgZYC2R7ejt+U8WFi845IGBKkQn9CNuF/gyHp5p4uT0zltxfg5WdX+vNvr?=
 =?us-ascii?Q?QZY1EScd7Oew6d94GJlymkhcudIGk1V39QeFPT2oEA7FrpMF1cAiHatdUgYS?=
 =?us-ascii?Q?nBS/x6EoKSUtYWLavjfdVYEaSdOoFoYciivUj3OYgF+3n23x4qRWDTeAmZAc?=
 =?us-ascii?Q?RBy1K2MaBNtHWjxUXANmfdvSj2cxFXvXHDXWOIyGlO8CfLTB4MppFgGRWBzB?=
 =?us-ascii?Q?+2Z5HFzskMuX0fKdFl6h8GJJrpsknwq3CmJ+hXI3t2AsmRw8JI9iHO4u+X8U?=
 =?us-ascii?Q?VRt3w9UmqoT8mYzKizCaVzBElkx8aKeN2qtOEOL08kFvmqJqHvy5XcESS9nJ?=
 =?us-ascii?Q?/tsZQ/12Oafh5exfN68NM7nS90wFLugtZumtX6ADZgtKb3+DJPFMEPPFxisJ?=
 =?us-ascii?Q?78NY1HlscA8VBJlMcy0ncH0fNj9rZhFcQLny0Mx/j0hZq4igWOlufvySOMJO?=
 =?us-ascii?Q?E45GWx1ShGW7US4SWjbhEjbcPDEf5gMK7i5JS74DrvHNE9uRk8Xljan1yzoq?=
 =?us-ascii?Q?AojUpDSL6sxRb7UL1AzHePfd2+3LuFjs3XLCHeKlcmf+nS4r8tctS2+4LmO7?=
 =?us-ascii?Q?sFGs7dUNnngJ31Leq1SgDDLJpKV2GXM6HDKAyZs88JrFHarQ7pmu4NybIYcE?=
 =?us-ascii?Q?+zKlWNnBhN+O93aBKPxXEAe7+455KzMO4sBE9wxKmw8PwAeoIP0YdZNZxq/A?=
 =?us-ascii?Q?beWux2pwil1TEet9MZZnuXIOUoD1GsAYJySSmeJwCx+o80eR/PY9gmu30P9B?=
 =?us-ascii?Q?My+ep2PZ01TWKFYncwmnsQHRkhlGHGqjDdGfzSHZZ687KgOp1H/kvfqJIHNF?=
 =?us-ascii?Q?qB6Um7S5A72AFIwaCFkV3JN/P2HYgHEZKc8KgG8UGMKpwFdDlCRXokGVJ7Fv?=
 =?us-ascii?Q?r+q4fKUEJtHAjTJqOBWzl6g1pWW9p+N9CkaygUM3KHnOzuBKvAsxrvwuxN42?=
 =?us-ascii?Q?FbCEWaDr4KTEeC2fHrjCKdUHsIP16jqmd4maBuy0Mj70SQE6FCBPzaT9jNAI?=
 =?us-ascii?Q?VUTZOrwPYKbCh4pu/a74md8K0jRuFLR8BiLNvLO25DMfZXM1JmlCIfwzk8G9?=
 =?us-ascii?Q?VZuC+dJ5DHvXdBeZ0MsdGnDyvYURykHT3n1ACW1S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dc55e7-ad14-4f38-9c2d-08da6c0bb52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 17:57:56.5942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojLXAPWEs7066FiQLOCmFHCU1LOVSipe0KfIZ8Hyh0nwzgj8o+WAaLdAIDEs5+nGzHbX07Pb/mijmo7QqX6b5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5005
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

>
>On Sat, Jul 23, 2022 at 12:49:49AM +0800, Jiebin Sun wrote:
>> From: jiebin sun <jiebin.sun@intel.com>
>>
>> Remove the redundant updating of stats_flush_threshold. If the global
>> var stats_flush_threshold has exceeded the trigger value for
>> __mem_cgroup_flush_stats, further increment is unnecessary.
>>
>> Apply the patch and test the pts/hackbench-1.0.0 Count:4 (160 threads).
>>
>> Score gain: 1.95x
>> Reduce CPU cycles in __mod_memcg_lruvec_state (44.88% -> 0.12%)
>>
>> CPU: ICX 8380 x 2 sockets
>> Core number: 40 x 2 physical cores
>> Benchmark: pts/hackbench-1.0.0 Count:4 (160 threads)
>>
>> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
>
>Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
>
>Good optimization, thanks!

Looks good. Nice performance improvement.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
