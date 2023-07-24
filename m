Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0687D76032A
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 01:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjGXXcF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jul 2023 19:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGXXcE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jul 2023 19:32:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A6010F0;
        Mon, 24 Jul 2023 16:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690241522; x=1721777522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8mzYeu1oXjOeMtK7JMoF4OO5xewYr2FHumnDfLdYh8M=;
  b=Fa72rxthJZEeL3kKWiqVYh5EXdZUN7C3wZnDt53fsZEttJg1N5MeUkNR
   B2hcl4cBV+0pJRkjY2rkTyJs6X2064lUySbioeoF36Hc7aceZiU1bC8fu
   DuvwcMp59o1n8NTpptJZRdFa8KTfwbBWGPcLpmiF5fVVJF+EYvMYvczzc
   alhlh7Z6PZQqWIpWuVc3SoSAtK+EI+BclHg9/iLXtA3unexM9V7cHNxcD
   IxIahQX7z0kiBPLpu4iqPeT+36BwtwqPBO6JFAu6GPcRn83haiLRQkuQ8
   zMrfPqJTOuyW836HtTN6NfgNxZBQ77cILS2cRwwA3qhM9MH/u+pHZvTyG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="365034518"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="365034518"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 16:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="839637249"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="839637249"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 16:32:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 16:32:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 16:32:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 16:32:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvahQTpkOLAesEHutFjpxlckBQfNdiF/2gIx1awYQmxdVQWa7N/2Gp7QsUbNBeI8mnbMSvP0j89ualnJ65ll5LzjBALpHFmOg77J/NFeyfRPgFx5OiWICpiDFJIcPwT7e3ANv4/7dL5us5clQZK31tmHFHqsd3xt6g+7a3p/HE+ZI0ZsrHmjiW8xL/XFhmY8fAh+ycyl2I3trcLY57VbGyaEuL+cZbGfQM6qnv/68jLDPLa25qNRkDlmkLpJAF8OXb1tMhGyC+6PDBzVsAeD274f3+kBfUEB12dqH4yvyljDS0irHtH3r0jsTBYN/3Z3xTTOHnHkQpN9Bv+zoNq1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mzYeu1oXjOeMtK7JMoF4OO5xewYr2FHumnDfLdYh8M=;
 b=MSp4be4+GROpExPBvsffs0npwTZBliLEI2k+YCNF7c0yIQ2onKRJ6stwn2sVBbp8sr36rKoJYHmXcdvcQ7yc79p3R0+gTeQyVNsSdf8b0QMf2Io9beS4y6GEYkBNhdB2TJBbvWss3cVCpgGYDRZhm2azcEM2MFHN/ANDJL+9chlF30YRxER3FyKisHaLcp4baONmO1RgqyXRLgMcYyZSAtiiP5CraNFHp/P5z5s6UZMYkKFFsRI9W5g891j7hWPoEvgaplrgQ6V/uzhKBftWomN7Mzf0OJUP9l/SesKGCC0OXxrJLAjLMRC4q4Fi8DZ4j3MueOUk5mSMTwHH7PVwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5344.namprd11.prod.outlook.com (2603:10b6:5:393::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 23:31:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 23:31:58 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "tj@kernel.org" <tj@kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH v3 03/28] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
Thread-Topic: [PATCH v3 03/28] x86/sgx: Add 'struct sgx_epc_lru_lists' to
 encapsulate lru list(s)
Thread-Index: AQHZtRTp1D+N9/I/okeNxDL9R1Ot76+97wAAgAAKcwCACsjugIAAUUSAgACQQYA=
Date:   Mon, 24 Jul 2023 23:31:58 +0000
Message-ID: <9ffb02a3344807f2c173fe8c7cb000cd6c7843b6.camel@intel.com>
References: <20230712230202.47929-1-haitao.huang@linux.intel.com>
         <20230712230202.47929-4-haitao.huang@linux.intel.com>
         <CU4GHCJTRKLZ.1RK23NWPHJGNI@seitikki>
         <op.17794m01wjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <4f5496d2e0ea8edba430e7de7304bdd840616146.camel@intel.com>
         <op.18lc2zw6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.18lc2zw6wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5344:EE_
