Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2BD7BF025
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 03:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378608AbjJJBSI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 21:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378034AbjJJBSG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 21:18:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B544691;
        Mon,  9 Oct 2023 18:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696900685; x=1728436685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5Bg+tAVSUFTf/wOoHqcuOBdRwfRC6cuRAuGEzRZjJK0=;
  b=EdLvRzMMbCWlx+gJJlKiAM3XjVqKUq6GHcvgDbiOUlo3s3rGZo8elUtA
   AYsgYNV+B3NDj+XbXlLAX1A/0SrD2quSJ7hyo1sfMbA42WMQxKXOpwcRJ
   NjIpy5CXvviag0Kd+kLBPfHI5B20pzV5f3PjKc/pseU0cLqtAgd1X2v11
   albVhJz8MTgVkA+en/y1K2WIcj0TCT4K5RCfWC41AgdT5pqFKc2bavhdF
   8OSDMlsC5fV+Lqt/wXDXUc/kQjepXgnzP5HJulmT6ytS5cnbneBqjnLyq
   8UQv9NkpiZr5wh/syqdAp1NuS8JJoTTSgQj1zfeXQc6Y7p55JJWCktG54
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415281931"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="415281931"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 18:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="896974615"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="896974615"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 18:16:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 18:18:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 18:18:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 18:18:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 18:18:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDAloZB8QTJmmGdKvjazN0wMa13G8ooziblrGAVpgiRSGtOPsT1vkCNyZ3fW3PIZVpBlL0AHY/VF1GZFDWqv9K4qca/3U6mipX3ksaSiUZK5utLQP8hBO/RQKsf62qIu/BUvX3cs+lIcSEglJmwQzUNPhI4qpMUpUuFGuFp3rdzTDMQbw47W6OmW2yEGQRzwOLSjeU/K+C/+GHRvIQ55c5ok24k7Fa2OUj+NsYbo9kuFbBnJVXD9FFS5BtqUJd6qYO9zLSsJ23K8CR1kWy7ooCTCmy9RrTrYCdE5Yj6y1MkzMaHPkwePrXfz/XonUWurf6kAuidcNyfYV/rpgtE8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Bg+tAVSUFTf/wOoHqcuOBdRwfRC6cuRAuGEzRZjJK0=;
 b=NtWavDJipKpZvqsr4T3+EcO7N0qkVQU7kgSa1Z3NmyJrDfQA4rYP8IdSqO9BmLerDYd1VovMs+l8lSEQYE+EJ7a/8sx/YoU17S57vFwkS4b4kn5PRZmy0QoqjKHaA9lCLmf4F/XY+qGNkH4R7yEKB/Rd5UP/wJWVHuYrjagyT+ThCm+lsJ1VQuSA145A+7m+UU/TPiy/pz9EB28/uhN2dDyM2ymYemJRAhA3SMCg1ZxMyUY3caygFVQWqTCLAUDRw7bCZDFLiCAKbu3WOiSvIiifKvZdrGambCTGe6jSZtG1G6DCTtIqbeanSNZ7+Sf9rXlNH29p6L6CoBy18qM7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6095.namprd11.prod.outlook.com (2603:10b6:8:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 01:18:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 01:18:00 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Zhang, Bo" <zhanb@microsoft.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Topic: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAWUQCAAAOmAA==
Date:   Tue, 10 Oct 2023 01:18:00 +0000
Message-ID: <fc6aa778ddbde9536cafe48b847cf6c45b640ea4.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <op.2ckqmgs9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2ckqmgs9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6095:EE_
x-ms-office365-filtering-correlation-id: 6038e41b-8ac2-41ee-0f6b-08dbc92ebe9e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RNy46ePo+htlUDczISaKD5RoVjqBAe/Iod7AV7YvvMgzy8pOwN7J1j5yzi6kjFZq1FeZN2F6LyUalWmtf12QP5wf85sktJJpMF4+QqObMc7u5/xjteDvdFln2W1xc/RN0QjLJA/C1IoYHkA0RPU9ZYsc4PV6oVsViwwaxWhf3TlLtk8AdxeCQF9CXispadtQEtkPqAXR0uiy9SR2mRSpBm8t/il946/txGC2qTXWGXwfA5OIPlYFP44g+lLXU5MiExzz3nXntvjD0DXi9nrCtQb0/TK2O3NJgPSgJ33xikSe+qMpMjunncfUlXaXmGnHyXf9rHYYfFdnCzORLtlDcYLskDMrb+Xbw/bR3DmbRUw6LqW8ZNZzvuqrcW6cmBWJVyNbCoAz27KuZzDquVoQ2x5hMi31lSgSCznjnDMC8xSq9X343Y8uwKv0f8mYBHrmLz0ywOOVM9voZwZlNNaKdwhMI/IWhDJVEVezBYzuvXt7I3MhPvw/Hoclj/8xpf0/msPfHlwa7mN9ZbBCpaOGbNle+6mSoIDAti1KZ/qFASSlAU5foQum3MiM8b2ys72mv4Z2M3PLal51VhWN1DNwWRaEE0OXayeraQdXb7Uaca3FEDhfyFpqwNhGpSszDkIp7l1RG9z3N9nQ0xGpzJ/YGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(26005)(71200400001)(38070700005)(86362001)(36756003)(82960400001)(122000001)(921005)(38100700002)(83380400001)(4326008)(2906002)(7416002)(6506007)(6512007)(8676002)(478600001)(41300700001)(6486002)(316002)(8936002)(5660300002)(6636002)(66446008)(66946007)(66476007)(54906003)(76116006)(64756008)(66556008)(110136005)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXNSSmlMVW5uWGptam1wenlsb0NHclgxMVZhMW8rUW1nKytCcE4xNE51K1dI?=
 =?utf-8?B?THg1OUdidG4vbGtZYWZpRTNaYkY0b1lVYTBwbVNydjVyclJpTVE0S2RrZzhp?=
 =?utf-8?B?L0p6UnJMd3hiNEVjQ0p5SEgzQTVWcldvRDQ5NkVUeUIrUlZ3Mlc2RUc4bUR5?=
 =?utf-8?B?YVQwYk5JdTJNQzRyVEdJNENQRFl0NDAxS2VVSVhSTXdiZ244aWg1dGMxWllP?=
 =?utf-8?B?YnJiYUwxRTdvLy9BTDhsd2p6aDRVNUtIYTBCbjJRbk4wYlU4NU5rRVk2ZGJj?=
 =?utf-8?B?SU1XRmp2enBkeEk5Z2djZTlCVlJxSUFHVS9NaDR5WXJSQWpBU1d3eWU2OEdp?=
 =?utf-8?B?cE03Z3lwOVVidnFqZFZJcnI4bFJUL1B2aHcyaVpKekV4bUhFL2FWQTVxd0Zr?=
 =?utf-8?B?b1Z2OFNqclVib1Q4dDJXNnplaWJvUnZxZlhkd3JUSVdmcGR1S1Q5UDEzQWpk?=
 =?utf-8?B?UCs2bG1XNU9QREl6Zkpoejd0WDZadUtPalZLb1BWM29Tc2dBRWlNd3N6aUht?=
 =?utf-8?B?aWt2RVBwRHZseGx0elNQa1c4bmxTMGE5aGFJSzBWNktuTXZObHc5N1p5a2N3?=
 =?utf-8?B?empqOUVHSU9KM2VGcU5nTVovTzM2eTVzaFNMNDV1Ky81U3RVdjByYVQweEQv?=
 =?utf-8?B?YVdKd3Q1OEIzNmg3Mk1Ia0NCMndTL0R6U0UzcEdXUUQvODZ1Z0V2OXNDbGNL?=
 =?utf-8?B?VG5ZUWVEeFRIeVM5NUxCWXJUWHBISnJqZXM2NVlxSXpPZW9TZ0NUeDVvOEVx?=
 =?utf-8?B?L1dxbTkzVlFXc2V5bWhURzQ2SUo3eXRJQUpNUGVTelNJRnJCQlp1bTYzTGFX?=
 =?utf-8?B?VnN2U3lhOGVTNVpYTVhvL0pNVHpMU2J5QkdCdmpKTWxzOW9UbXBiOUpBVlVq?=
 =?utf-8?B?Z1VuU2dvb1FaVG1uK1BaYktZK3ZTVkF4c0V0UEtid2NDTm1TWkx3bXVSVjZj?=
 =?utf-8?B?b1ZoR1NVQWJpQmZkWFFseUlnb0xRcVlvZm43Vngxb2lGYjRkTWJrdmJyZlFC?=
 =?utf-8?B?YjRhT1l3T2V2SHh6U250TEwrNDVDUklkYjZkRDV5bzk0V0FPYXZibG5ObFpv?=
 =?utf-8?B?d2Rjcml0Wk9BUFUwVEFlZnB1WU9YZEJBNkNDN3lWamU5aXdSVFVJNTVCL3Ur?=
 =?utf-8?B?aG5nTjg2eHNLUjZFUTh5VEF5MGI5NEdPZGd6SVhpSFlTRmErK3lzYnBZQlR4?=
 =?utf-8?B?WnMwdldGQjBkUDZVNi90VkRUVFNyWmh2TndJN3U4OWhqcFR3ZnhsOGdvT2dz?=
 =?utf-8?B?VVdJQTR3RTVIaVV6ODh1MDhNaTE2Z3V1eGdjcTgvejJGZzRkdGFTSHNHTmQ3?=
 =?utf-8?B?TzJFSHU4bmVuRmtYOWllcnJYMFBNMFBqK0M3MlFQY0pPeTgzVjhiYnAraUI5?=
 =?utf-8?B?Qy92Rm1abEU1V21JTUVoZHFvVkxEVWh3N1BYTkIxT3JWWlNNNWdvZUhvbjhT?=
 =?utf-8?B?VTJWWG5zU0NveEZnY0k3WFdzTXBnVytWWFV6QkhYdUJrZTl0NVhFSEJLaVA3?=
 =?utf-8?B?UjZ3T21JZ0Z6L0lHdjM1aEhINmVveHZtVnAvNDBBcndLM00wTlBkcko2czZO?=
 =?utf-8?B?VCt2Nk5zLzhXTXZJWU9yWCtraGg2MElFaWRFSnFnaHcxODZ0UTZpMVNhOUdI?=
 =?utf-8?B?dVJ2SjVLbFFyL3k5YlpLVTRWWGpqaTVqSzZqV0svRVpSeHM2UGJZOXM0VzE5?=
 =?utf-8?B?V0VUNEFrU3RiU0xiRlVYM0hobkRvY000R3NRMW9rQk5xR1Z3N0tsdlQxUjh4?=
 =?utf-8?B?dzhZeGd2TWMyRmpON3FxcW9WZmtJRnZhNmNPS2JzTUg1MDhQZjhOMlY5SDdn?=
 =?utf-8?B?R29kSnFBQTNXMEZKWDJVTW1WZXMxeGJ5VGRNSDJUVjB2MzVROGp5eWQ5WWdM?=
 =?utf-8?B?TTB2MVM5dU5LQ2NPTmZjQWh6TUN0NytDcnYrT1RyMTltUno3dWhjTHhTS0gx?=
 =?utf-8?B?djFYRUhHVFhVVmtXQWYrVTBGY1VMeGhPQWNNbnZBV0JOMmVxMkZsQlhXOU1M?=
 =?utf-8?B?aWMySHlLVi8yRnoxY2NPUXZsUldMZXZIaDJoRXFwL2d2NGM1SW1lZ05laUVB?=
 =?utf-8?B?QlhXZVk0bmJSNkRTb2srVm5EK1BWNStSTitKYzdLTE9uVmc5aEtxbWFvQ2w2?=
 =?utf-8?B?cnZ6TS9aT0tFMmEwOWtSbVd1dVd0a1VUZnZlY3RTNTdtdU9CUlRkbUd4UUJm?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8393C15795CADE4791BAE3C4C7734A10@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6038e41b-8ac2-41ee-0f6b-08dbc92ebe9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 01:18:00.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apA31Mr8h+XmM7ZXY4eRIc72nFdbJHx6WETmx0V/JbaBZsIr0Q+sq2Noj6gk1nlj9q02OeSQriREu0vZYgFZ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTA5IGF0IDIwOjA0IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIE1vbiwgMDkgT2N0IDIwMjMgMTg6NDU6MDYgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBGcmksIDIwMjMtMDktMjIgYXQgMjA6MDYg
LTA3MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IEZyb206IFNlYW4gQ2hyaXN0b3BoZXJz
b24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5jb20+DQo+ID4gPiANCj4gPiA+IEludHJv
ZHVjZSB0aGUgT09NIHBhdGggZm9yIGtpbGxpbmcgYW4gZW5jbGF2ZSB3aXRoIGEgcmVjbGFpbWVy
IHRoYXQgaXMgIA0KPiA+ID4gbm8NCj4gPiA+IGxvbmdlciBhYmxlIHRvIHJlY2xhaW0gZW5vdWdo
IEVQQyBwYWdlcy4gRmluZCBhIHZpY3RpbSBlbmNsYXZlLCB3aGljaA0KPiA+ID4gd2lsbCBiZSBh
biBlbmNsYXZlIHdpdGggb25seSAidW5yZWNsYWltYWJsZSIgRVBDIHBhZ2VzIGxlZnQgaW4gdGhl
DQo+ID4gPiBjZ3JvdXAgTFJVIGxpc3RzLiBPbmNlIGEgdmljdGltIGlzIGlkZW50aWZpZWQsIG1h
cmsgdGhlIGVuY2xhdmUgYXMgT09NDQo+ID4gPiBhbmQgemFwIHRoZSBlbmNsYXZlJ3MgZW50aXJl
IHBhZ2UgcmFuZ2UsIGFuZCBkcmFpbiBhbGwgbW0gcmVmZXJlbmNlcyBpbg0KPiA+ID4gZW5jbC0+
bW1fbGlzdC4gQmxvY2sgYWxsb2NhdGluZyBhbnkgRVBDIHBhZ2VzIGluICNQRiBoYW5kbGVyLCBv
cg0KPiA+ID4gcmVsb2FkaW5nIGFueSBwYWdlcyBpbiBhbGwgcGF0aHMsIG9yIGNyZWF0aW5nIGFu
eSBuZXcgbWFwcGluZ3MuDQo+ID4gPiANCj4gPiA+IFRoZSBPT00ga2lsbGluZyBwYXRoIG1heSBy
YWNlIHdpdGggdGhlIHJlY2xhaW1lcnM6IGluIHNvbWUgY2FzZXMsIHRoZQ0KPiA+ID4gdmljdGlt
IGVuY2xhdmUgaXMgaW4gdGhlIHByb2Nlc3Mgb2YgcmVjbGFpbWluZyB0aGUgbGFzdCBFUEMgcGFn
ZXMgd2hlbg0KPiA+ID4gT09NIGhhcHBlbnMsIHRoYXQgaXMsIGFsbCBwYWdlcyBvdGhlciB0aGFu
IFNFQ1MgYW5kIFZBIHBhZ2VzIGFyZSBpbg0KPiA+ID4gUkVDTEFJTUlOR19JTl9QUk9HUkVTUyBz
dGF0ZS4gVGhlIHJlY2xhaW1pbmcgcHJvY2VzcyByZXF1aXJlcyBhY2Nlc3MgdG8NCj4gPiA+IHRo
ZSBlbmNsYXZlIGJhY2tpbmcsIFZBIHBhZ2VzIGFzIHdlbGwgYXMgU0VDUy4gU28gdGhlIE9PTSBr
aWxsZXIgZG9lcw0KPiA+ID4gbm90IGRpcmVjdGx5IHJlbGVhc2UgdGhvc2UgZW5jbGF2ZSByZXNv
dXJjZXMsIGluc3RlYWQsIGl0IGxldHMgYWxsDQo+ID4gPiByZWNsYWltaW5nIGluIHByb2dyZXNz
IHRvIGZpbmlzaCwgYW5kIHJlbGllcyAoYXMgY3VycmVudGx5IGRvbmUpIG9uDQo+ID4gPiBrcmVm
X3B1dCBvbiBlbmNsLT5yZWZjb3VudCB0byB0cmlnZ2VyIHNneF9lbmNsX3JlbGVhc2UoKSB0byBk
byB0aGUNCj4gPiA+IGZpbmFsIGNsZWFudXAuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5jb20+DQo+
ID4gPiBDby1kZXZlbG9wZWQtYnk6IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxp
bnV4LmludGVsLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXN0ZW4gQ2FybHNvbiBBY2Nh
cmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IENvLWRldmVsb3BlZC1ieTogSGFp
dGFvIEh1YW5nIDxoYWl0YW8uaHVhbmdAbGludXguaW50ZWwuY29tPg0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSGFpdGFvIEh1YW5nIDxoYWl0YW8uaHVhbmdAbGludXguaW50ZWwuY29tPg0KPiA+ID4g
Q2M6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiA+ID4gLS0tDQo+
ID4gPiBWNToNCj4gPiA+IC0gUmVuYW1lIFNHWF9FTkNMX09PTSB0byBTR1hfRU5DTF9OT19NRU1P
UlkNCj4gPiA+IA0KPiA+ID4gVjQ6DQo+ID4gPiAtIFVwZGF0ZXMgZm9yIHBhdGNoIHJlb3JkZXJp
bmcgYW5kIHR5cG8gZml4ZXMuDQo+ID4gPiANCj4gPiA+IFYzOg0KPiA+ID4gLSBSZWJhc2VkIHRv
IHVzZSB0aGUgbmV3IFZNQV9JVEVSQVRPUiB0byB6YXAgVk1Bcy4NCj4gPiA+IC0gRml4ZWQgdGhl
IHJhY2luZyBjYXNlcyBieSBibG9ja2luZyBuZXcgcGFnZSBhbGxvY2F0aW9uL21hcHBpbmcgYW5k
DQo+ID4gPiByZWxvYWRpbmcgd2hlbiBlbmNsYXZlIGlzIG1hcmtlZCBmb3IgT09NLiBBbmQgZG8g
bm90IHJlbGVhc2UgYW55IGVuY2xhdmUNCj4gPiA+IHJlc291cmNlcyBvdGhlciB0aGFuIGRyYWlu
aW5nIG1tX2xpc3QgZW50cmllcywgYW5kIGxldCBwYWdlcyBpbg0KPiA+ID4gUkVDTEFJTUlOR19J
Tl9QUk9HUkVTUyB0byBiZSByZWFwZWQgYnkgcmVjbGFpbWVycy4NCj4gPiA+IC0gRHVlIHRvIGFi
b3ZlIGNoYW5nZXMsIGFsc28gcmVtb3ZlZCB0aGUgbm8tbG9uZ2VyIG5lZWRlZCBlbmNsLT5sb2Nr
IGluDQo+ID4gPiB0aGUgT09NIHBhdGggd2hpY2ggd2FzIGNhdXNpbmcgZGVhZGxvY2tzIHJlcG9y
dGVkIGJ5IHRoZSBsb2NrIHByb3Zlci4NCj4gPiA+IA0KPiA+IA0KPiA+IFsuLi5dDQo+ID4gDQo+
ID4gPiArDQo+ID4gPiArLyoqDQo+ID4gPiArICogc2d4X2VwY19vb20oKSAtIGludm9rZSBFUEMg
b3V0LW9mLW1lbW9yeSBoYW5kbGluZyBvbiB0YXJnZXQgTFJVDQo+ID4gPiArICogQGxydToJTFJV
IHRoYXQgaXMgbG93DQo+ID4gPiArICoNCj4gPiA+ICsgKiBSZXR1cm46CSV0cnVlIGlmIGEgdmlj
dGltIHdhcyBmb3VuZCBhbmQga2lja2VkLg0KPiA+ID4gKyAqLw0KPiA+ID4gK2Jvb2wgc2d4X2Vw
Y19vb20oc3RydWN0IHNneF9lcGNfbHJ1X2xpc3RzICpscnUpDQo+ID4gPiArew0KPiA+ID4gKwlz
dHJ1Y3Qgc2d4X2VwY19wYWdlICp2aWN0aW07DQo+ID4gPiArDQo+ID4gPiArCXNwaW5fbG9jaygm
bHJ1LT5sb2NrKTsNCj4gPiA+ICsJdmljdGltID0gc2d4X29vbV9nZXRfdmljdGltKGxydSk7DQo+
ID4gPiArCXNwaW5fdW5sb2NrKCZscnUtPmxvY2spOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoIXZp
Y3RpbSkNCj4gPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKHZpY3Rp
bS0+ZmxhZ3MgJiBTR1hfRVBDX09XTkVSX1BBR0UpDQo+ID4gPiArCQlyZXR1cm4gc2d4X29vbV9l
bmNsX3BhZ2UodmljdGltLT5lbmNsX3BhZ2UpOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAodmljdGlt
LT5mbGFncyAmIFNHWF9FUENfT1dORVJfRU5DTCkNCj4gPiA+ICsJCXJldHVybiBzZ3hfb29tX2Vu
Y2wodmljdGltLT5lbmNsKTsNCj4gPiANCj4gPiBJIGhhdGUgdG8gYnJpbmcgdGhpcyB1cCwgYXQg
bGVhc3QgYXQgdGhpcyBzdGFnZSwgYnV0IEkgYW0gd29uZGVyaW5nIHdoeSAgDQo+ID4gd2UgbmVl
ZA0KPiA+IHRvIHB1dCBWQSBhbmQgU0VDUyBwYWdlcyB0byB0aGUgdW5yZWNsYWltYWJsZSBsaXN0
LCBidXQgY2Fubm90IGtlZXAgYW4NCj4gPiAiZW5jbGF2ZV9saXN0IiBpbnN0ZWFkPw0KPiA+IA0K
PiA+IFNvIGJ5IGxvb2tpbmcgdGhlIHBhdGNoICgiIHg4Ni9zZ3g6IExpbWl0IHByb2Nlc3MgRVBD
IHVzYWdlIHdpdGggbWlzYyAgDQo+ID4gY2dyb3VwDQo+ID4gY29udHJvbGxlciIpLCBpZiBJIGFt
IG5vdCBtaXNzaW5nIGFueXRoaW5nLCB0aGUgd2hvbGUgInVucmVjbGFpbWFibGUiICANCj4gPiBs
aXN0IGlzDQo+ID4ganVzdCB1c2VkIHRvIGZpbmQgdGhlIHZpY3RpbSBlbmNsYXZlIHdoZW4gT09N
IG5lZWRzIHRvIGJlIGRvbmUuICBUaHVzLCBJICANCj4gPiBkb24ndA0KPiA+IHNlZSB3aHkgImVu
Y2xhdmVfbGlzdCIgY2Fubm90IGJlIHVzZWQgdG8gYWNoaWV2ZSB0aGlzLg0KPiA+IA0KPiA+IFRo
ZSByZWFzb24gdGhhdCBJIGFtIGFza2luZyBpcyBiZWNhdXNlIGl0IHNlZW1zIHVzaW5nICJlbmNs
YXZlX2xpc3QiIHdlICANCj4gPiBjYW4NCj4gPiBzaW1wbGlmeSB0aGUgY29kZS4gIEF0IGxlYXN0
IHRoZSBwYXRjaGVzIHJlbGF0ZWQgdG8gdHJhY2sgVkEvU0VDUyBwYWdlcywgIA0KPiA+IGFuZCB0
aGUNCj4gPiBTR1hfRVBDX09XTkVSX1BBR0UvU0dYX0VQQ19PV05FUl9FTkNMIHRoaW5nIGNhbiBi
ZSBlbGltaW5hdGVkICANCj4gPiBjb21wbGV0ZWx5LiAgDQo+ID4gVXNpbmcgImVuY2xhdmVfbGlz
dCIsIEkgZ3Vlc3MgeW91IGp1c3QgbmVlZCB0byBwdXQgdGhlIGVuY2xhdmUgdG8gdGhlICANCj4g
PiBjdXJyZW50DQo+ID4gRVBDIGNncm91cCB3aGVuIFNFQ1MgcGFnZSBpcyBhbGxvY2F0ZWQuDQo+
ID4gDQo+IExhdGVyIHRoZSBob3N0aW5nIHByb2Nlc3MgY291bGQgbWlncmF0ZWQvcmVhc3NpZ25l
ZCB0byBhbm90aGVyIGNncm91cD8NCj4gV2hhdCB0byBkbyB3aGVuIHRoZSBuZXcgY2dyb3VwIGlz
IE9PTT8NCj4gDQoNCllvdSBhZGRyZXNzZWQgaW4gdGhlIGRvY3VtZW50YXRpb24sIG5vPw0KDQor
TWlncmF0aW9uDQorLS0tLS0tLS0tDQorDQorT25jZSBhbiBFUEMgcGFnZSBpcyBjaGFyZ2VkIHRv
IGEgY2dyb3VwIChkdXJpbmcgYWxsb2NhdGlvbiksIGl0DQorcmVtYWlucyBjaGFyZ2VkIHRvIHRo
ZSBvcmlnaW5hbCBjZ3JvdXAgdW50aWwgdGhlIHBhZ2UgaXMgcmVsZWFzZWQNCitvciByZWNsYWlt
ZWQuICBNaWdyYXRpbmcgYSBwcm9jZXNzIHRvIGEgZGlmZmVyZW50IGNncm91cCBkb2Vzbid0DQor
bW92ZSB0aGUgRVBDIGNoYXJnZXMgdGhhdCBpdCBpbmN1cnJlZCB3aGlsZSBpbiB0aGUgcHJldmlv
dXMgY2dyb3VwDQordG8gaXRzIG5ldyBjZ3JvdXAuDQo=
