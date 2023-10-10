Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D97BF0D2
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 04:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441843AbjJJCXS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 22:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378796AbjJJCXR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 22:23:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275C6AC;
        Mon,  9 Oct 2023 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696904596; x=1728440596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CfXHdJ2BCB1r9HZA2tHnPPKBv9Cq4Kc2PS1XVYAlcJs=;
  b=Dj6TfzQ8yEA2di/vhC+pfFhVuPM/cyYT8RuGyN2u/lIdbIy+Lw2+55rk
   9l9dQs0bLp0T6pnL/S7avGOw6dyIy9QhUY0yTspPVEtLVwY9hXpHrzx0j
   XgZedJVPSAXsXKKTu2HgqYnZA05ZlKiTzwGM2VLknhQOEpCkfQe+mjU/6
   Qro6PKdWaFxxoefrsn6HLLwwO44w7vwT7Pb/FTqcALFONNczVcd/U/jFB
   iIpkdNIIdW0kiNN81wiO68zeXECdWUlZcu0IPHyiGGCKPGrS2joQoWbPJ
   DMIh/lNevXFEficMal+UZoBIHk+5Vjl0TqssAFbMz/Kqnu3Hk+xsk0erU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415290907"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="415290907"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 19:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="877049051"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="877049051"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 19:23:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 19:23:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 19:23:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 19:23:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVvg3BOL5hJmsGsq6lCHDvFIsGVpm3bA6W1IAEKIRORZkvetH7OKEEmOxCAuUXDkVXHWheUvb5GvadXTD2l6P6rSj/wTVU4DTSOt7L+DKG0isc7+aDgjUeyiYySBgly/+yOC30hLlCf26ol0AnIGSdQJP6oXxdHHN2WZ2IR0woQsedFluMnYOmTzTijLLpbYvqZZHCbDe/smU+LmKmsP95NjA8oCOnXhpCxQkbJ34XjWaPNPtTcb9L+svRlSUwxUdjg2a00s3HpU8a/rIkXz/pwYXg0fKNYidzdP7zkMUtOMdxzetKHqfArB2eQrQbbScwu6KpbHgyJKKelnKsvz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfXHdJ2BCB1r9HZA2tHnPPKBv9Cq4Kc2PS1XVYAlcJs=;
 b=EV/y53DkWcpQZ9vNkJwUpN6UgrWOst12f6/Vh/wohgY61G6UBtXyXZpaJNJ/aJHSUhuU6DqtBNB6lOY2gEVeUlIJUXpV06voNWnapZuplnI3F28Up9E257v8JrWLP1lnQU6L1s4vPlQH/Ta97JzVHc+SY6fB9dBbXBKlTtjKiXwoDsuA/q3G5TQ6dleNoms5FGzttgvFrppiUo7SUbO5wZpcHC60dDusgsw+J3bzcplEmwYn4ZV9ZTJZL113ixx13eccx/XEVraJnQ70F6D6VNs5lODPz5vgggllRitLZEQnnmzHLICHEHpwzXRSR9LwMpWywTRtS8STDUwsxLcMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 02:23:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 02:23:12 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>
CC:     "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAKoQCAABZDgIAAC0kA
Date:   Tue, 10 Oct 2023 02:23:12 +0000
Message-ID: <548d2ab828307f7d1c6d7f707e587cd27b0e7fe4.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <ZSSZaFrxvCvR1SOy@google.com>
         <op.2cksdjamwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2cksdjamwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB4933:EE_
