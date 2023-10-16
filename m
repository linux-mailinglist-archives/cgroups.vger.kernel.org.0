Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABF47CA634
	for <lists+cgroups@lfdr.de>; Mon, 16 Oct 2023 13:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJPLDE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPLDD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 07:03:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B683;
        Mon, 16 Oct 2023 04:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697454182; x=1728990182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wM3ic/OCoAUlXkqoVetQ1eA7vWuKuIBEY/AJTBXYMEA=;
  b=eTacTXMAo1rfen5N0yMsByCsM8RIliii/0qFn34hbwfJ8H6DG2Ui0NeU
   zJz/7f0IXkZf+J+88Xo7aM7ZoiGthBx+xv0Sr5jF9Yx6s50j9xLXCrxsk
   RzP5GN1twIL3Xye3GQwE6jwaUtGc10sNlHGwcOFVMX+zG7t4aChb/NSmn
   2UbLNbDRQfOBiH2/0iszavawusxTQFAxlTsgVyntBda7zuCPJpgsu2nAQ
   C2bzom6CnrXrBZGkDqG2W4p2DbRlx4snFKlWnY7O5VShIWKnB5QJ8mUcc
   C6e/l1+pzx9XxJrsl+2W9MKYwBf/g7NYYxH0p23UhfHU8QtHkQm/EZes1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="7064900"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7064900"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="846358513"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="846358513"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 04:03:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 04:03:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 04:02:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 04:02:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 04:02:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6srwUjgHk3ZSN0zbdJuosSzBznDjqspmI009RzfTtun/79/G9vammaNlFiT6Rti8yfXLgV3VTJqHDixeVVy3GrqwaRctpNicbcorh2LxQe5Qf7jpNBaGXKP18zz211J9U17HfCAo0GM0lXa11Ef8RVbkKhnOtKRqrvt5qxoYXrRsFz/+GTckHYvoIgjRR3vOskGBCwn+Y7nXBWAAW0SzjHaThNGiVCkPb86JqmK/ZxHAwBftohRoOAjPfmZBi4Q5zP/0nXGXxkjUmpO+b8i0pOZGNKX8Tnx1Kb1SwPjuAxCUHqSUSsrIETJfVHN5fR/8e4e2jnM6RUeClUV5qR9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM3ic/OCoAUlXkqoVetQ1eA7vWuKuIBEY/AJTBXYMEA=;
 b=SSpbZTBn7tMdHjytNjTeoVlakWXQaQ3mjOs3rG8yG3J77PNmT08jQiIsr7K0cdv2IX+chiiBXor9yVrqInlaOPrCE72Wajgd68cJ2p9N0aekR+cRmVwf2A/dUXMvCVjZCKU7hJtiJaz/y1b+M0JY715KWys1zGJc/HcFLFhBVtx4/VRyH5NB+rZBayfUPBth2e+7i1Aey3prtEFgCjIN9pPPMwOrpuyIuhGCzPyOWa+A91fVmOWx7NR+40P9RBlu04MEw/Xr/e5HD/zami/b4RPgQJrCgxu7EfHVfB/Vv2mN66rVBQtfqy932KpyfheKzyvzinIEx7N8ekJmeIqaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 11:02:56 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f5cb:a40b:539a:2527%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 11:02:56 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>
CC:     "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Topic: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAKoQCAAAepgIAADEaAgAD/w4CAAIz1AIAIgBgA
Date:   Mon, 16 Oct 2023 11:02:56 +0000
Message-ID: <24714c0355a667e4739a51c46c921e014582b8cd.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <ZSSZaFrxvCvR1SOy@google.com>
         <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
         <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
         <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <64147ac7d9f9946cf7e3bc78fc33d7e75864d9db.camel@intel.com>
