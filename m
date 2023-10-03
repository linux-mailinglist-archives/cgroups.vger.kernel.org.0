Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D7F7B722C
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 22:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjJCUEC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 16:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbjJCUEB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 16:04:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB459E;
        Tue,  3 Oct 2023 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696363438; x=1727899438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wx2GO56inGJ7QcH3EfwEsRiOguz/RR8zO5ixZaYW8FU=;
  b=DzbY9BkWxm6LQ7RLaXh8uH2np5v12NMbd646HcGj3KRATyJseQPBQ3G4
   zXLT3BVfZQeKC7YUTZ6dDesJLykeOr1uDR2i4tZkm2gM6BnPw6CFWkEdu
   I0CFiFWprNlaMfpVSLsYZ9YAZFXf4VeSXYgm61/DPdBpJxjF2xu3iVFAb
   z6ge5dg1Q/Q8lvn3fyHxttz7vZ/TvZ7utJGev9vvHcxaJ7J+n9S6xMTnB
   dih+rUPSwFpaEArOepSQ5YTTOp35XjTTCElIBXk6iiFmD/+mKFv8SC2/t
   fvBAx3uBErA6896OG/5QNt1uV+G4DjdLyT9xsR63tEtD+A1xYOl2fcJ6b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="368025786"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="368025786"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 13:03:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="924781012"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="924781012"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 13:03:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 13:03:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 13:03:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 13:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJaFHnqVSovxy9eCTj+5gVGXS+betqdYBjOoEryvA6ZV3sBsQVx2rHykSLg+3gLl6BVCwVpxc2dZbQ1p4KppLhTXAo5bzjlpba3V5+g4j0jm+MdDhdhaECG3Q1lSbDbspt5fyD0hfC42PzH91K6MDpouHc401XLW5K5qF3gSv4BSY0N8AKNQMTCqwQvEPSCC24kDslMi8Cm+gJl282JaCqo2YilFLFmwRU4lSQzZ/1zx6JPAg8mGzM4vB34u/bUT5UGQ3rcf4owACZsJu+YezirvvXmYrz3Ie1HQiMN9h2C15HWft5jWKpRQKwGfYu2uTM0kkEJIVFv3j0Dj/fKjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx2GO56inGJ7QcH3EfwEsRiOguz/RR8zO5ixZaYW8FU=;
 b=Y01W1cPaIR/S7RQ1XOauSVD7I8PkYj2gEIPj1iJCO9R5uK4DtJbA5ptSYHsU+T4uyyFcrGP1ThZB8aFiyU4a1nBGWM3qBP5/+GlaxBzrkeECrQHrjMVoqRd+qqU7VFfZifWJmOomoddq78/VgEdYYIW4buRETe+zPP01kf6w09ERf3qviBnqZW5KZoejk0Kg0IVdL3e5G8VfT/l2fgYqIzZ9WpsAQv4NrE/pG8kQ/KN3ctCwUJxk3Axt5UWUTzywtAu6hE888f6YqCsHvSeoZopxzQ96K/IJDrJFkHhSdTZyI4pOOZhqBlc18GMYGhlsufoVoldiiqQX5gwE2bh98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7344.namprd11.prod.outlook.com (2603:10b6:208:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.39; Tue, 3 Oct
 2023 20:03:49 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 20:03:49 +0000
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
Subject: Re: [PATCH v5 06/18] x86/sgx: Introduce EPC page states
Thread-Topic: [PATCH v5 06/18] x86/sgx: Introduce EPC page states
Thread-Index: AQHZ7csUaq56ebRDx06C7sjZBwfv+bAufyYAgAkPTwCAAP9igA==
Date:   Tue, 3 Oct 2023 20:03:48 +0000
Message-ID: <0c296ec0011afc51b90d77db7a2b1ae0a239aff6.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-7-haitao.huang@linux.intel.com>
         <b1d7199262b9da496a04a36447541e9166f35f19.camel@intel.com>
         <op.2b72c4brwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2b72c4brwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB7344:EE_
x-ms-office365-filtering-correlation-id: af881ce2-44f7-43dd-42d1-08dbc44bdbb1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lgPOPo0i6x5ud3I1eXiRswGgNQzmQs89/ke7shQ1xCjXnUOPE+JDK1sbL3SrpD4U9PNabHcqStfc/QQrUjnHo4kPYbqqxUvs0eDSU3pQjfQLyk4dS3xaxfHhmmS22AaZfEVYNJOskM5LU8/t+t/U2HkhFZ+Jq37c+w6FJkalt99XL7Xa7oIJuqCUp5azbDp7AkJxxHIj4/TGd9hJQb6Y4PNILjqHpE9D6eZrfO11/zZZmzqjOBvgaggxF4jQZiv3z9yzlrFjh6E7RWjcpM33pPsursxzl7MVeQj9wJLrzDv3hjKGrq8PtDSmrimxmTj+A1VfvfviVGXpeB9VwZjdgFgbaE1cF0RiNnuB267k0d79OU5aRxTT87JO2GvjUBzGZ4qqzwnMTa+Jk8D8EfDO36hOjZrc32YqWmAxqQf50OZ3dn5l2Al7MSmr0Vm060+o9EEOqXgbCLmHg+K14JPufhV2UIf/LRl6z3/peiV5+B4xJ5vcJlmksssFPEWRcp9MgMcfY6GqNeDD3CvzBw/CDYBr4YFAl1Fo8mzoExz9C50J5BMb7Sj/ol45+qhGKujfCXLdl25OaH60Y8mG9u+VIyyHje6JDNNbAaTG0o+C84+A2ZOIbs8JcxSRE/bhoK/KJpRar6EswVF+NkpZdAnTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(346002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2616005)(478600001)(41300700001)(91956017)(6636002)(316002)(6486002)(64756008)(66446008)(110136005)(66556008)(66476007)(6506007)(6512007)(66946007)(76116006)(54906003)(8676002)(4326008)(8936002)(26005)(71200400001)(5660300002)(83380400001)(7416002)(921005)(2906002)(122000001)(36756003)(38070700005)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk1wdHByL2FsTVllaTZhamVvTGszV1M5M3RuL1hrTFdFcXZocW51dVQreC9P?=
 =?utf-8?B?SmxhcmlkcVY5aHhsNlB3TVZ0NlU3dlVSOU1UNHF0L2tSaUhnNkhZSVNxcm52?=
 =?utf-8?B?SCtnQWh6M243dnlBMlZBV3B0dUxDTXNtcjMwcWMxdXp6bVUyK05NWmxpSjV2?=
 =?utf-8?B?WTBsaXNFRTQyZTlTTzVvcCt1aCtlSWRqeHQxRXdiZXJudUQ0c3NaYnhEUDN0?=
 =?utf-8?B?MWtOendPZHBJQTJEQTdEZkxCV0JzZS82ZzN1aC9TSjVKMCsxcWRlcW5XdWhK?=
 =?utf-8?B?V1puOCsrQ3FaOFF6bVFUaDFObmJKYW5rQXB2VlY5SG5RSkpiSFRDdmZ3c0cw?=
 =?utf-8?B?YTlnSEV5SE1odmlvOEFvNFBoeEVodGE0dDhyNmhKSFAvbGUxWWs3dG9obFJF?=
 =?utf-8?B?azhJR2pEbjJ6YzFPUHZINmRMaE9Ic053MGVzY0RmczVxWExpN2h2bUx2T2tx?=
 =?utf-8?B?UFpid2tETFlaY0RVaVJzNTh2bVRZMUVsQVFuS28xWEJaUUZKMlBXSUkrMWNH?=
 =?utf-8?B?eldOcndHU1BGRVhWZDg2aUFxSFMxeVhjd2FGTWdwaDVzaVI4YS9zejhEckdP?=
 =?utf-8?B?bDZsK1dhOGM2RlAwWk1VT1dOdGRxUkpkd2x2VndwNHFEOENQbDdkbHQ5WE5v?=
 =?utf-8?B?a25tcllJTU5nWU5qS1Zlb09kM2pZNkJEdjkyOU1tRWZYQ3NqR1VjaHhCbk80?=
 =?utf-8?B?QlR3NDg2ZVUxQ0UwdWN3QW1ZUU9BMUo4Vlo0aTRpeDhMbWw5RG1RQzdSTDJQ?=
 =?utf-8?B?MElsMUFtbzkvSnVFaVhOWUVZdUptUUxEL2g1UVd6Sk5aa052czZYVEtSSk83?=
 =?utf-8?B?ZXdDVmNqYm9jWXErYXllLzFrdlBPVjA0WC9WSDBWaDdqaFZhN3JVUVZtWlhm?=
 =?utf-8?B?amFsN3dIMEFDSFVDWUdHUjA3aHV2VDZlY3FiaDBqRkdaUklVUWNhUnFFbTRS?=
 =?utf-8?B?SnorNkpERmo3UDM0K1N2cDZUZGxLRWhuZXZCTFoyV0gveUV3aWN3UjJ2cTFQ?=
 =?utf-8?B?QXRYZUh3dUdVNUIrNEF2Wm1FcGhlQWQ4TXhqLzJGbldzN1Voc3pVNUxvcHhx?=
 =?utf-8?B?YStWYnE1L3R2NkRIOURVYWNZSUpHUTFtQWp1SUV2c2wyVTZGcExmTmc1Uk1B?=
 =?utf-8?B?cjM3VFJ6VDZGMmNQT09GRHdYYmtYQ3cvditEaE8yM2EwUE8zQlU4UjJqdCtR?=
 =?utf-8?B?QWxOSVBoQjdXZmYyNHlhd0FJSy9KYmJjUzBjYjRzdjROV1N6KzUzOHd1QUZl?=
 =?utf-8?B?QkNBNk5qWk41SFlSeVVrMzgyd1N0WFhkbGtOdUFZNWU1b1drKzBOOUp1SGhQ?=
 =?utf-8?B?eTdCa3BMcnRtYzV6dHd3SWlEK01yaDFtOUpzNm52Q2hhbURsWFhvdXhCNGVa?=
 =?utf-8?B?ZXhMVElLbHBHTXBZTjh6ejBGSlZMZUtFSUhmWVVrb3ZSWUdMQzNFT3lGM2RS?=
 =?utf-8?B?OExKQTlqMG44MWNFQ3J6WWZwS2MvS0tqTU5ub21CWlFCMHJRRFNuTmRHVTVv?=
 =?utf-8?B?N0R3YjlDekVteE1UamhBeHlwV2Z6RnFWYmxqN3pGV0o4bEF0cUxrZE85d005?=
 =?utf-8?B?eU1qWDB5VEdrZTk0SzdQTUpXeVdFcXJ6aGRsMS9pYVBYMnFyMmQ3QzVmbWp0?=
 =?utf-8?B?UkFVUHdlc0dsd1d2bWtvTHlab3lFcDhDRlVBRFdEYmxtZGpDUTJYM2t1NEdz?=
 =?utf-8?B?WW84ZDMwYXhIMlp2YVhnbVJTWEN1MWJtckdOb1BiRDlYekpuanFSUm1ZNTJF?=
 =?utf-8?B?cGJQUUIwenVvdEMrMWFWakNyaHJyNmNjWXEyRitBbXdyUTdUQ2pJdnpFQ2Js?=
 =?utf-8?B?T2tUUUNlclp5TW94UzFpb2lEZVdkUFpCYjBOdE5DcHdXZVlNQXNGeXAydTdM?=
 =?utf-8?B?VU9aUGQzZXA3eDRKMkFpRklaNVpqMTA0ZHRJUnF6N2I0NjhUcnhyY0xqSkc3?=
 =?utf-8?B?eW9vNWlMMmdZbDB5QlY1ZXF3K3NjYitoMTYwUkFkVjIyL2tDWHhhckpxQnYr?=
 =?utf-8?B?aUxsc3ZXcGxnSHF3ZlB3b204SDVhL2JVcTUwS0gzbFUydjk3bVhBL2ZIZi81?=
 =?utf-8?B?WllqRCtrTEdSU3dXd2RmSFlEMnlSUHpqOHRWWkVWNDFQSEFqUk11b0lsNWtj?=
 =?utf-8?B?Q2dmVEk0TE5adEZJT3BXOTdHNy8xZjFScCtjdWZlWjdINk9rZlVGQ1FuNndY?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DB57637893E4541806C9638453E3072@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af881ce2-44f7-43dd-42d1-08dbc44bdbb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 20:03:49.0031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ir9Z+xXtMtDFRFmUfDmCpvsyLZAlYiS8Hij7pC39I4DAqZFyxEFbXaU2pIDouJDVfT92nEjpsSVx66WGX8EFIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7344
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTAyIGF0IDIzOjQ5IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFdlZCwgMjcgU2VwIDIwMjMgMDU6Mjg6MzYgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBGcmksIDIwMjMtMDktMjIgYXQgMjA6MDYg
LTA3MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IFVzZSB0aGUgbG93ZXIgMyBiaXRzIGlu
IHRoZSBmbGFncyBmaWVsZCBvZiBzZ3hfZXBjX3BhZ2Ugc3RydWN0IHRvDQo+ID4gPiB0cmFjayBF
UEMgc3RhdGVzIGluIGl0cyBsaWZlIGN5Y2xlIGFuZCBkZWZpbmUgYW4gZW51bSBmb3IgcG9zc2li
bGUNCj4gPiA+IHN0YXRlcy4gTW9yZSBzdGF0ZShzKSB3aWxsIGJlIGFkZGVkIGxhdGVyLg0KPiA+
IA0KPiA+IFRoaXMgcGF0Y2ggZG9lcyBtb3JlIHRoYW4gd2hhdCB0aGUgY2hhbmdlbG9nIGNsYWlt
cyB0byBkby4gIEFGQUlDVCBpdCAgDQo+ID4gZG9lcw0KPiA+IGJlbG93Og0KPiA+IA0KPiA+ICAx
KSBVc2UgdGhlIGxvd2VyIDMgYml0cyB0byB0cmFjayBFUEMgcGFnZSBzdGF0dXMNCj4gPiAgMikg
UmVuYW1lIFNHWF9FUENfUEFHRV9SRUNMQUlNRVJfVFJBQ0tFRCB0byBTR1hfRVBDX1BBR0VfUkVS
Q0xBSU1BQkxFDQo+ID4gIDMpIEludHJvZHVjZSBhIG5ldyBzdGF0ZSBTR1hfRVBDX1BBR0VfVU5S
RUNMQUlNQUJMRQ0KPiA+ICA0KSBUcmFjayBTRUNTIGFuZCBWQSBwYWdlcyBhcyBTR1hfRVBDX1BB
R0VfVU5SRUNMQUlNQUJMRQ0KPiA+IA0KPiA+IFRoZSBjaGFuZ2Vsb2cgb25seSBzYXlzIDEpIElJ
VUMuDQo+ID4gDQo+IEkgZG9uJ3QgcXVpdGUgZ2V0IHdoeSB5b3Ugd291bGQgdmlldyAzKSBhcyBh
IHNlcGFyYXRlIGl0ZW0gZnJvbSAxKS4NCg0KMSkgaXMgYWJvdXQgdXNpbmcgc29tZSBtZXRob2Qg
dG8gdHJhY2sgRVBDIHBhZ2Ugc3RhdHVzLCAzKSBpcyBhZGRpbmcgYSBuZXcNCnN0YXRlLg0KDQpX
aHkgY2Fubm90IHRoZXkgYmUgc2VwYXJhdGVkPw0KDQo+IEluIG15IHZpZXcsIDQpIGlzIG5vdCBk
b25lIGFzIGxvbmcgYXMgdGhlcmUgaXMgbm90IHNlcGFyYXRlIGxpc3QgdG8gdHJhY2sgIA0KPiBp
dC4NCg0KWW91IGFyZSBsaXRlcmFsbHkgZG9pbmcgYmVsb3c6DQoNCkBAIC0xMTMsNiArMTEzLDkg
QEAgc3RhdGljIGludCBzZ3hfZW5jbF9jcmVhdGUoc3RydWN0IHNneF9lbmNsICplbmNsLCBzdHJ1
Y3QNCnNneF9zZWNzICpzZWNzKQ0KIAllbmNsLT5hdHRyaWJ1dGVzID0gc2Vjcy0+YXR0cmlidXRl
czsNCiAJZW5jbC0+YXR0cmlidXRlc19tYXNrID0gU0dYX0FUVFJfVU5QUklWX01BU0s7DQogDQor
CXNneF9yZWNvcmRfZXBjX3BhZ2UoZW5jbC0+c2Vjcy5lcGNfcGFnZSwNCisJCQkgICAgU0dYX0VQ
Q19QQUdFX1VOUkVDTEFJTUFCTEUpOw0KKw0KDQpXaGljaCBvYnZpb3VzbHkgaXMgdHJhY2tpbmcg
U0VDUyBhcyB1bnJlY2xhaW1hYmxlIHBhZ2UgaGVyZS4NCg0KVGhlIG9ubHkgdGhpbmcgeW91IGFy
ZSBub3QgZG9pbmcgbm93IGlzIHRvIHB1dCB0byB0aGUgYWN0dWFsIGxpc3QsIHdoaWNoIHlvdQ0K
aW50cm9kdWNlZCBpbiBhIGxhdGVyIHBhdGNoLg0KDQpCdXQgd2h5IG5vdCBqdXN0IGRvaW5nIHRo
ZW0gdG9nZXRoZXI/DQoNCg0KDQo=
