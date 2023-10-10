Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5A7BF717
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJJJTs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 05:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjJJJTr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 05:19:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D554DA4;
        Tue, 10 Oct 2023 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696929585; x=1728465585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7JAStQ6nok0gq0kYTrywEfNe6FkCoVSQejKBEYcdpvg=;
  b=LqmkFEzPEComLUbyARESKKh3a6PGA8nRK6Dn2WHwfLDBg5FL/xGxN9u+
   l96jUPkWmJRJ670DadQ2iDCRTNxScVCHN3+j5bcBU+vfMo0yR6DgOkabz
   eU5Tvs8ChZNhju+ViehVdiKUpVx5irasLBkoyEoQVdffSHrH1ntD09Y/v
   Oo3n4Rp9wnqr3NihcWefUH2zNS3LIFEGTuMBvIvYqDTvEGxwihtURfvQs
   ilwCRzyDBlTSvfLisHGVG7S4ZjOqGjUAdLHK4M63bmBT+PvrGh2zzbVND
   R3mT+/IDYpHLfOj3UZ5ZqYMwdI6XBa38OQcSpwO3roiYoRoaxGboseQBg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="387185196"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="387185196"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 02:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="927067372"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="927067372"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 02:19:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 02:19:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 02:19:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 02:19:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 02:19:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgfzeCnNhPXGkJMBBEPqDKXrFsZGkJbcEs6dGMVLOJCMqhUNhspu+EfPkYyGpMK8ndq5pf8A8/JVxPd4yuM0jbAydciLAKxbbHvoWQgvJ2eQJO/7azm27l+nQEiUAwtuhtITQLIxyfED7L2UxZJK2xc59jzm813R76fpufVEq1Sm1IVGwvJJPHzwHT2eYzTjCVnSeITy+erDEdnUUYZiNsVUoOxr7w12LwAYgvu4LpSZcCYmulyNq5MoXXKiKImfUe+dzI568HarcCJy2vQeijkbsmsSD2KAwmVhYQcjuFGa+1p6hWKwDLug/Y3x/lLhs2G0lj4VF4MHhzVdcqOK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JAStQ6nok0gq0kYTrywEfNe6FkCoVSQejKBEYcdpvg=;
 b=GdFwIc71UrkGEHj+uRNucOayyYy2mPNnps5JznDV45cKCumRVI/78428kCH2yL4C9GOFawSyzu1wcW9/Q+fdvVHi9B3GRApicAjW1lF124D1Nv2ovfiLn/p60h7PDrZBRrRNHtIsbOyqBmWr5ghEH8pYZU7K76RnmB1N7Y+EuNYdtumHIaHv0eGaHlLzPlmafhgI5bA7UGvEbPwiCIX9gbIKus9Ca/mLbi+zOAN/0ooQy7bZYiHPOsdgfeLniFKfr60G1hqf+VTWI7xOhF2KBloso1N2xpBqRcp9qcXgAPVDC1LToh18cG6b7Ld8n2SK2AlynoorYVYAhq//knDa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6167.namprd11.prod.outlook.com (2603:10b6:8:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:19:41 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 09:19:41 +0000
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
Subject: Re: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
Thread-Topic: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
Thread-Index: AQHZ7csxMWGpeN5dZUG6Wyp0ITB+SrBC2jGA
Date:   Tue, 10 Oct 2023 09:19:41 +0000
Message-ID: <d636415d6ab617368b9689fefa58390339dd8c0d.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-17-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-17-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6167:EE_
x-ms-office365-filtering-correlation-id: 583273d0-75cc-44c4-95b7-08dbc97208aa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4YMz6UD5QZtXkdyvH9yUj8WTAxD4kzkdDIVh8IwBVjwdr2j1SRrte6jDiFzdLc32AQMC6JC8FUka1vcK2LMHPt2/fwRegqng7R7AGEF9o211WMhd7SDuTmnBeCZhMQqOlWEJcn5xcDoe3rRcaeXrGB2j+ew7eG/u4iORb8ls+C4nQRCIFmhRoSg8GDibjn0qK82a+a1pIaqqm+8+Rf+u9axhqzCaAkcutkca7bg9jvR7gxiUVfUlqR2JPxaQknlZBgdEfi9lQh/wLyY4/jWfMDlXDfNw7aJ/02jAyagahMix4JJfSagkeKpCprvYT14VH9ITO/r4VDL6kfC0gIDW3N3DVRem5mv5FBqY/M/AETWhipUJ+PBLYjqQJDmvJcUIe2Of5QIsTVCKbSk5adrabZcXjnMPLyihrljOAUbKMq27SLZXHN8k9rMEVnmx0VcM4qkT30Xe4qZ1HCtJyRgbEvJclPW94tl+hhN/S97OOkEhqwPjE4JCh07ngY2TLMeDbspFunkgQNpKr/jdt5SJJkZqBjszOJaLLYr380tzndqO9/+0zn8ZPLnjMLgjQ9kMYnif+rbPlwczHRmCbxLtWUZo0h9E1wC73ywy9q+/hG5pcf8W0TZ0c9l896rWQv9O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38070700005)(82960400001)(921005)(122000001)(38100700002)(36756003)(478600001)(6486002)(5660300002)(6512007)(41300700001)(8676002)(8936002)(71200400001)(2906002)(4326008)(6506007)(83380400001)(2616005)(66556008)(66476007)(66946007)(7416002)(110136005)(76116006)(316002)(91956017)(66446008)(54906003)(26005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmpFRkpUUjdRMmUrSndNdldKUklTenVOeFk3Q0pyeVQ2SGZrakVFbTFXMW51?=
 =?utf-8?B?ZWx0eWY2Ry9HbldXRnlBamxTTzhnbEdpQS95TnY4cnI0b2Z0RWIxTWRCbE91?=
 =?utf-8?B?d2N3cUJ0SGJ2TjJ0T3o4emtzc2hnYkNxUG0zVUpZaGU4R3lLNlBKUXlpVXpv?=
 =?utf-8?B?NkEyM0N5SWFXT2l0ZGxRS0V2YVgvY1kzUysybkRScTdvU2creUw1d0Z6cnNO?=
 =?utf-8?B?RTdCb3d2NGxZeXlzcEJoZkJCL0wyYk9GUURjRGt5R3VkbldUNVdYSWFwZi9I?=
 =?utf-8?B?VVJHalN1bFVtQVVCVkttdHBYWnNUN0J4NTVGM2RYL2pBcC82L05GbmVSV2dE?=
 =?utf-8?B?dkxZeGVnMUxOVzVGcFlBZjZKSzd1c1hEanVMNStYSVh5WTMreTAxcFgvN0wy?=
 =?utf-8?B?L3ZUeWxYY3Erc3R0QXpOQ1ViaXhXcEVkQXQ0Q0JlRWNUZENRL25Dc05SeDFh?=
 =?utf-8?B?c1VhWU8zRTZKd2daNDkraW1BSGNXOXpJeGJ6UFRPUVE2TVlUQVpaOUZTQkNH?=
 =?utf-8?B?c0R2SDhBV0hDUllwS0krTC81d01RNUNPa1d5ZWg5U0Q2eXF6QmlmaWkvSUpr?=
 =?utf-8?B?ays1RkFVSlcwUFN1WVd3aVlSeDc0VjRVSm9INXAzeFBtMzNpeGs2eWgzUVZV?=
 =?utf-8?B?SFB1aXc4ajJYbGJhUEJZc2QyVDBpRzFPa1lOQUMzSGh6am1JbDZMV2FIWGVz?=
 =?utf-8?B?ODBsUlEyVDNzRTdSbzMvNzRiMFBVZVgxNDJwWHB2UWJMNXhZbmlzaDNaQS9h?=
 =?utf-8?B?WFk3NFF2ZGJERlR5QWtzdjBmQ2VUMy91bnl0Y25FUE90WEJwT05VS0I3MUE4?=
 =?utf-8?B?eEdnMVBFMTZyem1HUzVjK0dqdTB5ajdpTmJId1NMOWpRaGxlbVlCdXBhcEJm?=
 =?utf-8?B?V0F3blE4a0dmdWNoMEVjVUE4Rk5jeS9MUjJqaGNSL3lyUEpCQ3NHS1RiSUNQ?=
 =?utf-8?B?THZZSGtpeVlEc2lEYVdHcmNYMDlMWEtTVFpqTDNMNEZYaWhoZmFvSGpTSkxQ?=
 =?utf-8?B?eC9OTEQ4Nlo3VmR4cHZ3WWFuTmhUM3B2MnQ2VklSakZOVXVDZEFWbGljZmpt?=
 =?utf-8?B?cE9maVhDN29ETDFYK0hPUzVNZHh2NzBITXY3WWxKTWpNTWd6Vzdjdm9Bd0hC?=
 =?utf-8?B?ODJzYTFUbUxKbVpzd1pmQzRaRjRlbWtDdXA0VERWZlRES1IvcHhuMGhwbHVw?=
 =?utf-8?B?SHQzSUlCcDk2QWhsMXVQRllxdkVWN0NCSXNydUp6N3c1RW1qa3FxRS9QMjA1?=
 =?utf-8?B?U2JaRjZGcDFINmplVDdpMXNQeUFReC9JMEovMTR3djR0eFdqYTJqSXlmVUxq?=
 =?utf-8?B?TERUTkM3MHpLcUJtWHBRZk5FRll0N2h2Y2M4by9VZStyTm5MRFQvRmdlUU9s?=
 =?utf-8?B?dzNXVXZaVTR4V0x6NEROeEpxOVR6eTR1TzNjNFpQNnhtQTBIdkdkZzlCZi9q?=
 =?utf-8?B?cXh3b0lreTAwN1lKK2FaR1lHbWpMUGxYaUtRQmpLbVplalJDazNpUi9LcGpK?=
 =?utf-8?B?V0FlbGN0NnMzY2NKZVQ5NHFrZVRXRlYwTmFqdHVWRVF2VVNCMm9oeVQvc0I1?=
 =?utf-8?B?UlB2Z1FrRG82V0p5V1hjbUVDUHl0Sko2THdUQ2Q0MWJ2OWlvUGU4VVMyVmVt?=
 =?utf-8?B?TEIwSWExQVFpQU8wR1REbUcra1VKVmw3TGk2bCt5Qm0yQ0dUZW5Xakh2Ynp6?=
 =?utf-8?B?K0VYbFZqZFlUUTlwQ2Q1M3R0RmRrMkRrbW9KeVJHbS9nY0dnVCtJamVNN0Jp?=
 =?utf-8?B?MldYVURmV3A5a29EdzlCN0lzZ2I1c0Y5bE5vb0kzNjVYR3prQlpNeDFOazBW?=
 =?utf-8?B?R2xBUTBNK3dHOXJUekFvdTVIRzQwOThTSjViRDFmNkh3Q2dzc3drWjF4UVVp?=
 =?utf-8?B?TkpITkk4d0gxZ1FYOUdwSGRiYVUyMUlzWEVGNFh3ZW1SVUtNUDJuMlFWaHli?=
 =?utf-8?B?VUs5SzJHNVkrbWg5WXB1YWZoS0JSdUNsNGhxRTYwc0o0M09weGp3K0pZUWJF?=
 =?utf-8?B?QkV0VmUxaU91KzlZSTlJUngxQURUYm96czREaW14ZFk4ZUFEZEZSUEVBU1U2?=
 =?utf-8?B?NEdHSENqc2RhTGVHUUs0QzNYT2hMNUNoRjBSWllEQjJ4TEk4Y094czhtZDh0?=
 =?utf-8?B?WDJXYzNtUmtaaFh2U2ZBbmNnK1RkM2lIZEZBb0ZVSmxiMXVhbHBTWnBBcTgz?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0AD37551421414E96EA55243B8AC752@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583273d0-75cc-44c4-95b7-08dbc97208aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 09:19:41.1607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCwhuYjmA53Bfp7a2LJZaz+vJa1u0jNWxvTX+8K2UKsnpH4/9gbboAFrR0n+Gmgle3C5Lbg4NEFCjS5EjMiGug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6167
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IHNneF9lcGNfY2dyb3VwICpzZ3hfZXBjX2Nn
cm91cF9mcm9tX21pc2NfY2coc3RydWN0IG1pc2NfY2cgKmNnKQ0KPiArew0KPiArCWlmIChjZykN
Cj4gKwkJcmV0dXJuIChzdHJ1Y3Qgc2d4X2VwY19jZ3JvdXAgKikoY2ctPnJlc1tNSVNDX0NHX1JF
U19TR1hfRVBDXS5wcml2KTsNCj4gKw0KPiArCXJldHVybiBOVUxMOw0KPiArfQ0KPiArDQo+IA0K
DQpJcyBpdCBnb29kIGlkZWEgdG8gYWxsb3cgcGFzc2luZyBhIE5VTEwgQGNnIHRvIHRoaXMgYmFz
aWMgZnVuY3Rpb24/DQoNCldoeSBub3Qgb25seSBjYWxsIHRoaXMgZnVuY3Rpb24gd2hlbiBAY2cg
aXMgdmFsaWQ/DQoNCj4gKw0KPiArc3RhdGljIGludCBfX3NneF9lcGNfY2dyb3VwX3RyeV9jaGFy
Z2Uoc3RydWN0IHNneF9lcGNfY2dyb3VwICplcGNfY2csDQo+ICsJCQkJICAgICAgIGJvb2wgcmVj
bGFpbSkNCj4gK3sNCj4gKwlzdHJ1Y3Qgc2d4X2VwY19yZWNsYWltX2NvbnRyb2wgcmM7DQo+ICsJ
dW5zaWduZWQgaW50IG5yX2VtcHR5ID0gMDsNCj4gKw0KPiArCXNneF9lcGNfcmVjbGFpbV9jb250
cm9sX2luaXQoJnJjLCBlcGNfY2cpOw0KPiArDQo+ICsJZm9yICg7Oykgew0KPiArCQlpZiAoIW1p
c2NfY2dfdHJ5X2NoYXJnZShNSVNDX0NHX1JFU19TR1hfRVBDLCBlcGNfY2ctPmNnLA0KPiArCQkJ
CQlQQUdFX1NJWkUpKQ0KPiArCQkJYnJlYWs7DQo+ICsNCj4gKwkJaWYgKHNneF9lcGNfY2dyb3Vw
X2xydV9lbXB0eShlcGNfY2cpKQ0KPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwkJaWYg
KHNpZ25hbF9wZW5kaW5nKGN1cnJlbnQpKQ0KPiArCQkJcmV0dXJuIC1FUkVTVEFSVFNZUzsNCj4g
Kw0KPiArCQlpZiAoIXJlY2xhaW0pIHsNCj4gKwkJCXF1ZXVlX3dvcmsoc2d4X2VwY19jZ193cSwg
JnJjLmVwY19jZy0+cmVjbGFpbV93b3JrKTsNCj4gKwkJCXJldHVybiAtRUJVU1k7DQo+ICsJCX0N
Cj4gKw0KPiArCQlpZiAoIXNneF9lcGNfY2dyb3VwX3JlY2xhaW1fcGFnZXMoMSwgJnJjKSkgew0K
PiArCQkJaWYgKHNneF9lcGNfY2dyb3VwX3JlY2xhaW1fZmFpbGVkKCZyYykpIHsNCj4gKwkJCQlp
ZiAoKytucl9lbXB0eSA+IFNHWF9FUENfUkVDTEFJTV9PT01fVEhSRVNIT0xEKQ0KPiArCQkJCQly
ZXR1cm4gLUVOT01FTTsNCj4gKwkJCQlzY2hlZHVsZSgpOw0KPiArCQkJfQ0KPiArCQl9DQo+ICsJ
fQ0KPiArCWlmIChlcGNfY2ctPmNnICE9IG1pc2NfY2dfcm9vdCgpKQ0KPiArCQljc3NfZ2V0KCZl
cGNfY2ctPmNnLT5jc3MpOw0KDQpJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgd2h5IHJvb3QgaXMg
dHJlYXRlZCBzcGVjaWFsbHkuDQoNCkFuZCBJIHRob3VnaHQgZ2V0X2N1cnJlbnRfbWlzY19jZygp
IGluIHNneF9lcGNfY2dyb3VwX3RyeV9jaGFyZ2UoKSBhbHJlYWR5IGdyYWJzDQp0aGUgcmVmZXJl
bmNlIGJlZm9yZSBjYWxsaW5nIHRoaXMgZnVuY3Rpb24/ICBXaHkgZG8gaXQgYWdhaW4/DQoNCj4g
Kw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICsvKioNCj4gKyAqIHNneF9lcGNfY2dyb3Vw
X3RyeV9jaGFyZ2UoKSAtIGhpZXJhcmNoaWNhbGx5IHRyeSB0byBjaGFyZ2UgYSBzaW5nbGUgRVBD
IHBhZ2UNCj4gKyAqIEBtbToJCQl0aGUgbW1fc3RydWN0IG9mIHRoZSBwcm9jZXNzIHRvIGNoYXJn
ZQ0KPiArICogQHJlY2xhaW06CQl3aGV0aGVyIG9yIG5vdCBzeW5jaHJvbm91cyByZWNsYWltIGlz
IGFsbG93ZWQNCj4gKyAqDQo+ICsgKiBSZXR1cm5zIEVQQyBjZ3JvdXAgb3IgTlVMTCBvbiBzdWNj
ZXNzLCAtZXJybm8gb24gZmFpbHVyZS4NCj4gKyAqLw0KPiArc3RydWN0IHNneF9lcGNfY2dyb3Vw
ICpzZ3hfZXBjX2Nncm91cF90cnlfY2hhcmdlKGJvb2wgcmVjbGFpbSkNCj4gK3sNCj4gKwlzdHJ1
Y3Qgc2d4X2VwY19jZ3JvdXAgKmVwY19jZzsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJaWYgKHNn
eF9lcGNfY2dyb3VwX2Rpc2FibGVkKCkpDQo+ICsJCXJldHVybiBOVUxMOw0KPiArDQo+ICsJZXBj
X2NnID0gc2d4X2VwY19jZ3JvdXBfZnJvbV9taXNjX2NnKGdldF9jdXJyZW50X21pc2NfY2coKSk7
DQo+ICsJcmV0ID0gX19zZ3hfZXBjX2Nncm91cF90cnlfY2hhcmdlKGVwY19jZywgcmVjbGFpbSk7
DQo+ICsJcHV0X21pc2NfY2coZXBjX2NnLT5jZyk7DQo+ICsNCj4gKwlpZiAocmV0KQ0KPiArCQly
ZXR1cm4gRVJSX1BUUihyZXQpOw0KPiArDQo+ICsJcmV0dXJuIGVwY19jZzsNCj4gK30NCj4gKw0K
PiArLyoqDQo+ICsgKiBzZ3hfZXBjX2Nncm91cF91bmNoYXJnZSgpIC0gaGllcmFyY2hpY2FsbHkg
dW5jaGFyZ2UgRVBDIHBhZ2VzDQo+ICsgKiBAZXBjX2NnOgl0aGUgY2hhcmdlZCBlcGMgY2dyb3Vw
DQo+ICsgKi8NCj4gK3ZvaWQgc2d4X2VwY19jZ3JvdXBfdW5jaGFyZ2Uoc3RydWN0IHNneF9lcGNf
Y2dyb3VwICplcGNfY2cpDQo+ICt7DQo+ICsJaWYgKHNneF9lcGNfY2dyb3VwX2Rpc2FibGVkKCkp
DQo+ICsJCXJldHVybjsNCj4gKw0KPiArCW1pc2NfY2dfdW5jaGFyZ2UoTUlTQ19DR19SRVNfU0dY
X0VQQywgZXBjX2NnLT5jZywgUEFHRV9TSVpFKTsNCj4gKw0KPiArCWlmIChlcGNfY2ctPmNnICE9
IG1pc2NfY2dfcm9vdCgpKQ0KPiArCQlwdXRfbWlzY19jZyhlcGNfY2ctPmNnKTsNCg0KQWdhaW4g
d2h5IHJvb3QgaXMgc3BlY2lhbD8gIEFuZCB3aGVyZSBpcyB0aGUgZ2V0X21pc2NfY2coKT8NCg0K
T2ggaXMgaXQgdGhlIA0KDQoJaWYgKGVwY19jZy0+Y2cgIT0gbWlzY19jZ19yb290KCkpDQoJCWNz
c19nZXQoJmVwY19jZy0+Y2ctPmNzcyk7DQoNCmluIF9fc2d4X2VwY19jZ3JvdXBfdHJ5X2NoYXJn
ZSgpPw0KDQpUaGF0J3MgaG9ycmlibGUgdG8gZm9sbG93LiAgQ2FuIHRoaXMgYmUgZXhwbGljaXRs
eSBkb25lIGluDQpzZ3hfZXBjX2Nncm91cF90cnlfY2hhcmdlKCkgYW5kIHNneF9lcGNfY2dyb3Vw
X3VuY2hhcmdlKCksIHRoYXQgaXMsIGdyYWIgdGhlDQpyZWZlcmVuY2UgaW4gdGhlIGZvcm1lciBh
bmQgcmVsZWFzZSB0aGUgcmVmZXJlbmNlIGluIHRoZSBsYXR0ZXI/DQoNCg==