In-Reply-To: <64147ac7d9f9946cf7e3bc78fc33d7e75864d9db.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO6PR11MB5635:EE_
x-ms-office365-filtering-correlation-id: f75acbdd-001d-45eb-e350-08dbce377397
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHmTcrveWV3G5jTl+oNOiYewRG9of1Cb4z3nmhqXRq1yOqf1kiV07Cl6BFlx/3bcf3VWPO0B7/O61lcyXCeg3N0wkAwB9QBecXh0WnB6EKhdTBa8CtyDeNuBq099lFRsn2GUGysDa/fZ/Esp/ic1y7FkoQCwqaWcODOo4fakflT6NiF0HekcHempwfh+32E3AV1ew13JStk3hSoi9PwGjyGTT9kwis4TfGSh6f69hXOiz4MCadK3Q5J2w5tHv40MZFJhakkPpqbdYI8637aX9ISW3TLZv2qe65XdyN+CE4nhFh2LVhC1aSm4Md6GmW7Xta/d2FChgbzu0FN0QXZcef0QR5g5cFuuqh5Cb/4ACcqm9UbcSq8O6KW901fz96Wu8SxhAwUt3xjmlQqrUACF3cjmUGGUx40X+VnhgWtY3bkksGuTnYOetAJNP1jmnAiHFBt5bTeN0GTfibm/OIYJZrxqFkfWDOIhDJde1qvA7q+7AflqF5551d2E2ZsARuliH6f2qIxRggW4JC+EhqBd5+hCDEqanU5Rjf/1VWcoPCvbcZmAyiVH+i5fCYNanI3MJsFCX6Xnj/LWVOiV7OYmqCJ5ND4EWIBUV0KbmrsrdnyJNSwW4dnaxByJqHK+c94i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(7416002)(2616005)(26005)(6506007)(6512007)(478600001)(76116006)(5660300002)(8676002)(4326008)(41300700001)(66556008)(8936002)(66476007)(4001150100001)(4744005)(2906002)(91956017)(66946007)(64756008)(54906003)(66446008)(316002)(38100700002)(122000001)(110136005)(71200400001)(6486002)(38070700005)(82960400001)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnVqS3JqNm00aGdGQTlZNlYrenpFcFhycngxa2daL2tMcElEamxXeWY3UFlw?=
 =?utf-8?B?bjhFR0J6blRhSHAzb2lZN20wdHgwTE0vN0Vhc29DUTdtV3VNNG5BZElMSzdu?=
 =?utf-8?B?OGg4ekxpczJXU0gzcTRMVUhJVnBZL1BnaTFPYXZHSjZDMnBnaXpEZDNseXlC?=
 =?utf-8?B?Nk43MkVUQ016dDZXTERDUzBkK3RGYzNQWnNkZHlNUDIvTm9lQkYreWVRdEd3?=
 =?utf-8?B?bkVEZnY1VkRLSThnM3RndUVPYWFaOHVYc0lFQzhqOFVYaEJyUXM2NDYxbG1w?=
 =?utf-8?B?Uk4rWXhqSWdpQ0FFZVNmWWdmM1ErZjZjWktoc04xUWxEbjFaeWxMa1kxcmhB?=
 =?utf-8?B?aWtWbTd2VHJmaFZPSzlKTUhERCtWcFd5Vit6QkVpeGk4NFp5WmVCK0RHay84?=
 =?utf-8?B?b3Q0bXRDeEkraXVqREVpeXlmaStlOU5oc3VldVhJbXd6Yk9IeGcxK05KUHM2?=
 =?utf-8?B?U2QybmE0TWFtUGI3b3hSTHFFcXM2NVhOSi9HQWlJU3BLaTYrZHdML0NrZEVm?=
 =?utf-8?B?NHNzRnJrZ2ROSzBsU2dqa0IwVnlscFN2QTBCTndDMGhvbUMrSnFlYy9MR0tI?=
 =?utf-8?B?cHFxVkhOTkNYS3ZyWENHWFFtZTllTGw3bzRlckVkZ0xScStndGI2VGJMWkpJ?=
 =?utf-8?B?QVMyTlFqdlB4RHZxSWJQQ0o2Vzl0TnJ4SGVVcVZBeGM2ZkpnTDFXcVFqLzJx?=
 =?utf-8?B?MGxBeDEwYThRVGphMXg5Q00rdU0zUktpM2FBZXpDME9JQlpKTXRsQ0liQktE?=
 =?utf-8?B?akZOeDVqQ01FR1d3aDdCN2FhNjRlaldaVmJ5OWhKVzdxNFdSelJxS3dkRnlz?=
 =?utf-8?B?ZG1sWkxmUDZhNk9hMmRkclo2bmNBWkFGdndCeFE2VTRwUXJxK2tJMDN4dWJB?=
 =?utf-8?B?d2Y1Z1BxZy9uOFZUbkxzT2dVM2k2cHMrQWx1aEk0NnljL0owbG4xWms0MDY3?=
 =?utf-8?B?c0xFVyt4UnRwRFk5TjFOUFBUN1owa0VXY0dvUjd6a3RhaVUzR0FOODJGWjJl?=
 =?utf-8?B?RTI0NnMyMU9ORlNUSFpYNXBWUk4yMkdtZGZ2OExZYndkcEIvWFpPKzl2dWtO?=
 =?utf-8?B?ZndZbGNPOVByQVEvS2l5OE8reDBwaldDRVZidSs4MlpLU1R5djlKVzdncWs1?=
 =?utf-8?B?OXBBbE9vL1JxTVBtbjZmTzhqN1h6WEgvcHdVKytKK1JXb0FtNm9NZnhScHJH?=
 =?utf-8?B?bVMrKzltNVFwcG5hYktzaWNYU3huZlBYVncyK0NFSTcvMEczSkxqVlN2czJL?=
 =?utf-8?B?cytuc1lnamRpUjRLa0xGMWovcHlXeUxaRjFKWnVWWndMZWhUbVlBcjdrb0ZH?=
 =?utf-8?B?ZFdycGlVbzVaWC91OEVQNWJxRnlzRzdmcnJ2QlVVNE02bGRGMzhibU1uV1Vj?=
 =?utf-8?B?YURoZWIyd3JjNUNxUHhPbEZRaEczWDVzL1E5V2lueUxFT1FzeHk2OHZ3UXZ2?=
 =?utf-8?B?YnNiUWJXTzVXVm96MUEwZ1o4RHV6TkxkYmk0ZGVNSlBYVWRPdTN1NUI4c2J4?=
 =?utf-8?B?eFgxZk9ZSCtjdW5acC9CT01IWlo5eW4vYkFpMi9uY1Fad05LYm51TlJ2enZ0?=
 =?utf-8?B?WTNBSU1Tc2tYRXFYYWdaUnNHQjZSb3NFdUxXYTAxZEM1UGsvWUhmZDhxQkNM?=
 =?utf-8?B?bHlHT1dacHBKaXNqQ0FOVXV3NDZrMWhZWklhWnd4emd6d0JQSU1BZjFyVGt5?=
 =?utf-8?B?d1ZOWFBuV2ZNc041L00zMmVqcGtKTHY2M1JycVNTeW16M1ArMEtpWWpYQXN6?=
 =?utf-8?B?emhJWE4zK0M5NjRYWnJPenRxZHlQb3k3SDAwaTUxemsvRzNFSHl2Z203MHdk?=
 =?utf-8?B?ZWlURXA3UStVajVNQTB3SEpHSUw3dThIVWI2OURzUzRhc2dOV2Y2RmF5WFZ3?=
 =?utf-8?B?NGpyZFpDWWVPMHhSbXo0bzZXdjBDREJhdFNKRy9qVnd5ci9pUUtoL2doTXVL?=
 =?utf-8?B?cytSOGxiSUdWY25memhVZktWMHRSUEh4NXNrM0R2Nys0ZURkUUlObXovR1hi?=
 =?utf-8?B?TXF4V3VWVVZXcktGK3JmRGNFSzdxL2E0OG5xRnlRQXRWMnkzNGxTM0hoUFhN?=
 =?utf-8?B?bUZ0SmJqZ000Q1hOWHVxc0IyUXdWRDhFdzFqT2RkT2NOclJYNHlFbHhQNXRx?=
 =?utf-8?B?NU1uWmljRDY4U09TVUducFRTY1lMdFdoaEYxcGtHN1ozTU1hcGZ3MjdFbjgy?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <379DA46C15DA5E45BC8BE631FEEF6039@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75acbdd-001d-45eb-e350-08dbce377397
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 11:02:56.0590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9l9XeOtLou6FlprXSSfMSm0rEyNYA+w0po3qm38+ttXz9Ykb4eRbeoBw9x0PiAEimWRI4enHFOlTViufHB0bIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5635
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

