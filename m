Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9A7B175B
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 11:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjI1J2r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Sep 2023 05:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjI1J2p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Sep 2023 05:28:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9887994;
        Thu, 28 Sep 2023 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695893324; x=1727429324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iF2HEIp3HqtbhvUij70PYnlf3v9pqNpE5hb+T1vT02U=;
  b=IwPsdPoziP/Dfr/iYutygcKn5GcKrxR0IWivc2ZVznfrHy/a5Q2gzUv4
   CE5MYt45l0X21kt1TKghcKonGuHQDaqC+93EGvs0TchJsmO8jJ5jonvEw
   c2dUyDqqphfQbmjbB5h3fGXZ7YGRNRqKRcxa+VlG4fy8gBzHBdz0QHJwL
   EvVgk0gtLsMCgq6n5ZnjMbCya3NRE4jKG+ocrYPh/qqAoqT3w3fR5+m8g
   5Q5P1YzzGhINRJvixArYlzWvLn18+r7NrHOsflZAGSaOQtF7lmQCe2Pz3
   q+3Ojj8kVxo+padLfWtzYMSslWw5QFv03cqNcf9nUqwdNDO8tY5oYZHIV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="385883800"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="385883800"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 02:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="819775384"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="819775384"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 02:28:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 02:28:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 02:28:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 02:28:37 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 02:28:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdxCVnMqbNZkafKMpyYun4mbt3mheia6neVw6NyXHUTcGDlz7S2uMYthwrO/bzHUtMenCzLmyfidS/GTzU1FlEMhUXp8fvI+L8o2IqjwP6PmccIPls5+Uw4CVFzcUolVChysNI+BOh/Tvo7VjgZDTAU8XQG/uHAqjAJdcJvYgOJjYjU2IsGukfiYhbS2q2pepYnMg4KVY4l8oWyQazz49Wp3Vx/4Wjk3qqXxILVSiCEoYT+MDYJedgWkthORC6XuS8Mr2JQpSBeP1h70yDSoY1SP/bH1hcmquH9NRzxQmtGesgP4u8tH383DWn73IyMXjxpIApAYqa5e7s7OA+LbJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF2HEIp3HqtbhvUij70PYnlf3v9pqNpE5hb+T1vT02U=;
 b=innHIUClltM1aTxPZo6iFb3bXWvoiGfbOZ2b7jRGbSIvSKEHGsKS4mTQiQo69yM6rqOQcbvIeelBbz1nSdsGY6XEu10/V3aFgO5R/7vNFcqkWph4yRYfUp190OfE727Ic12h4HgrDRqXlSzpLXWsEPgO0f8Pc5VsVlC8MiitfvQNyKiiPsdCNZu4VE53LS0mB5ue7yHa2MTXK9Jy6/7042CNkQh8VTykuTli17RDN2tXXtzGsbtiw0AghunpXWLSTkOo+tCnAoLoTRYlX/iEFJ0AQ6IdrWEFqxyy6ZQyGLhJVjCy8tGs2DhRNr91I0Qf/VlfwiG1P4ePm7163kgPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7247.namprd11.prod.outlook.com (2603:10b6:208:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 28 Sep
 2023 09:28:35 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 09:28:35 +0000
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
Subject: Re: [PATCH v5 08/18] x86/sgx: Use a list to track to-be-reclaimed
 pages
Thread-Topic: [PATCH v5 08/18] x86/sgx: Use a list to track to-be-reclaimed
 pages
Thread-Index: AQHZ7cscjnbuytC22kGDS5B0JN3ckrAwALOA
Date:   Thu, 28 Sep 2023 09:28:34 +0000
Message-ID: <830b789caa2a6cfd735c83dee1aad3591b9272f0.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-9-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-9-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB7247:EE_
x-ms-office365-filtering-correlation-id: b8b31955-2558-48c8-94f2-08dbc00549ef
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QaJI+wBjzt53CThnS+QNvZKLXDEsIvdF8cP6NQi6095gok1TGsSm7AdUX3OCfOrtREPa6hr0t+AAi5LUtMRxOPJXEXCXuM6c5BRAYYM4PiseWCN87u3WM4hEqmabmvT4dIQC31BYJ3kny+Uoeuh73O4I28adsQEqAhQ3K4grO35zxzsuYOO6ISpgpTnLhWSRu83S1+r8OEcI+2d4NlBu1SHN/G+dcgWds2MQZ8oqCOZdjqHk+E+D4GMT467NdPSF+zYYfFaRSkH1vBozaxT+zIvjGN9rPFyKgQfZJS3MCgjeFXV+aQum6T5l24yCclKvqq8+RzHgJ42J7C/Gt5aji/kZVT/syyWonrQgrK4KLVu5thtdCsAU7wHbu3MHpqsiSZgeIZX0jIjtWgIg3OfkRIgSV/K3KMp5Iup0ZioCKLenJR/dBxeF+V4uXZesRNaxdjLMwYM9PQhHiFYD2jQ3B0mQWnjsjn/3yvm5SenSKFyAOsWFsIP6JDZF0Ws5F8ZIz46LYRG24GaLJq3olQEdR2CxmlycGTQPi69gfglAOYuQ9BbVHlSTqQzfZ0f0WY6Q32Bq2FSMgajTvQTA9v/uUJrIiy6xbcHr0T5KoE1Eyfkcqbap1q3HNeZ03PqLlTJkVSedwU3MRrrbWFUjvx6LIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(921005)(6506007)(36756003)(478600001)(82960400001)(122000001)(86362001)(38100700002)(8676002)(38070700005)(6512007)(2906002)(4744005)(7416002)(316002)(5660300002)(66556008)(4326008)(41300700001)(8936002)(76116006)(66946007)(54906003)(91956017)(66446008)(64756008)(66476007)(110136005)(2616005)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azUwZ20yd015bEpDc25rdmV6THJGNTN6QjJTV081SlVNNWFiVnBzUWo5S0px?=
 =?utf-8?B?cW5IWVVSazFFeGp2bkw1bnp4ai9TSm1QbGpRRE1oWE1leTVHamo3ZHdoZ2x0?=
 =?utf-8?B?bVF6QmVxOEJJNEVqZjhvWkRVSER6dzU2VlE1V2NQOG5oY0ZLUzBSMlc5NVdz?=
 =?utf-8?B?TG4xcmpKZWs0bkNITXdGdFBRUWljNHRWZnh0VVkxWXJqeWQzMWRnNlVyM2Vu?=
 =?utf-8?B?SHU5S0Jtc0tLaFE2SGI2RU0rb2pSTXZIejd0S0g4Zzk2WnlSY3pDMXhKNjNG?=
 =?utf-8?B?ayttNDdtMmlvdllzcmNxYlhaaEl2YlM4N0xqS1ovZExrQ3EwRGEyeVpOUDRH?=
 =?utf-8?B?SmZOQ0pVVUkwRWN1bnNSUzEwR05wVVVOWkh6U01CK1ltNDBkN1lVNm5ZV2U5?=
 =?utf-8?B?REdGdnN4UUZrMUE4bzJ5U2ZDelcxWFovdG5Bek5GUFh6QmE1bXk2M2hSOVVB?=
 =?utf-8?B?QUI0UlQvUHFjUTdVVFlzWHBrT1FabDZsOVM1KzZSWEF1TmVWMyt4U1RVSWVD?=
 =?utf-8?B?V2hqNTJ3Z3VTZjUvczZrUktyTzQxU05tbUdtdjUyQkZ1UVQwS0xpYk0rYUg5?=
 =?utf-8?B?di9mZVdIL1h6RDlKWnRRd1ZKcC9EV1ZQYjVwU3FoSXhnNGVhdWFrVXFqelYr?=
 =?utf-8?B?TEphRWFYYUhnb0w4K1dxZXNkNnB6NW80WmRPeG9UdnJqM2pHaWFKcy91QTQz?=
 =?utf-8?B?SEgrclB3eWxWc3RkRGFaUWRIb1VqNFRCQnZHelNPaHJ0dk5oanNBYnUyNHVp?=
 =?utf-8?B?cXpaaVl5SVA5SUI4RUNyUTR1dWJ0dS8xaStpbk5IdGVKSkZBQ21TYmlRM2Qz?=
 =?utf-8?B?dzkxaEpGSU1mV3dXZWJhMWpucnc5L1FuYi9IaUd1OVVnM0dKWFZscGdvcnJj?=
 =?utf-8?B?cjlJTGlOdHFsczZaNGxSczNoQUJlOFhDckpmZk03ZjdWTU5JWUY0aHByTndh?=
 =?utf-8?B?R2pISytxZHdMcnNGRUkzQUZkVVkvUGhRTXEwTEJIVERYVTJuRi90TUU1RjFV?=
 =?utf-8?B?T3czVGdUT3JuTEkrMis4dEtWQ3JWbFVRWFgvdHJhd0t3WXRJMVcvYlRuSmVa?=
 =?utf-8?B?UlFXY1JDMzFGcHlKT2VaMTVhT1VjbW1ldnY4dGdxY1NhUEJWaXFhcXVGZHQr?=
 =?utf-8?B?N0ovclhrR2NuUnB4V0Q1aktqVjlmVFNnN3JGbU5reE9uK1FKcG9WNmpmWnIz?=
 =?utf-8?B?cm5pOHNFNkdyd0ltTmljZ3RqODlHSXBxejErR21PQVNWajNna2wrYUl3a1lJ?=
 =?utf-8?B?QUV4dWYwRTRmd2crUnR4dEI1bzBXSzJwMVpHNHphdXNiUkhJZUllTVExbVQz?=
 =?utf-8?B?U0FvU3k1UDZ3V2E0TjdtbitzM3pnTDlqOVM1WDdGK0toK1VrTUFGWlR0eGJI?=
 =?utf-8?B?Uml6UkFJNW1sRDNHTjNUY3lhNENTd3dWeHgrNmFyejhpUkc3TFlDUURsWjVL?=
 =?utf-8?B?VkxuSWl6TWY3aXFPenBnWkRXaW9OR0t0UFlKTGJCY0s5dlljQzExOUtNb2gz?=
 =?utf-8?B?dHZCUTAzZ0xXVWVybEFKVFRKaGhERzZPeXcveGt5bG9PNjNTQStrYmNhRjZE?=
 =?utf-8?B?dDI0NXhGRE5POFZQNDRIVnZMcG5WeDlhai8rcENTTEMzRDQwdkhJZnZiV01p?=
 =?utf-8?B?cnArTVU5eXZzRlQyVUhPS0t2bjNXV2N5QW5BWG5EdTVqYi92UFd3MDJsUkJI?=
 =?utf-8?B?alM3aGl6RG9KWWVTeEV3dHU1ZFByb3lDZW1kNmxHY1FXOFlpWFJ2OXI4ZUFm?=
 =?utf-8?B?Q0xhVmYyamFtWjdFNE1xeU02U1UxbnNvc0MvR2crNG5ZOXlCVDNJb3o3eHBt?=
 =?utf-8?B?S0kzS1VVOTJzaW9CdFk2Z2I4Zkx0U2k3WUpaUHZuQlIrNFB0SFA5WjFIUDFa?=
 =?utf-8?B?SkFXUjNtbmxvWk5nRDBZZVNOZCtOU3JnUFZWb0ZNaGJBL3pDWVMwdHN6dnVr?=
 =?utf-8?B?Ylp4c3pWb1NxZkxUM1U4bk9GUEhiQ2RiejNwR2RRYkRnSUV5eU9YdGtER0kz?=
 =?utf-8?B?STd4Y25Kb1FsRUhVOTduRGtHV1NCTFpkVk1VUkxLckd3NW5jL1BycDlXd29P?=
 =?utf-8?B?b1ptcTllajdIeVRDL0szUHM5WTl4djRvTGcxL1lFU2Y3UXdDa1EyTVdsRFJn?=
 =?utf-8?B?OXFCRjNvcW4wWVJwdGxIbzhBWFdPeTdXTE1oTEVETkU3UFlTWXhEMjJiTTRG?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31F5952F089B5748AD757DE7AEC236AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b31955-2558-48c8-94f2-08dbc00549ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 09:28:35.0306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8znOgJBVT+wOQvGpkbVGQCzk2vG4VYVFv6H6L8WrcoxZ3QVqC62b5JSySuPJhWaMjZpnrTAf4fomRWx//wDAGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7247
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

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEBAIC0zMTQsMTggKzMxMywyMiBAQCBzdGF0aWMgdm9pZCBzZ3hfcmVjbGFpbV9wYWdlcyh2b2lk
KQ0KPiDCoA0KPiDCoAkJaWYgKGtyZWZfZ2V0X3VubGVzc196ZXJvKCZlbmNsX3BhZ2UtPmVuY2wt
PnJlZmNvdW50KSAhPSAwKSB7DQo+IMKgCQkJc2d4X2VwY19wYWdlX3NldF9zdGF0ZShlcGNfcGFn
ZSwgU0dYX0VQQ19QQUdFX1JFQ0xBSU1fSU5fUFJPR1JFU1MpOw0KPiAtCQkJY2h1bmtbY250Kytd
ID0gZXBjX3BhZ2U7DQo+ICsJCQlsaXN0X21vdmVfdGFpbCgmZXBjX3BhZ2UtPmxpc3QsICZpc28p
Ow0KPiDCoAkJfSBlbHNlIHsNCj4gLQkJCS8qIFRoZSBvd25lciBpcyBmcmVlaW5nIHRoZSBwYWdl
LiBObyBuZWVkIHRvIGFkZCB0aGUNCj4gLQkJCSAqIHBhZ2UgYmFjayB0byB0aGUgbGlzdCBvZiBy
ZWNsYWltYWJsZSBwYWdlcy4NCj4gKwkJCS8qIFRoZSBvd25lciBpcyBmcmVlaW5nIHRoZSBwYWdl
LCByZW1vdmUgaXQgZnJvbSB0aGUNCj4gKwkJCSAqIExSVSBsaXN0DQo+IMKgCQkJICovDQoNClBs
ZWFzZSBmaXggY29tbWVudCBzdHlsZS4NCg0KPiDCoAkJCXNneF9lcGNfcGFnZV9yZXNldF9zdGF0
ZShlcGNfcGFnZSk7DQo+ICsJCQlsaXN0X2RlbF9pbml0KCZlcGNfcGFnZS0+bGlzdCk7DQoNCklz
IHRoaXMgc3RpbGwgbmVlZGVkPyAgSXQgc2VlbXMgbGlzdF9kZWxfaW5pdCgpIGhhcyBiZWVuIGRv
bmUgd2hlbiB0aGUgRVBDIHBhZ2UNCmlzIHRha2VuIG9mZiBmcm9tIHRoZSBnbG9iYWwgYWN0aXZl
IGxpc3Q/DQoNCg==
