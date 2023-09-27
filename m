Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479167B01DE
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjI0K2o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 06:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjI0K2m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 06:28:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E301A5;
        Wed, 27 Sep 2023 03:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695810521; x=1727346521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XMj3OOtweKL5KPCnipu0LnsUBV15nz5OF1Q8G74a3mQ=;
  b=bvLGS8zN0Pce5VHeTtMbfFhcM6POEuJ280uGEGwBNBo36Bp16lWzRkFE
   pW/5ggDG2dCIVm029+1alDlMzpm7hcHdNlUwJ8etIYlqg9eMQPpIbZ0ip
   7ih4jpRnDVIGvOtLZ48jw25b/osXKoyVrcYMPlbDg6OmP27MyfekC20bs
   715UuxDoUosDNjD52iAIDMgzlY18Hivu29J/c5uFTAD6jCTc5NrzUn/0c
   qvPMUCJ2eOL6NbRg679tSuw2t7YvdPkhiz8ub8EtNg22zeJtbf9ZJSDBx
   viJcFiFbgqf47+3EFBLbQJN0WOGxgaSf8cuZpdCxxhWQ9TvRcVDxhkf7F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384580579"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="384580579"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 03:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="742667660"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="742667660"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 03:28:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:28:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:28:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 03:28:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 03:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj3+YDamJ5f8O/0S8g2LhNDhMomiC6zJLP+8KZn77b3UY8ckavENecVsZlqcha84gyIOHnpV5ZHf0vlDvt3dGQymJ8TYKvOCD2n40H31eLNvvEZ2ADdvp+JMeyB65RV6gEZYsw7CfkAhiHwWH9j39+RYU1DHDfXIT6n+imvSRdsgj/zQR0MoaADUIdouM+sxh+nvwNh1ptVjvGem4kk6WB8bpWKjxXQzRD9dMuB91jRdhGiMIqwJNdLSAog8nw4xR+em/sRvu0AsomzKRjssXA95YmsaTAO97J+NFN2OmwP6GI43i0qWxb9G8/0D7ttuj0mv/LeVMQm2n0VFDw+fmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMj3OOtweKL5KPCnipu0LnsUBV15nz5OF1Q8G74a3mQ=;
 b=drrlOOwv1zCpYD8z6AnqQTcIs40Sc83NQFnekmGVH/8fFW5AIWyrLFiesFqFN72aK5+sv3faUdNRqPxiIv2eUPQS3qn/71AQVHgJBKppc/cu3ZTWQTRjamFI5XS2/f2FXTHdSh2j/apiAxedE5WknDPCXKAq9bgJrltBfVzGP6h0Jqmxnc7WgJhcJJMzigUSrpyYuzlldwfdkyydnJbcI0p8SiJ0ReRNEeUeSX6nLdt3vFeaAOF6kVDz0Oa5GPgB8DrOk7WF0jMVcQt5TmlGuo6o2Oy3FWbbKzXwy0aHtdp8cQXdK7a6+f8eJSeMH8/Zyg28pcTkT/ug40Ejf7f/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7443.namprd11.prod.outlook.com (2603:10b6:8:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Wed, 27 Sep
 2023 10:28:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 10:28:36 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 06/18] x86/sgx: Introduce EPC page states