x-ms-office365-filtering-correlation-id: 62eff3eb-c433-4b6c-1d29-08db8c9e2c97
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cGet9IpfEWkgNqYJjeuWkT1lDusY0eIaWPgA4xiIfreSqEttoP1BBbDkqVjKvV8iLVgT3N/VRZkbQ+PszY630tVG7gBGe49E7YJ/1bPyTLyTkxu1kVOTdL6RGx7gDEiva7N0O+eIb4e2dN9y1e4lVW7UPX4y+CuD2ZUvH5IprPBa3MGcdS6NpzfDfWo3e58FNr4VmDfYcO24FuH5bPcS7x9gWb4JYtD9FTvv67n4BD9bhH9LHG0dHJO+Y8A+vGU6ZffcAYBoOrf7VOq5lJwGIAb7AU19QmB6NADMtsSuVZrjP+LN/8h2poJ0YHLEZMizkvAyOWq49YKPXWqponuxRi6VvnD4wVg7RBbeSrMFAQZTgKex6cSGAzt++wM68gOlcHdhZXnU9i74oHfuhv0VhYrkrtAQ6Sn1a+uIn+xmjfT/CHZol79lli8PMxR0O6GzA3HdPdAMmx+SGWiC0DJneHBhfaIUQxMifqCSD4pS8VlEsvANezqej2sC5NjJyy6ilmsvZTJq2CZEWQedqrcxSk/Ngi9ys8OkCgkvZKSw7Rw+uFukvlmG5NkoPdGCstiTmzQwKvTz78r+0npf+8HfbksZIEOYJ0gh4WzHipViwONHJ2fj7pH2TURuY3+m8IaG5HzR44fRIX1q3V359QlFtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199021)(8936002)(8676002)(921005)(82960400001)(478600001)(122000001)(6486002)(7416002)(5660300002)(71200400001)(316002)(38100700002)(76116006)(66556008)(4326008)(66446008)(66946007)(64756008)(66476007)(91956017)(41300700001)(110136005)(54906003)(186003)(2906002)(36756003)(6506007)(26005)(83380400001)(86362001)(2616005)(6512007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2tSMjFQNXpxN1FvUUhGV1BaR3BwV0JobUtWYjN0SUxNa0x2NHI2TmZpSWcz?=
 =?utf-8?B?aE9ZMmVHeVZ3QlJIbm55Ymp2VytERG5XeHZZUG12SWpXbHZ5dEpKaW43TUl0?=
 =?utf-8?B?cStsVDBSMWFHeTBDcENMenNMQ29iWmhjR095cHNHVUF2N0F6OU1iYTlXWE1w?=
 =?utf-8?B?UGxOQmZYNDdkQXJlSHBES0NJRUtrS3hndU5IaTlMazJNWVd3TGZHSFB1ZVBa?=
 =?utf-8?B?TndwUFRKRzlrQ09GYWpoWUZCazhWK0N5UnRvdHV4UmVOVFVSSCsvWE9NT3BR?=
 =?utf-8?B?QnRUd2JzVGNuSG43MlRiWDBTa0V3K21Bd2I0S2ZTMVpmYnNiUmovb3hZN3V3?=
 =?utf-8?B?a2pPcE11akk2VFdKYjdNYnIwaWNxWmE5cUxKckdSNlllM2NRZkZKTGtPSEdM?=
 =?utf-8?B?WFVibUlwZUZETVhINDZWalZMZzNsdVFEWVRCZElHeVhGZHpEdjlyYTVjblRl?=
 =?utf-8?B?QWFCLzEyckJRQm9qU3hBT2FTa2JsVHZSYXltSFJ2WW9lZXU5Yk9wNlZGRVB1?=
 =?utf-8?B?c2M2cytjZjVhdERsVGpITUFQUXY5KzduWEp4Vnl1anVGNUpkS0laTzdCTkQ3?=
 =?utf-8?B?QmNJYkcxRVd3Z1JXOU1YZDJYQldEUDVqd2hBc2RxQUJSeEJrQkJqOEFUOGVk?=
 =?utf-8?B?bG1NdWh5VVBIdU1zOXFxaEU3bW9qcE05ZHF1bG5UeW1wK29ZR2FOcS9Nc0hF?=
 =?utf-8?B?a2dZS2ppU0tFRms1TmVoclFjQXowWkJHOFM0M2FOdzVQM3FsL2tUcHFIVnNK?=
 =?utf-8?B?ODkvV3V0UkliT09sbG1LRm80NCsxem9tMnc1QlJsRjNTMGg0UmlwMXJuaUNU?=
 =?utf-8?B?bUJjMW52NUFmbDVVbVA0T0pmYnVzUVQycHJlYUk3WGtzM2tzMEJCTVhYaTBD?=
 =?utf-8?B?dEFuV21qQ2NNTEpKbGo1VnBPUUVySXU0MlVySEdEa216Sm5tMTNzNFR2aXJD?=
 =?utf-8?B?dktBUURoZXV6MERLWnVuQWdWSWF5bDgyS0wrTlBFSUhRQ1JoaVFNQWF2aTZ5?=
 =?utf-8?B?Qk9rRWFnRmhxODVkOUEvbVovUnNMcE4xcXRCOEdkSjljbndRUWlTRkxDYk1y?=
 =?utf-8?B?UUZaaXFna0Vjb2ZmMmIveVlxaWRYd09IMnNDRUFXakZGZHZRdFgzZHJLZmQy?=
 =?utf-8?B?ZThTNjVnK1AwQXJOYzFZRC9rdVlScGFmUjM4SVp1WkdHcjBITUEwbWRKOFhs?=
 =?utf-8?B?NmNia0tBL3dJWUtXS3NjV3A1NW15S2QzWUQ0R3dicDZqekZBOEVMR2lDVzZt?=
 =?utf-8?B?Y0NRUExabGFOeHJ4RzJlS1NNdGhXaFpLMWV0YUJGNnJrby9oc2huWCtlclJv?=
 =?utf-8?B?Y0cvaUVhTGozdE9hNCs3dkluVmJRM1kxMUN1TDFENzlNdzhTVGFFUzE0Q2Vx?=
 =?utf-8?B?WU9BK1RWbzZxa1V0MHVKZlFpWWpQb1hGZmFndlR2U1dEbUFZYXVTQmtCanZS?=
 =?utf-8?B?MGxPb0NNRDRGK0FIL3hOQUMrNzlIOGdIbyswc3VoOVpCUFhyci9Eb05UWDVt?=
 =?utf-8?B?UGdiVnVjQzJlczVZbXdCYnlGZURyakRmbDJzRy96ajN2WnpvVSsxcEhkODBV?=
 =?utf-8?B?K2tOaDNqK1BFTXNoeXhPUGFYYUNBNUxOVTVCRjQ2ak1sdjVvSklGQ3NGbnFK?=
 =?utf-8?B?NFI4TmdseVptQVRzdU44WmZVdldsVDJDcUdpdVFMRVp2c0xWOEVnWXUrNlZB?=
 =?utf-8?B?cHhzL2xJOFBDcE80UytLNlRRRE1ycVZOTXdMZjBGZFgwS2RCcnJJamlRcFVj?=
 =?utf-8?B?NUlpQXFBOEdlWEVzZWp2VGlsMFMxTXA1NW9xVmFxY1BhUis5ZE1HN1Y4dXRZ?=
 =?utf-8?B?RDMwNDJIZzJSU1NuVWNiV3ZmN1RRR0pCQzgxQWFnYmcvVEtjZmpIQTBzMEZG?=
 =?utf-8?B?YWJmbGlGdWsvZE1FZVlzdHhET3Z3T1Flc3lvcDVYUHpHY3FMNzdvQkNRN1d3?=
 =?utf-8?B?bDNzQ29hMkM4SjdvcVVIS1ZSMU8xVWR2QS9idTFnSFdHTEpacnJjOXJJU3lR?=
 =?utf-8?B?MndXb0oweUM1QlRieXMyS3VlcG1id1l1OENYWEFxR2EyMXgzMVNmbk9qc3o4?=
 =?utf-8?B?TFNMSGgyc3VEVXZTcDFETDIwRitFcGFwVlA1a2NHanZndVNJUWhmbjJBYnla?=
 =?utf-8?Q?u34iO+ZR44YPUomCMR6BYeJko?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A25B34C2634EC49960625C2E4C6404C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62eff3eb-c433-4b6c-1d29-08db8c9e2c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 23:31:58.3738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4dbF4VDXKPNfMG+BNyB5isz4TIvMIyb+XPqUrNU9hy541m/Jg6ZBEiJqU4ifgJpznVmcDO7goEVxrE5UmFovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5344
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDA5OjU1IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEhpIEthaQ0KPiBPbiBNb24sIDI0IEp1bCAyMDIzIDA1OjA0OjQ4IC0wNTAwLCBIdWFuZywgS2Fp
IDxrYWkuaHVhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gT24gTW9uLCAyMDIzLTA3LTE3
IGF0IDA4OjIzIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+ID4gPiBPbiBNb24sIDE3IEp1
bCAyMDIzIDA3OjQ1OjM2IC0wNTAwLCBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3Jn
Pg0KPiA+ID4gd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gT24gV2VkIEp1bCAxMiwgMjAyMyBhdCAx
MTowMSBQTSBVVEMsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBLcmlzdGVu
IENhcmxzb24gQWNjYXJkaSA8a3Jpc3RlbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gSW50cm9kdWNlIGEgZGF0YSBzdHJ1Y3R1cmUgdG8gd3JhcCB0aGUgZXhpc3Rpbmcg
cmVjbGFpbWFibGUgbGlzdA0KPiA+ID4gPiA+IGFuZCBpdHMgc3BpbmxvY2sgaW4gYSBzdHJ1Y3Qg
dG8gbWluaW1pemUgdGhlIGNvZGUgY2hhbmdlcyBuZWVkZWQNCj4gPiA+ID4gPiB0byBoYW5kbGUg
bXVsdGlwbGUgTFJVcyBhcyB3ZWxsIGFzIHJlY2xhaW1hYmxlIGFuZCBub24tcmVjbGFpbWFibGUN
Cj4gPiA+ID4gPiBsaXN0cy4gVGhlIG5ldyBzdHJ1Y3R1cmUgd2lsbCBiZSB1c2VkIGluIGEgZm9s
bG93aW5nIHNldCBvZiBwYXRjaGVzICANCj4gPiA+IHRvDQo+ID4gPiA+ID4gaW1wbGVtZW50IFNH
WCBFUEMgY2dyb3Vwcy4NCj4gPiANCj4gPiBBbHRob3VnaCBicmllZmx5IG1lbnRpb25lZCBpbiB0
aGUgZmlyc3QgcGF0Y2gsIGl0IHdvdWxkIGJlIGJldHRlciB0byBwdXQgIA0KPiA+IG1vcmUNCj4g
PiBiYWNrZ3JvdW5kIGFib3V0IHRoZSAicmVjbGFpbWFibGUiIGFuZCAibm9uLXJlY2xhaW1hYmxl
IiB0aGluZyBoZXJlLCAgDQo+ID4gZm9jdXNpbmcgb24NCj4gPiBfd2h5XyB3ZSBuZWVkIG11bHRp
cGxlIExSVXMgKHByZXN1bWFibHkgeW91IG1lYW4gdHdvIGxpc3RzOiByZWNsYWltYWJsZSAgDQo+
ID4gYW5kIG5vbi0NCj4gPiByZWNsYWltYWJsZSkuDQo+ID4gDQo+IFN1cmUgSSBjYW4gYWRkIGEg
bGl0dGxlIG1vcmUgYmFja2dyb3VuZCB0byBpbnRyb2R1Y2UgdGhlICANCj4gcmVjbGFpbWFibGUv
dW5yZWNsYWltYWJsZSBjb25jZXB0LiBCdXQgd2h5IHdlIG5lZWQgbXVsdGlwbGUgTFJVcyB3b3Vs
ZCBiZSAgDQo+IHNlbGYtZXZpZGVudCBpbiBsYXRlciBwYXRjaGVzLCBub3Qgc3VyZSBJIHdpbGwg
YWRkIGRldGFpbHMgaGVyZS4NCg0KSW4gdGhpcyBjYXNlIHBlb3BsZSB3aWxsIG5lZWQgdG8gZ28g
dG8gdGhhdCBwYXRjaCB0byBnZXQgc29tZSBpZGVhIGZpcnN0LiAgSXQNCmRvZXNuJ3Qgc2VlbSBo
dXJ0IGlmIHlvdSBjYW4gZXhwbGFpbiB3aHkgeW91IG5lZWQgbXVsdGlwbGUgTFJVcyBoZXJlIGZp
cnN0Lg0KDQpbLi4uXQ0KDQo+ID4gPiA+ID4gK3N0cnVjdCBzZ3hfZXBjX2xydV9saXN0cyB7DQo+
ID4gPiA+ID4gKwkvKiBNdXN0IGFjcXVpcmUgdGhpcyBsb2NrIHRvIGFjY2VzcyAqLw0KPiA+ID4g
PiA+ICsJc3BpbmxvY2tfdCBsb2NrOw0KPiA+ID4gPiANCj4gPiA+ID4gSXNuJ3QgdGhpcyBzZWxm
LWV4cGxhbmF0b3J5LCB3aHkgdGhlIGlubGluZSBjb21tZW50Pw0KPiA+ID4gDQo+ID4gPiBJIGdv
dCBhIHdhcm5pbmcgZnJvbSB0aGUgY2hlY2twYXRjaCBzY3JpcHQgY29tcGxhaW5pbmcgdGhpcyBs
b2NrIG5lZWRzDQo+ID4gPiBjb21tZW50cy4NCj4gPiANCj4gPiBJIHN1c3BlY3RlZCB0aGlzLCBz
byBJIGFwcGxpZWQgdGhpcyBwYXRjaCwgcmVtb3ZlZCB0aGUgY29tbWVudCwgIA0KPiA+IGdlbmVy
YXRlZCBhIG5ldw0KPiA+IHBhdGNoLCBhbmQgcnVuIGNoZWNrcGF0Y2gucGwgZm9yIGl0LiAgSXQg
ZGlkbid0IHJlcG9ydCBhbnkgd2FybmluZy9lcnJvciAgDQo+ID4gaW4gbXkNCj4gPiB0ZXN0aW5n
Lg0KPiA+IA0KPiA+IEFyZSB5b3Ugc3VyZSB5b3UgZ290IGEgd2FybmluZz8NCj4gDQo+IEkgZGlk
IGEgcmVyYW4gYW5kIGl0J3MgYWN0dWFsbHkgYSAiQ0hFQ0siIEkgZ290Og0KPiANCj4gJCAuL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLXN0cmljdCAgDQo+IDAwMDEteDg2LXNneC1BZGQtc3RydWN0
LXNneF9lcGNfbHJ1X2xpc3RzLXRvLWVuY2Fwc3VsYXRlLS5wYXRjaA0KPiBDSEVDSzogc3Bpbmxv
Y2tfdCBkZWZpbml0aW9uIHdpdGhvdXQgY29tbWVudA0KPiAjNDE6IEZJTEU6IGFyY2gveDg2L2tl
cm5lbC9jcHUvc2d4L3NneC5oOjEwMToNCj4gKyAgICAgICBzcGlubG9ja190IGxvY2s7DQo+IA0K
PiB0b3RhbDogMCBlcnJvcnMsIDAgd2FybmluZ3MsIDEgY2hlY2tzLCAyMiBsaW5lcyBjaGVja2Vk
DQo+IA0KDQpJIGRpZG4ndCBnZXQgdGhlIENIRUNLIGluIG15IHRlc3RpbmcuICBOb3Qgc3VyZSB3
aHkuDQoNCkFueXdheSwgSSBndWVzcyB0aGUgY29tbWVudCBjYW4gYmUgdXNlZnVsIGlmIGl0IGlz
IHRvIGV4cGxhaW4gd2h5IHdlIG5lZWQgdG8gdXNlDQpzcGlubG9jayBvciB3aGF0ZXZlciBsb2Nr
LiAgQnV0DQoNCgkvKiBNdXN0IGFjcXVpcmUgdGhpcyBsb2NrIHRvIGFjY2VzcyAqLw0KDQpkb2Vz
bid0IGV4cGxhaW4gd2h5IGF0IGFsbCwgdGh1cyBkb2Vzbid0IGxvb2sgaGVscGZ1bCB0byBtZS4N
Cg0KSSBndWVzcyB5b3UgZWl0aGVyIG5lZWQgYSBiZXR0ZXIgY29tbWVudCwgb3IganVzdCByZW1v
dmUgaXQgKGl0J3Mgb2J2aW91cyB0aGF0IGENCmxvdCBvZiBrZXJuZWwgY29kZSBkb2Vzbid0IGhh
dmUgYSBjb21tZW50IGFyb3VuZCBzcGlubG9ja190KS4NCg0K