x-ms-office365-filtering-correlation-id: 3ebbf7bd-3a71-42e5-bdc2-08dbc937da2f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZwvTV9q2Xt01CxOAGJuQeHs92ui9SGsplq6L0R6EpM4pPhwlmVh8+ExLnAuJh6CL4o4e/DBj9E40RWRMPhj5w5sj4nuzWUIlBa+sdtQdOL+/KFW/hPg6NaM+aN7VLWYhJsDx1WMPDNhe+YmlY9pA48Q1NWcMre66m4ClmLQQGX+0zxxYUv89mxSTMPFKXMNWbaExWtceKKt3m6zCpmaN39nQ0+Id8lqmZpcbGJ0IIVIOGT2XOkkZNS1G7VIvRuYgvO9OptJfXpDVkzxTSHp1F2gaDqNtjLGqbeExnj86RE2CLTjDzT2l1cncVeGv41juPp5rRA3XAf4IfH7gA9l+Q1DtD9osn1W+osZTJ3iDpSVPIeBtQovlTBTdfZmi9uFYfmqYM5C29bS2ec5r+yJR/2cTPQE6URQarRP8rPB2wn351iCXQSuzH2up6hHCOXdDIOZB72RVMccG9d5Jk3xWgx6sJB76v5ZdVjKop66nzCre9ZD/6FB6VwrU2hygJJM4rjvQIDmOK3KfWZ9h43OvVVedbzBdeKZzJ4dL6qoGWLW0JKV8SMrk1gA257c/+NH7foNWNa8pwr2PMYIbbqK+s5pjurDroN1yJzQdxe5+OsqIShRzJrWm2lIyPiCcOTbo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(122000001)(82960400001)(86362001)(38070700005)(38100700002)(36756003)(2906002)(6512007)(6506007)(478600001)(6486002)(8676002)(5660300002)(71200400001)(4326008)(8936002)(41300700001)(2616005)(83380400001)(64756008)(316002)(66476007)(66556008)(66446008)(7416002)(54906003)(91956017)(66946007)(110136005)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0Q5Z1FjQUNXTkZDQTM5YUJNcjFiR2h3YlJSTG5nbldMRG5UY2FOYjRReTll?=
 =?utf-8?B?UDhBR2xGTG1qQllzTlFPSFQzZVlMZVVvUHVJdG9TbG80SFg2NEVQUHhsbmZr?=
 =?utf-8?B?clVsdk1mWnJSekIyeDNNLzRpQmhEOWtIY0g0Vk9RdjUwUlpoTGE2LzdTc0sx?=
 =?utf-8?B?ZHlLc3Vjbkx1ajZ0dUF4TzE1ZlBUYWF0NnhjRUlPUzU4ZWI3bjd4Yjh4VXRY?=
 =?utf-8?B?bDNvOWJIZnF1bUY1SXNZYmxDQkRTRVkvbDFKSHdZWWE5NGtBMWdKazA1cUo5?=
 =?utf-8?B?UzJ2QXhIZDI2d2ZmeExZb1RkbmNQUDlnVHlOa0Y2dUJ3TE1ENTY4Y0wrTk51?=
 =?utf-8?B?dFcyMU1INllsUGhyZTh5NmdmeGtPQ1dEZ0t4NXZWRTNsU0k1bnREUG10L3lK?=
 =?utf-8?B?YTlEcVBWU3kzY0xIZEhhSWlvazlIdVlEdkI1TFZoQTd6ekhmMVgzRit0cGlO?=
 =?utf-8?B?anp4N0Y1S1JrRnlHZGhyRXlqVnlMYVRWSWU2a3RFWlY0K014N3NYUEVlOExY?=
 =?utf-8?B?K3hHL2VURDhERGRUbm4xcEpDOVhDZVdjdktPdVJPUW9vK2RtUHppNU5NMHJI?=
 =?utf-8?B?MkpReDY5c3l3OUQ3RnFXSmd0WkR2ZDNXQmNGcnJvajBFUmhCT2J1WkdlU3VR?=
 =?utf-8?B?L0Q1ZFNyUHc5bVd2TndsNFBDYzNpc3hwTFJSVUlZRDhmNDZ3TTZ0SGJ6R0hh?=
 =?utf-8?B?c2JxZytJaExXQ1RUalN4c1BidU9FWU01MytUdTg1VDZHRDgrQmtIMGRzSTZq?=
 =?utf-8?B?dlB5Si92aEVmSzhrRWtwWC94OTRaRE5HdCthNVJydHlKdlVvdE55QjN6ak5R?=
 =?utf-8?B?SUMrZmhSYUx2a1BZTjE4WWZzbEVVVS9CcXdrbFJzMHlleWRlY3U4eDFuNzZO?=
 =?utf-8?B?VHZTdkwycWVZZldaa2JHTXNvNElvd1JHTWY3TTNtdXVCeUFaaXBGM3ZMTmxh?=
 =?utf-8?B?V2U4blJMeFhETmtNV2xlQWxaTTE5azJDSFozaVB4bXBMaUg3RG5TSml3S2xm?=
 =?utf-8?B?T0lTb0crd3NETzJpTTZ5N3V4ME1ML0EwN3pSK09lK1NneWpoZFFQVEVOTG9N?=
 =?utf-8?B?Q1NVdTdMcHBKZzZjaHpGeDE1Q3hKSTJ4dkFWVmJ5bytURlFSN0NaUHFaalBn?=
 =?utf-8?B?Y20xS2xuYmtiM3Bkdk4vNFNxY3htck9CMklKMjlEMkIzWGJlQWc4c05nYVNU?=
 =?utf-8?B?Z25YUTBnOXpYdTVIaG1jcWNNYXZickk4UVd6U3pROSt1bHkzL2I3WXNFZEdG?=
 =?utf-8?B?UTU5MjhuSkp0WDI4OGFIaXEzSCtJK1ZTWERNcjA3OGcreDlmS0NQM2Q4c0hj?=
 =?utf-8?B?UUFpcHRENkRXUUFlQ2M4dGx2NTRQNG9DUFZQUy9rRWxPSkt4THk5ekRrYk0z?=
 =?utf-8?B?U0tSUkhWb291R0NURWp6TlEvTjYwdlRyVmExT0pONzE0YXNyMHJMRmNIbEN2?=
 =?utf-8?B?Z0lxVkFwVXQ2c3JwWHZhSW9uWFMwZ094UWJHeEREQzU0bmpOVG5tUGQwaitD?=
 =?utf-8?B?NVBjcG0xWHhsd2x1NXphTXNlYlhsdXlKbXdsbU1kTGpsZlIrVDh1NjJxeXZH?=
 =?utf-8?B?SFpLelUvenVBUktOVUNqY1BCaE8rSm9sbmN5WlFkRFdTWE04QWZsaERGa2pz?=
 =?utf-8?B?aWhjMjhOMXYrcncrOU53OUROTWVoWFFuMWRHMTVuOHdEQnJTZzhnTExqNVM4?=
 =?utf-8?B?WVA4Qm93L0N3M2RYZVhMSFRnTGNMVWdsMDRGRHRZdE91R1dBZ0Erckt0VzlM?=
 =?utf-8?B?eWtWV1I5NDBFdm5QMWxaMVk5a0RFeWczdks0cE5rUWI5dm53cnhnMS9PVTJQ?=
 =?utf-8?B?blNLNFFGdmlHZlEvc3VNeWhVcmFJeERWMmRKYXVLeExtZndISDJKaHNZdzNG?=
 =?utf-8?B?VEdDVGNSdzdBbi84YnUreDM1MlhFcFZnSWNkczlMT2w0NDRONGdqWkxLTlJO?=
 =?utf-8?B?S2hMUW4vU0pEODJMczEzQlVSbXFxN3RGWGdnT2NkS0hvZGQ5Q2Z5ZHZkTmVL?=
 =?utf-8?B?RzVubWdJSkZLUU1uTU5lWlBZSnVya2JPdGdhb1I4d2lrVUFFSEVuRGhnblBD?=
 =?utf-8?B?TFk4TEVQMXlESEZRQ2k5eTJQUlU5YlJ2NWFQeEhtRXdGZzlwQWYrTmhPZkZl?=
 =?utf-8?B?bkQ5anlKTldXSTNEVUl5OTJkL0dQMFJxdXV3TFJMUU9yTE1ReGFYWTg3QWRW?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58E2AE804ABA28449EBB57808E8B84F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebbf7bd-3a71-42e5-bdc2-08dbc937da2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 02:23:12.3394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8tHy1PhOWpXfZprt4CXJ7wy83pKo2UBw7JETnspw+/9R87KzvjDvyAoLWyMifER5MKMcpjUTFVYWJLqghDiMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
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