T24gV2VkLCAyMDIzLTEwLTExIGF0IDAxOjE0ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBUdWUsIDIwMjMtMTAtMTAgYXQgMTE6NDkgLTA1MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBhZGRzIFNHWF9FTkNMX05PX01FTU9SWS7CoCBJIGd1ZXNz
IHdlIGNhbiB1c2UgaXQgZm9yIHZpcnR1YWzCoCANCj4gPiA+IEVQQyB0b28/DQo+ID4gPiANCj4g
PiANCj4gPiBUaGF0IGZsYWcgaXMgc2V0IGZvciBlbmNsYXZlcywgZG8geW91IG1lYW4gd2Ugc2V0
IHNpbWlsYXIgZmxhZyBpbiB2ZXBjwqAgDQo+ID4gc3RydWN0Pw0KPiANCj4gWWVzLg0KDQpJIG1p
c3NlZCB0aGUgIkVOQ0wiIHBhcnQgYnV0IG9ubHkgbm90ZWQgdGhlICJOT19NRU1PUlkiIHBhcnQs
IHNvIEkgZ3Vlc3MgaXQNCnNob3VsZCBub3QgYmUgdXNlZCBkaXJlY3RseSBmb3IgdkVQQy4gIFNv
IGlmIGl0IGlzIG5lZWRlZCwgU0dYX1ZFUENfTk9fTUVNT1JZLA0Kb3IgYSBzaW1wbGUgJ2Jvb2wg
ZGVhZCcgb3Igc2ltaWxhciBpbiAnc3RydWN0IHNneF92ZXBjJyBpcyBtb3JlIHN1aXRhYmxlLg0K
DQpBcyBJIHNhaWQgSSB3YXMgZmlnaHRpbmcgd2l0aCBmZXZlciBhbmQgaGVhZGFjaGUgbGFzdCB3
ZWVrIDotKSANCg==