Thread-Topic: [PATCH v5 06/18] x86/sgx: Introduce EPC page states
Thread-Index: AQHZ7csUaq56ebRDx06C7sjZBwfv+bAufyYA
Date:   Wed, 27 Sep 2023 10:28:36 +0000
Message-ID: <b1d7199262b9da496a04a36447541e9166f35f19.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-7-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-7-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB7443:EE_
x-ms-office365-filtering-correlation-id: aced8bc9-a2b9-4eee-d2d1-08dbbf448230
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVr8jZ6qkQxoAEEJMPXL1fXdP1lbXV9YgjE89l9kHF4xb/PMN47Fslst3FpGE4/6dGoOxmRRrrwzQzbYFhrUEftMFmy5be+/ZS6uqnzOWAppVeH1ns9odCI/O5BKUN0ysOjxC9RcH9meVWwouFvoDLhqiSLkkGYeL0FB5AQAm9cYU3yyydv5xiIn6jHVG6wFDWBck0b0NHU88h63TfpOPuck2kKN0tXfN3MZmSFheN2spvsROTohUmGS87yZA26jvco1rcgIPZ+wb/ZLUCClgHgUnl98huHUBKUIDsExp/4wE54yVcsLxJDci4rVhWQ7vYwHuy89GHM0ryrpEhRK5a/DkO9PpZ3P1JBq3JSHIQHfgA9jk3ygjcZqZTUuMfs4o2/fMbI8Nxz/rQhac7OHlk5V04Aat3oP9RvpCPooCeVKojgR9GP7bXAulONkbyMVP455J3FvT/FS50FBtyDQbOsZGABxI8XOm+RzLwBGq2ay3HA5m5C6k/yd12I4OgKmpTIzfgLHYiannse20QsjMznl8tCExI0ecDim2PRwmn7TTC5bVbkbQ6MhCGBGGblU9ktPPHI9bwGIb+fBTW1azUDjP4R2UzjgYnC46N53MxW2ie6GAOHnUESExq7JLDoq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(7416002)(2906002)(66476007)(54906003)(66446008)(5660300002)(110136005)(66556008)(91956017)(76116006)(478600001)(64756008)(71200400001)(6512007)(66946007)(2616005)(6486002)(26005)(6506007)(41300700001)(316002)(8936002)(4326008)(8676002)(83380400001)(38100700002)(921005)(86362001)(36756003)(38070700005)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE1MS2NRYkFVSXRsUEpyZDMvSytSL1hjVzk0MGxwTnAvbTl0ZUxrZ2VCa3Jr?=
 =?utf-8?B?VmNmN2ozenRMVVNCYjdCeXhScWFuT2J3eUpPTW5MNEFPN0l5ekFpYmx3M0JD?=
 =?utf-8?B?bzRvUXdPUEZXR1BqNnM5QUtWcmFxUEtDV2lOaFhDdXErbnFwMm84N09ndXBx?=
 =?utf-8?B?Z0NXTnkxc21yQlhIMFp2VFppOWM0N1FaNFdIdFpJb0FMSVY0R3FCMkF2N2JO?=
 =?utf-8?B?VzJHbEdFajNEeXNVeUJyRjAvMTNaUkxqc0g0ckxuMndTelNLS2Nlc24zSklt?=
 =?utf-8?B?d1NROFE4Unh5Z1BuUHlUYTBEZTJlSS81WGJMeGRrVCtlV2VWNDBvZTVGSXgw?=
 =?utf-8?B?Q3owTHpnaEhGM0pPMWNMem5JaEZWeWVFUm55QVY2dll1ODBLejAxQys3NG93?=
 =?utf-8?B?ak93WWFrdmh0WE04Tkx2WjdreTljbFNDYzk5YjRyQUFHSkwyTGxTeWVxTU9U?=
 =?utf-8?B?YmpudkZXTGxCWTk2dkVRL2R4K2dONVF2ZExMOEhkZVNNaWRyMlRKcUowcm53?=
 =?utf-8?B?VmVvZmd3d3JFTVJGWW9FcmRDZ3lxMlBReDAwZEI1MnV1RE1HTWxtRVhGRGVu?=
 =?utf-8?B?YjBNMGFYTXljN0pkcWxUMU9YZDdONzdQVlI5b1dHNWpoRGh2c0VvTDhxTEhq?=
 =?utf-8?B?T3lhUitTOWVjSnRWa2FFR2tObEIxTFRxNnh3TlRrd3d6VERxTTlBbDhmcmhD?=
 =?utf-8?B?RmJ4bTZ5aEs1NFlnUGNlRDM4YXAzeXFEeFJINjNFbnhRNnZSbXVBNmV2akR4?=
 =?utf-8?B?TC9WTnJBYUt0NTM0UFVSazFqeDEzVnh2WHNoSW9lZHUrdWJlT2c0QmdIWk5n?=
 =?utf-8?B?RDRuWXc4ZmZkQytBeGNIdisrdXZtdlpaZ1pldFA2K29USzFZRVR4aENTVzJQ?=
 =?utf-8?B?SjRnZkw4QTRJdmtPVXVDUVJGeUFRdllNL1ZhMktuQlB1UDJiOGVPQWdXZ05m?=
 =?utf-8?B?VjIzUDkzMzVRY3VQRjRJT2tWcFhESVJOMThJeURGSDFFOE9vWXhQQVZUUTFH?=
 =?utf-8?B?QmFZRktQUlFqUVpkUmhxTEEvVXhMMEIvSWE3cVF6TTJpcXgvbWgvbTY5Wkl2?=
 =?utf-8?B?aG9IWUpGVVRtbWZVYkdJU0lWZG1tSGM1R3BTd0d5bzY2UkxLc0JEWDZMa0Iw?=
 =?utf-8?B?dGh5UFROTDVvNWRZYUIwMEdRT3ZxeCtLSWRVbnFzeEFSUlVOaTdBbytvK1Fj?=
 =?utf-8?B?Y2VwMDVWSWYxanhjbUlmZVkvSzg0TEFBVGpXUHlMWnRzckY4TndFY20zWHpR?=
 =?utf-8?B?UTMzT1ZRUHhDVVEyR0pvMTlXdERPQlpiVWtRdkFPMWQ0VVYyNnp5NjN0amxU?=
 =?utf-8?B?R0dkaktYSWFleUZhdWxUWlRSc2xwK3UwNnBZWnBDSkkveGdpaVdVWDZlWFJV?=
 =?utf-8?B?NVo1Um9JYktXOEtQWGh6RVJnd1FFdGV6WWl0MGFZWFR1WlJvUTFiOHAwNTFt?=
 =?utf-8?B?Q3V3Q1JnbTBEeUJoTExLZGFuUW04cDB6UndQaDhsaW5hUFVHclFQTzBFQWVv?=
 =?utf-8?B?MnRGd1dhaWFwV2ZaVHJhajJ3NGMyVnhJdEFPTGljRVZSVnp6LzlJSW1GN2ZP?=
 =?utf-8?B?WmlDcVJJNFNNcC9BOWZvYUQvODRkS3pJSFRMdDhRL1J2Y1ZLMHU4eW40a3FM?=
 =?utf-8?B?eW1EWjBpYlRNOExTTVE5MmFwWHhPenh2NWZ0d0d2V3pPdEUybXJPN25wQllD?=
 =?utf-8?B?djlWY3FZM3kvdWd1Y2haUS8zVlNrcHR2b2RndVJiZlZyZ1gwcGUwQzUzZDl3?=
 =?utf-8?B?QjBud2JxNTZZQjQwZEpzWVdoYWE2UEJvOFlIZjlGSE45aWttOFJZNlp0S0Rl?=
 =?utf-8?B?VjN3WGNaaEVHZ1AyamZmMEVMaGgya0lvVFJuOS9zVXN5cThPL1R3bmc0cVBt?=
 =?utf-8?B?Z2FwRm5xaFlLTlN6NVNSRENpRnlDeEo4QTlLOW1CNCtvOWdUZ3lCTnF4aUdr?=
 =?utf-8?B?SHFSa1psdmtBWS9qNGVpYjdGK2xVR3pkeSs4bFRhaFpaQmE5NVU3Q0xOK3Ra?=
 =?utf-8?B?QVZYbjU4ODNyTzZGeDJSa3cySFRPd2NiRWpWNEFXYWVTck5VTEd1TzJCZmtK?=
 =?utf-8?B?UUNNSVI5UnJRY3V3QlJwTzNoV1J0Ym1LMkcyZVl6Q0oyVFVjNXR4OVJaaVpq?=
 =?utf-8?B?emlCMDgzTUFqMk9hU3lJRWJyazJxMUpub3E2dENFMkc2bW50b3plbUk5M0o1?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68C3285AEB3A1341BCF4A691DD9899D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aced8bc9-a2b9-4eee-d2d1-08dbbf448230
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:28:36.5423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUG3I5weqwQ9i5uhnlc+fYUElMBr5+LpCHSK/ApoR92dp6VDWLmUTQNMmkdbRngmTCJcKK1gJ13urw5vFwrSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7443
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IFVzZSB0aGUgbG93ZXIgMyBiaXRzIGluIHRoZSBmbGFncyBmaWVsZCBvZiBzZ3hfZXBjX3BhZ2Ug
c3RydWN0IHRvDQo+IHRyYWNrIEVQQyBzdGF0ZXMgaW4gaXRzIGxpZmUgY3ljbGUgYW5kIGRlZmlu
ZSBhbiBlbnVtIGZvciBwb3NzaWJsZQ0KPiBzdGF0ZXMuIE1vcmUgc3RhdGUocykgd2lsbCBiZSBh
ZGRlZCBsYXRlci4NCg0KVGhpcyBwYXRjaCBkb2VzIG1vcmUgdGhhbiB3aGF0IHRoZSBjaGFuZ2Vs
b2cgY2xhaW1zIHRvIGRvLiAgQUZBSUNUIGl0IGRvZXMNCmJlbG93Og0KDQogMSkgVXNlIHRoZSBs
b3dlciAzIGJpdHMgdG8gdHJhY2sgRVBDIHBhZ2Ugc3RhdHVzDQogMikgUmVuYW1lIFNHWF9FUENf
UEFHRV9SRUNMQUlNRVJfVFJBQ0tFRCB0byBTR1hfRVBDX1BBR0VfUkVSQ0xBSU1BQkxFDQogMykg
SW50cm9kdWNlIGEgbmV3IHN0YXRlIFNHWF9FUENfUEFHRV9VTlJFQ0xBSU1BQkxFDQogNCkgVHJh
Y2sgU0VDUyBhbmQgVkEgcGFnZXMgYXMgU0dYX0VQQ19QQUdFX1VOUkVDTEFJTUFCTEUNCg0KVGhl
IGNoYW5nZWxvZyBvbmx5IHNheXMgMSkgSUlVQy4NCg0KSWYgd2UgcmVhbGx5IHdhbnQgdG8gZG8g
YWxsIHRoZXNlIGluIG9uZSBwYXRjaCwgdGhlbiB0aGUgY2hhbmdlbG9nIHNob3VsZCBhdA0KbGVh
c3QgbWVudGlvbiB0aGUganVzdGlmaWNhdGlvbiBvZiBhbGwgb2YgdGhlbS4NCg0KQnV0IEkgZG9u
J3Qgc2VlIHdoeSAzKSBhbmQgNCkgbmVlZCB0byBiZSBkb25lIGhlcmUuICBJbnN0ZWFkLCBJTUhP
IHRoZXkgc2hvdWxkDQpiZSBkb25lIGluIGEgc2VwYXJhdGUgcGF0Y2gsIGFuZCBkbyBpdCBhZnRl
ciB0aGUgdW5yZWNsYWltYWJsZSBsaXN0IGlzDQppbnRyb2R1Y2VkIChvciB5b3UgbmVlZCB0byBi
cmluZyB0aGF0IHBhdGNoIGZvcndhcmQpLg0KDQoNCkZvciBpbnN0YW5jZSwgLi4uDQoNCltzbmlw
XQ0KDQo+ICsNCj4gKwkvKiBQYWdlIGlzIGluIHVzZSBidXQgdHJhY2tlZCBpbiBhbiB1bnJlY2xh
aW1hYmxlIExSVSBsaXN0LiBUaGVzZSBhcmUNCj4gKwkgKiBvbmx5IHJlY2xhaW1hYmxlIHdoZW4g
dGhlIHdob2xlIGVuY2xhdmUgaXMgT09NIGtpbGxlZCBvciB0aGUgZW5jbGF2ZQ0KPiArCSAqIGlz
IHJlbGVhc2VkLCBlLmcuLCBWQSwgU0VDUyBwYWdlcw0KPiArCSAqIEJlY29tZXMgTk9UX1RSQUNL
RUQgYWZ0ZXIgc2d4X2Ryb3BfZXBjKCkNCj4gKwkgKi8NCj4gKwlTR1hfRVBDX1BBR0VfVU5SRUNM
QUlNQUJMRSA9IDMsDQoNCi4uLiBXZSBldmVuIGRvbid0IGhhdmUgdGhlIHVucmVjbGFpbWFibGUg
TFJVIGxpc3QgeWV0LiAgSXQncyBvZGQgdG8gaGF2ZSB0aGlzDQpjb21tZW50IGhlcmUuDQoNCg==