T24gTW9uLCAyMDIzLTEwLTA5IGF0IDIwOjQyIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEhpIFNlYW4NCj4gDQo+IE9uIE1vbiwgMDkgT2N0IDIwMjMgMTk6MjM6MDQgLTA1MDAsIFNlYW4g
Q2hyaXN0b3BoZXJzb24gIA0KPiA8c2VhbmpjQGdvb2dsZS5jb20+IHdyb3RlOg0KPiANCj4gPiBP
biBNb24sIE9jdCAwOSwgMjAyMywgS2FpIEh1YW5nIHdyb3RlOg0KPiA+ID4gT24gRnJpLCAyMDIz
LTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+ID4gPiA+ICsvKioN
Cj4gPiA+ID4gKyAqIHNneF9lcGNfb29tKCkgLSBpbnZva2UgRVBDIG91dC1vZi1tZW1vcnkgaGFu
ZGxpbmcgb24gdGFyZ2V0IExSVQ0KPiA+ID4gPiArICogQGxydToJTFJVIHRoYXQgaXMgbG93DQo+
ID4gPiA+ICsgKg0KPiA+ID4gPiArICogUmV0dXJuOgkldHJ1ZSBpZiBhIHZpY3RpbSB3YXMgZm91
bmQgYW5kIGtpY2tlZC4NCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArYm9vbCBzZ3hfZXBjX29vbShz
dHJ1Y3Qgc2d4X2VwY19scnVfbGlzdHMgKmxydSkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlzdHJ1
Y3Qgc2d4X2VwY19wYWdlICp2aWN0aW07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlzcGluX2xvY2so
JmxydS0+bG9jayk7DQo+ID4gPiA+ICsJdmljdGltID0gc2d4X29vbV9nZXRfdmljdGltKGxydSk7
DQo+ID4gPiA+ICsJc3Bpbl91bmxvY2soJmxydS0+bG9jayk7DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KwlpZiAoIXZpY3RpbSkNCj4gPiA+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ID4gPiArDQo+ID4g
PiA+ICsJaWYgKHZpY3RpbS0+ZmxhZ3MgJiBTR1hfRVBDX09XTkVSX1BBR0UpDQo+ID4gPiA+ICsJ
CXJldHVybiBzZ3hfb29tX2VuY2xfcGFnZSh2aWN0aW0tPmVuY2xfcGFnZSk7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKwlpZiAodmljdGltLT5mbGFncyAmIFNHWF9FUENfT1dORVJfRU5DTCkNCj4gPiA+
ID4gKwkJcmV0dXJuIHNneF9vb21fZW5jbCh2aWN0aW0tPmVuY2wpOw0KPiA+ID4gDQo+ID4gPiBJ
IGhhdGUgdG8gYnJpbmcgdGhpcyB1cCwgYXQgbGVhc3QgYXQgdGhpcyBzdGFnZSwgYnV0IEkgYW0g
d29uZGVyaW5nIHdoeSAgDQo+ID4gPiB3ZSBuZWVkDQo+ID4gPiB0byBwdXQgVkEgYW5kIFNFQ1Mg
cGFnZXMgdG8gdGhlIHVucmVjbGFpbWFibGUgbGlzdCwgYnV0IGNhbm5vdCBrZWVwIGFuDQo+ID4g
PiAiZW5jbGF2ZV9saXN0IiBpbnN0ZWFkPw0KPiA+IA0KPiA+IFRoZSBtb3RpdmF0aW9uIGZvciB0
cmFja2luZyBFUEMgcGFnZXMgaW5zdGVhZCBvZiBlbmNsYXZlcyB3YXMgc28gdGhhdCAgDQo+ID4g
dGhlIEVQQw0KPiA+IE9PTS1raWxsZXIgY291bGQgImtpbGwiIFZNcyBhcyB3ZWxsIGFzIGhvc3Qt
b3duZWQgZW5jbGF2ZXMuICBUaGUgdmlydHVhbCAgDQo+ID4gRVBDIGNvZGUNCj4gPiBkaWRuJ3Qg
YWN0dWFsbHkga2lsbCB0aGUgVk0gcHJvY2VzcywgaXQgaW5zdGVhZCBqdXN0IGZyZWVkIGFsbCBv
ZiB0aGUgIA0KPiA+IEVQQyBwYWdlcw0KPiA+IGFuZCBhYnVzZWQgdGhlIFNHWCBhcmNoaXRlY3R1
cmUgdG8gZWZmZWN0aXZlbHkgbWFrZSB0aGUgZ3Vlc3QgcmVjcmVhdGUgIA0KPiA+IGFsbCBpdHMN
Cj4gPiBlbmNsYXZlcyAoSUlSQywgUUVNVSBkb2VzIHRoZSBzYW1lIHRoaW5nIHRvICJzdXBwb3J0
IiBsaXZlIG1pZ3JhdGlvbikuDQo+ID4gDQo+ID4gTG9va3MgbGlrZSB5J2FsbCBwdW50ZWQgb24g
dGhhdCB3aXRoOg0KPiA+IA0KPiA+ICAgVGhlIEVQQyBwYWdlcyBhbGxvY2F0ZWQgZm9yIEtWTSBn
dWVzdHMgYnkgdGhlIHZpcnR1YWwgRVBDIGRyaXZlciBhcmUgIA0KPiA+IG5vdA0KPiA+ICAgcmVj
bGFpbWFibGUgYnkgdGhlIGhvc3Qga2VybmVsIFs1XS4gVGhlcmVmb3JlIHRoZXkgYXJlIG5vdCB0
cmFja2VkIGJ5ICANCj4gPiBhbnkNCj4gPiAgIExSVSBsaXN0cyBmb3IgcmVjbGFpbWluZyBwdXJw
b3NlcyBpbiB0aGlzIGltcGxlbWVudGF0aW9uLCBidXQgdGhleSBhcmUNCj4gPiAgIGNoYXJnZWQg
dG93YXJkIHRoZSBjZ3JvdXAgb2YgdGhlIHVzZXIgcHJvY2Vzc3MgKGUuZy4sIFFFTVUpIGxhdW5j
aGluZyAgDQo+ID4gdGhlDQo+ID4gICBndWVzdC4gIEFuZCB3aGVuIHRoZSBjZ3JvdXAgRVBDIHVz
YWdlIHJlYWNoZXMgaXRzIGxpbWl0LCB0aGUgdmlydHVhbCAgDQo+ID4gRVBDDQo+ID4gICBkcml2
ZXIgd2lsbCBzdG9wIGFsbG9jYXRpbmcgbW9yZSBFUEMgZm9yIHRoZSBWTSwgYW5kIHJldHVybiBT
SUdCVVMgdG8gIA0KPiA+IHRoZQ0KPiA+ICAgdXNlciBwcm9jZXNzIHdoaWNoIHdvdWxkIGFib3J0
IHRoZSBWTSBsYXVuY2guDQo+ID4gDQo+ID4gd2hpY2ggSU1PIGlzIGEgaGFjaywgdW5sZXNzIHJl
dHVybmluZyBTSUdCVVMgaXMgYWN0dWFsbHkgZW5mb3JjZWQgIA0KPiA+IHNvbWVob3cuICBSZWx5
aW5nDQo+ID4gb24gdXNlcnNwYWNlIHRvIGJlIGtpbmQgZW5vdWdoIHRvIGtpbGwgaXRzIFZNcyBr
aW5kYSBkZWZlYXRzIHRoZSBwdXJwb3NlICANCj4gPiBvZiBjZ3JvdXANCj4gPiBlbmZvcmNlbWVu
dC4gIEUuZy4gaWYgdGhlIGhhcmQgbGltaXQgZm9yIGEgRVBDIGNncm91cCBpcyBsb3dlcmVkLCAg
DQo+ID4gdXNlcnNwYWNlIHJ1bm5pbmcNCj4gPiBlbmNhbHZlcyBpbiBhIFZNIGNvdWxkIGNvbnRp
bnVlIG9uIGFuZCByZWZ1c2UgdG8gZ2l2ZSB1cCBpdHMgRVBDLCBhbmQgIA0KPiA+IHRodXMgcnVu
IGFib3ZlDQo+ID4gaXRzIGxpbWl0IGluIHBlcnBldHVpdHkuDQo+ID4gDQo+IENncm91cCB3b3Vs
ZCByZWZ1c2UgdG8gYWxsb2NhdGUgbW9yZSB3aGVuIGxpbWl0IGlzIHJlYWNoZWQgc28gVk1zIGNh
biBub3QgIA0KPiBydW4gYWJvdmUgbGltaXQuDQo+IA0KPiBJSVJDIFZNcyBvbmx5IHN1cHBvcnQg
c3RhdGljIEVQQyBzaXplIHJpZ2h0IG5vdywgcmVhY2hpbmcgbGltaXQgYXQgbGF1bmNoICANCj4g
bWVhbnMgdGhlIEVQQyBzaXplIGdpdmVuIGluIGNvbW1hbmQgbGluZSBmb3IgUUVNVSBpcyBub3Qg
YXBwcm9wcmlhdGUuIFNvICANCj4gVk0gc2hvdWxkIG5vdCBsYXVuY2gsIGhlbmNlIHRoZSBjdXJy
ZW50IGJlaGF2aW9yLg0KPiANCj4gW2FsbCBFUEMgcGFnZXMgaW4gZ3Vlc3QgYXJlIGFsbG9jYXRl
ZCBvbiBwYWdlIGZhdWx0IGNhdXNlZCBieSB0aGUgIA0KPiBzZW5zaXRpemF0aW9uIHByb2Nlc3Mg
aW4gZ3Vlc3Qga2VybmVsIGR1cmluZyBpbml0LCB3aGljaCBpcyBwYXJ0IG9mIHRoZSBWTSAgDQo+
IExhdW5jaCBwcm9jZXNzLiBTbyBTSUdOQlVTIHdpbGwgdHVybiBpbnRvIGZhaWxlZCBWTSBsYXVu
Y2guXQ0KPiANCj4gT25jZSBpdCBpcyBsYXVuY2hlZCwgZ3Vlc3Qga2VybmVsIHdvdWxkIGhhdmUg
J3RvdGFsIGNhcGFjaXR5JyBnaXZlbiBieSB0aGUgIA0KPiBzdGF0aWMgdmFsdWUgZnJvbSBRRU1V
IG9wdGlvbi4gQW5kIGl0IHdvdWxkIHN0YXJ0IHBhZ2luZyB3aGVuIGl0IGlzIHVzZWQgIA0KPiB1
cCwgbmV2ZXIgd291bGQgYXNrIGZvciBtb3JlIGZyb20gaG9zdC4NCj4gDQo+IEZvciBmdXR1cmUg
d2l0aCBkeW5hbWljIEVQQyBmb3IgcnVubmluZyBndWVzdHMsIFFFTVUgY291bGQgaGFuZGxlICAN
Cj4gYWxsb2NhdGlvbiBmYWlsdXJlIGFuZCBwYXNzIFNJR0JVUyB0byB0aGUgcnVubmluZyBndWVz
dCBrZXJuZWwuICBJcyB0aGF0ICANCj4gY29ycmVjdCB1bmRlcnN0YW5kaW5nPw0KPiANCj4gDQo+
ID4gSSBjYW4gc2VlIHVzZXJzcGFjZSB3YW50aW5nIHRvIGV4cGxpY2l0bHkgdGVybWluYXRlIHRo
ZSBWTSBpbnN0ZWFkIG9mICANCj4gPiAic2lsZW50bHkiDQo+ID4gdGhlIFZNJ3MgZW5jbGF2ZXMs
IGJ1dCB0aGF0IHNlZW1zIGxpa2UgaXQgc2hvdWxkIGJlIGEga25vYiBpbiB0aGUgIA0KPiA+IHZp
cnR1YWwgRVBDDQo+ID4gY29kZS4NCj4gDQo+IElmIG15IHVuZGVyc3RhbmRpbmcgYWJvdmUgaXMg
Y29ycmVjdCBhbmQgdW5kZXJzdGFuZGluZyB5b3VyIHN0YXRlbWVudCAgDQo+IGFib3ZlIGNvcnJl
Y3RseSwgdGhlbiBkb24ndCBzZWUgd2UgcmVhbGx5IG5lZWQgc2VwYXJhdGUga25vYiBmb3IgdkVQ
QyAgDQo+IGNvZGUuIFJlYWNoaW5nIGEgY2dyb3VwIGxpbWl0IGJ5IGEgcnVubmluZyBndWVzdCAo
YXNzdW1pbmcgZHluYW1pYyAgDQo+IGFsbG9jYXRpb24gaW1wbGVtZW50ZWQpIHNob3VsZCBub3Qg
dHJhbnNsYXRlIGF1dG9tYXRpY2FsbHkga2lsbGluZyB0aGUgVk0uICANCj4gSW5zdGVhZCwgaXQn
cyB1c2VyIHNwYWNlIGpvYiB0byB3b3JrIHdpdGggZ3Vlc3QgdG8gaGFuZGxlIGFsbG9jYXRpb24g
IA0KPiBmYWlsdXJlLiBHdWVzdCBjb3VsZCBwYWdlIGFuZCBraWxsIGVuY2xhdmVzLg0KPiANCg0K
SUlVQyBTZWFuIHdhcyB0YWxraW5nIGFib3V0IGNoYW5naW5nIG1pc2MubWF4IF9hZnRlcl8geW91
IGxhdW5jaCBTR1ggVk1zOg0KDQoxKSBtaXNjLm1heCA9IDEwME0NCjIpIExhdW5jaCBWTXMgd2l0
aCB0b3RhbCB2aXJ0dWFsIEVQQyBzaXplID0gMTAwTQk8LSBzdWNjZXNzDQozKSBtaXNjLm1heCA9
IDUwTQ0KDQozKSB3aWxsIGFsc28gc3VjY2VlZCwgYnV0IG5vdGhpbmcgd2lsbCBoYXBwZW4sIHRo
ZSBWTXMgd2lsbCBiZSBzdGlsbCBob2xkaW5nDQoxMDBNIEVQQy4NCg0KWW91IG5lZWQgdG8gc29t
ZWhvdyB0cmFjayB2aXJ0dWFsIEVQQyBhbmQga2lsbCBWTSBpbnN0ZWFkLg0KDQoob3Igc29tZWhv
dyBmYWlsIHRvIGRvIDMpIGlmIGl0IGlzIGFsc28gYW4gYWNjZXB0YWJsZSBvcHRpb24uKQ0KDQo=
