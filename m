Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6047B8E8C
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 23:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjJDVO1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 17:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjJDVO0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 17:14:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37847B8;
        Wed,  4 Oct 2023 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696454060; x=1727990060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YRVSFjaSiBXiYnuQ1YsSx+J46M+NHdvvoABqWJuE4es=;
  b=F+qj5cHlP5cqJinnGLPZqPDkGYC1ZSUk30z3e0pMu/X/1/GTRRAnAHDQ
   Gmm8Yn8W/3qMh70+eNFZnJpmISQmHKk6ypD4FtUV8QfteW3KkdRAvjQPl
   1BzcPf9mrWSZgfCJNS2zPaaOYh9xMHrZKV7HLjF7sRsg4ZtMyQm1aKFkV
   SEd75vX6CjzhEUBQdnSa15KGdz2r0WkGU8zVAXCUT5fSjXES2oNQhyBT9
   jAwtPudp9HgxDqftqp1KuAHutazdfKNVnprp41AfJ79gpNvadaxu2BW3K
   ZaAtq/aSRUHnaWkCx4j/A5Il2y3zZNk6+AZzEvp2kUhDKO6fcACndf60+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="386131409"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="386131409"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 14:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="821844651"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="821844651"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 14:13:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 14:13:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 14:13:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 14:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCnjVhxMgPkqlgebHMQ2hMv0nqiKCubdMJF+DIjSbGUAy+gvMmhVSnJw3BZjzIT2LEPu6fKZQM62Zf2Ro9ssI420OYY5j4pq4HLAZwJibky+E58w4e2rSelPJk41BffAlDL+wPiE+wLEfEqfAiQUyxZB8ychIO8sTREPE61xoIoyGkXMYci4/4DHEi0sCL9nk/AbvUZv7kS99605SnkO0zOuy4hkTnaDkZPO4geKnncmZL/dncNi+9e42W7K95DQD2AKLzfpX51eXb4eoDl+ecMIXdGmkV0uNh+W3ksnEELOiqQEYagxi8V/qbEGExMdcgAzbIArqt/uFltb1xT4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRVSFjaSiBXiYnuQ1YsSx+J46M+NHdvvoABqWJuE4es=;
 b=htrMky7whXayVx9ktMKom8nc+1Y+UgV5hO0zpoWAEY1cXATeJW6JckQ39CipXEp0ZqEqr9Mpkx6NxvolOKppBllnr3rvaqho95QcdsjiWD7JYfp8tzKpUpbpOMB5Oe6SomdsX6aaCnxzUBXZ07ClCEtriu4uRIBBurAyGpTCTb5+wapt/4YwuoigDpdO3wrbTvTT3YrLCOrgFA3TQ9NuhTUBgsy14pNj3J/2G6xj/W8MAGifMPOr8JyR2zTLj3ZphFOpmR17hqXp6MEt2jdSYVZ/76YmMw06hG4aw9JqeB5uT12uDzhIeIeZazgyPNlC/efgayugGQaKANAUgKmoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 4 Oct
 2023 21:13:42 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 21:13:42 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "tj@kernel.org" <tj@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>
Subject: Re: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Thread-Topic: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Thread-Index: AQHZ7cscCwFKzsfMlUe7K1500sBqu7AukfYAgAkcyICAAOAtgIABPXaAgABnUQA=
Date:   Wed, 4 Oct 2023 21:13:41 +0000
Message-ID: <34ec0ef5fda43e4b08e1e8352e5198e9e8a783ca.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-10-haitao.huang@linux.intel.com>
         <ac66cb2b6e057f5e5e78345bcddea13a3e72ee5e.camel@intel.com>
         <op.2b77pp0wwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <0953e4fac90921ff53570e2e6ebd2689fc1cd8fa.camel@intel.com>
         <op.2capgplewjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2capgplewjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5879:EE_
x-ms-office365-filtering-correlation-id: e8335616-60f3-4a5e-3255-08dbc51ec8e9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p3WqE/TWZsH9dCXDbYShB8AJgc625bvQOYO0jlybwrbqqo0W2d4sXc97Fmvb/tA0CCVOKztbuPQ58ivnU/9lt92ZwMCzz+giLU5Vsb6duo+m4lq+Y6WI18GMs+xeXL7dbD5M04l4Hy9A59EHJRv+xmiRdboqxFvR7oBOqsliV1Z4xtyzcT7/qAApyW/egklVuAzTc+Bf8Lm9nxRznHCoBIbimNH7LXPiimrmAzN+0FVGyAFxn+mHQj2Ij8VJjzmKjbpa4eV0aeErGNEcDIF+wEoHA6ZJBwYhSEUA9GiJuUVU2Dg4BMu+PKg9bqf47K+2aVcJ+gf3NGyUX70Jj4CxcwCSo7fLeZZeSFx9dj2+8IV9Puv76kZwQIXjmJ00knIfnpQN4F2bDklz+VlWd9eNaIuvn+yHXRyDvtu5DrzNTLP4SJ+jxfBMKKHdlbA9DgaWc5IIRUEVEUYYM3vAzeEqfY0KXo6lViWZvSl5h9L9/uVaSM+JXdWjI/CpTnWRIsKG7+VDSi8D0GVT1QzE9Dtndaf43tnJmd0JVmJOQxCXEGMRAgKl1V3soNV7kZfhD79Fzmi7Aexq1Md8ErHipCoUUA5ZrhMhjiJpDz+KBX6LsCc2EFBQFAUe8NVRNdWXKtrR6QZFbCoTd2FldOU4rNGA/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(921005)(86362001)(6486002)(478600001)(6506007)(71200400001)(110136005)(7416002)(2616005)(66556008)(316002)(66946007)(6636002)(2906002)(8676002)(26005)(64756008)(6512007)(4326008)(41300700001)(36756003)(66446008)(5660300002)(91956017)(8936002)(76116006)(66476007)(38100700002)(38070700005)(122000001)(82960400001)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE14U29LNWpaZFhVc1Q3U3FOSlVJSzZxS0FGZkFvZlRqUEhaa05DWFNyenFu?=
 =?utf-8?B?Y3VkcVFjRFF3WjQ3QnBSS3BLb0JCa3d5bWQ3ZmxkK0xWcS9RdithemkxajVs?=
 =?utf-8?B?cTc3eGRyWlNmRHphMmpkSHp5bHZ4dE5LbGlBb0ovRTB5VE1PMk9oMFVBUmx6?=
 =?utf-8?B?UTYybENEWS96M3QvaTFlcnJ6SFRJZlVoYmFEU25hUXdoRnJsdDVWTVhVenUw?=
 =?utf-8?B?Y2F5NFY3ekQrOC9zZkd3S0w5V3d4ZDdlSFVCdDUyZC9ZM2JXRnBJUDFod2hv?=
 =?utf-8?B?NlloaThsWUV6aUl6N1dDNko0aWxVNm1PQkREdmJhcjZFbDREOFJPQlI1ZXE0?=
 =?utf-8?B?Y01kaE5YRmFra2dhS1dnVnQrQkt2emlwVy9wY1VzV2w2YXRia0QwdXNCODlH?=
 =?utf-8?B?T0JLdDZPL2VVSjBRZ3lIdzdOd210QWRzOEZVbVh0M3AvSzJCeW5DYjIzMTE2?=
 =?utf-8?B?K1JXY2RUZGV5QzFFZkIyTHhFV28vTHNTa0FCYzNIU3hNQ2U1Wm43MWZVZm80?=
 =?utf-8?B?QlBDVGJNdk9WeVlSS1BSckxHaXZDOWVuQThsZVZsTUFVYVNJRkFadDBxcE1H?=
 =?utf-8?B?WHJHc3JhTFJZZVB0eHJDMHpQL1ZMaXloUzR2Ty9pQmlJTmxBYVh1OExXQ1Vy?=
 =?utf-8?B?aDg4ellCbW1nQmMzQTBSeFFRUnJYeFlVemkvTUp0NHF1cXlxOXpvR0tiQ0ZY?=
 =?utf-8?B?VGlKMk1ETmRPQVVQS205c0FBRG5XU1U2QjQxZ2ExUG5GLzcyTEY5OGh2MEZ4?=
 =?utf-8?B?b2QvYlVJMjhyZHhFOFBvNWp4MlZGV25oTkVpYWNOVUJ5L3VSclBVd1lpSWlk?=
 =?utf-8?B?U3NOV2dtV1A5Mkhrb3YvNWVxVzNzYnNEdjdNblhKcWhVNkFEYjFJVGl1bUNp?=
 =?utf-8?B?SU9mMjZsMXZJTDJscVBkTFY2ZUE4VHdrUjZBVlEvMndhU1VjN2xRK1lnUFNx?=
 =?utf-8?B?K1BNVjZ5YWdRSFVVMWVQZW96OU1PaHIwMGdoem96d0tGTXlDMXRsOUZQRVNR?=
 =?utf-8?B?a1dEclNYcDR4MnRRRWtwcVFmcE1BUVhPL1ZmZ2JEVVd5R2ZKY1FiTVVSdVJQ?=
 =?utf-8?B?VjhyOHJSbVVNeW9wM0EwVkVhT0ExSVZEaFN1eHpMdnhna3o5aThXaGdoOUZn?=
 =?utf-8?B?ekh6ek90NEoySTFqcXczbFc5QzFMYmZGdzR3Qy94aWduK2gwV3BOd3Q0WmxT?=
 =?utf-8?B?Tm9JOGNQYWh5YmFRZ3NzbTBCLzgxUUprcGlsZWZBOUFXRHNkeS9SYUhBQ2Jv?=
 =?utf-8?B?WnJhZ3d4aXZYVXppWjV6bmx1ZURiMEZJTXk2ck1kQWpmaEFwTldad3ZEYjB4?=
 =?utf-8?B?THA1VG92eVh3dkxnd1dqeVhVNmhhbkpPOFBudkQwSzQ4Q2JRaisxY09WMjgr?=
 =?utf-8?B?UUtpMHpXUzhMSnVVQ2xoNHJHaVE0UDFrV00yTUhXQTYveE1BVFVIOHdYYXhF?=
 =?utf-8?B?cTM3WjRvYW1kYVdSK3VabjZDOHA3Rkw2TnpMV1hPdTdleVdDRjhRL3I3MWo2?=
 =?utf-8?B?YzdFWWlHRlVLbUh0Nk94WERYTUxjOTl5VXNvajJ3a3hhcDh4OHFEbHlVaXRv?=
 =?utf-8?B?TFhWRjZ2c1AvNTNtUFBlSUIwNVEwekd4cVhGaWs1N04wT0g3TlZWQmI0MGRS?=
 =?utf-8?B?ZjNZM0NSTkNtSDVtN2I5cnZRNEpOYlA4bTlicHRoNUdOZXZIdmVnMWxkRnhS?=
 =?utf-8?B?bUJLb1creUFyV0VsT0E4cXU2NStwNDVDV0x0VmQ5dGVBTWN0akV1U3BHWmZy?=
 =?utf-8?B?SmZyM0x5aHZTMHM0L2d3YS9jOU9USEtmVDVuTmdzamFjWlV2a000UnBwek9V?=
 =?utf-8?B?VFRzektFYUNrRThEaHp4dmdnVHZEcFJjVWJRZmxkZjE2VFNOQktQZiszNmVN?=
 =?utf-8?B?Y2Z2VCs1VUVkamFWTXNRcXRqWXpqSVlteVEreWlTNVRKdXZiRW04WVpGN1hZ?=
 =?utf-8?B?dzZXVlY1d0Z0YTJQT2srOXZwS0U3OEt0QlEvaHBrQ1BPZEpGalBQZTVISWdH?=
 =?utf-8?B?bktYcVoyMTd2WnJyMXJRZTFhalVRYkhSWHN0VTBHWkMvQitiK2lnTFpGME9D?=
 =?utf-8?B?U2MwYlVZL2dDMlRjVi9sNTBFalBGZDVFY1llQldoRkR5YXZBeTBrNjRxSE85?=
 =?utf-8?B?cUMweTBKVnZ6RGgvcmEyZ2x3NHIxTVNBOERoT2ZqZHlzV29WNDgvbDkrUWh0?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74FB834CFFA5744AB59BB7AB51D2DCB6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8335616-60f3-4a5e-3255-08dbc51ec8e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 21:13:41.2922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbzrXtNQiPbQFb/Sh0UyN69MKPdleUspdoRsaQEDWb3jdupZJR6NmLcHDTiya+mWjQK2n8z+uN7Ae3Xz4f7BFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
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

T24gV2VkLCAyMDIzLTEwLTA0IGF0IDEwOjAzIC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFR1ZSwgMDMgT2N0IDIwMjMgMTU6MDc6NDIgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBUdWUsIDIwMjMtMTAtMDMgYXQgMDE6NDUg
LTA1MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEJ0dywgcHJvYmFi
bHkgYSBkdW1iIHF1ZXN0aW9uOg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlb3JldGljYWxseSBpZiB5
b3Ugb25seSBuZWVkIHRvIGZpbmQgYSB2aWN0aW0gZW5jbGF2ZSB5b3UgZG9uJ3QgbmVlZCANCj4g
PiA+ID4gdG8gcHV0IFZBDQo+ID4gPiA+IHBhZ2VzIHRvIHRoZSB1bnJlY2xhaW1hYmxlIGxpc3Qs
IGJlY2F1c2UgdGhvc2UgVkEgcGFnZXMgd2lsbCBiZSBmcmVlZCANCj4gPiA+ID4gYW55d2F5DQo+
ID4gPiA+IHdoZW4gZW5jbGF2ZSBpcyBraWxsZWQuICBTbyBrZWVwaW5nIFZBIHBhZ2VzIGluIHRo
ZSBsaXN0IGlzIGZvcj4gIA0KPiA+ID4gYWNjb3VudGluZyBhbGwNCj4gPiA+ID4gdGhlIHBhZ2Vz
IHRoYXQgdGhlIGNncm91cCBpcyBoYXZpbmc/DQo+ID4gPiANCj4gPiA+IFllcyBiYXNpY2FsbHkg
dHJhY2tpbmcgdGhlbSBpbiBjZ3JvdXBzIGFzIHRoZXkgYXJlIGFsbG9jYXRlZC4NCj4gPiA+IA0K
PiA+ID4gVkFzIGFuZCBTRUNTIG1heSBhbHNvIGNvbWUgYW5kIGdvIGFzIHN3YXBwaW5nL3Vuc3dh
cHBpbmcgaGFwcGVucy4gQnV0ICANCj4gPiA+IGlmIGFjZ3JvdXAgaXMgT09NLCBhbmQgYWxsIHJl
Y2xhaW1hYmxlcyBhcmUgZ29uZSAoc3dhcHBlZCBvdXQpLCBpdCdkICANCj4gPiA+IGhhdmUgdG9y
ZWNsYWltIFZBcy9TRUNzIGluIHRoZSBzYW1lIGNncm91cCBzdGFydGluZyBmcm9tIHRoZSBmcm9u
dCBvZiAgDQo+ID4gPiB0aGUgTFJVbGlzdC4gVG8gcmVjbGFpbSBhIFZBL1NFQ1MsIGl0IGlkZW50
aWZpZXMgdGhlIGVuY2xhdmUgZnJvbSB0aGUgIA0KPiA+ID4gb3duZXIgb2Z0aGUgVkEvU0VDUyBw
YWdlIGFuZCBraWxscyBpdCwgYXMga2lsbGluZyBlbmNsYXZlIGlzIHRoZSBvbmx5ICANCj4gPiA+
IHdheSB0b3JlY2xhaW0gVkEvU0VDUyBwYWdlcy4NCj4gPiANCj4gPiBUbyBraWxsIGVuY2xhdmUg
eW91IGp1c3QgbmVlZCB0byB0cmFjayBTRUNTIGluICB0aGUgdW5yZWNsYWltYWJsZSBsaXN0LiAg
DQo+ID4gT25seSB3aGVuIHlvdSB3YW50IHRvIGFjY291bnQgdGhlIHRvdGFsIEVQQyBwYWdlcyB2
aWEgc29tZSBsaXN0IHlvdSAgDQo+ID4gX3Byb2JhYmx5Xw0KPiA+IG5lZWQgdG8gdHJhY2sgVkEg
YXMgd2VsbC4gIEJ1dCBJIGFtIG5vdCBxdWl0ZSBzdXJlIGFib3V0IHRoaXMgZWl0aGVyLg0KPiAN
Cj4gVGhlcmUgaXMgYSBjYXNlIHdoZXJlIGV2ZW4gU0VDUyBpcyBwYWdlZCBvdXQgZm9yIGFuIGVu
Y2xhdmUgd2l0aCBhbGwgIA0KPiByZWNsYWltYWJsZXMgb3V0LsKgDQo+IA0KDQpZZXMuICBCdXQg
dGhpcyBlc3NlbnRpYWxseSBtZWFucyB0aGVzZSBlbmNsYXZlcyBhcmUgbm90IGFjdGl2ZSwgdGh1
cyBzaG91bGRuJ3QNCmJlIHRoZSB2aWN0aW0gb2YgT09NPw0KDQo+IFNvIGNncm91cCBuZWVkcyB0
byB0cmFjayBlYWNoIHBhZ2UgdXNlZCBieSBhbiBlbmNsYXZlICANCj4gYW5kIGtpbGwgZW5jbGF2
ZSB3aGVuIGNncm91cCBuZWVkcyB0byBsb3dlciB1c2FnZSBieSBldmljdGluZyBhbiBWQSBvciAg
DQo+IFNFQ1MgcGFnZS4NCg0KTGV0J3MgZGlzY3VzcyBtb3JlIG9uIHRyYWNraW5nIFNFQ1Mgb24g
dW5yZWNsYWltYWJsZSBsaXN0IG9ubHkuDQoNCkNvdWxkIHdlIGFzc3VtZSB0aGF0IHdoZW4gdGhl
IE9PTSB3YW50cyB0byBwaWNrIHVwIGEgdmljdGltIHRvIHNlcnZlIHRoZSBuZXcNCmVuY2xhdmUs
IHRoZXJlIG11c3QgYmUgYXQgbGVhc3QgYW5vdGhlciBvbmUgKmFjdGl2ZSogZW5jbGF2ZSB3aGlj
aCBzdGlsbCBoYXMgdGhlDQpTRUNTIHBhZ2UgaW4gRVBDPw0KDQpJZiB5ZXMsIHRoYXQgZW5jbGF2
ZSB3aWxsIGJlIHNlbGVjdGVkIGFzIHZpY3RpbS4NCg0KSWYgbm90LCB0aGVuIG5vIG90aGVyIGVu
Y2xhdmUgd2lsbCBiZSBzZWxlY3RlZCBhcyB2aWN0aW0uICBJbnN0ZWFkLCBvbmx5IHRoZSBuZXcN
CmVuY2xhdmUgd2hpY2ggaXMgcmVxdWVzdGluZyBtb3JlIEVQQyB3aWxsIGJlIHNlbGVjdGVkLCBi
ZWNhdXNlIGl0J3MgU0VDUyBpcyBvbg0KdGhlIHVucmVjbGFpbWFibGUgbGlzdC4NCg0KU29tZWhv
dyB0aGlzIGlzIHVuYWNjZXB0YWJsZSwgdGh1cyB3ZSBuZWVkIHRvIHRyYWNrIFZBIHBhZ2VzIHRv
byBpbiBvcmRlciB0bw0Ka2lsbCBvdGhlciBpbmFjdGl2ZSBlbmNsYXZlPw0KDQo+IFRoZXJlIHdl
cmUgc29tZSBkaXNjdXNzaW9uIG9uIHBhZ2luZyBvdXQgVkFzIHdpdGhvdXQga2lsbGluZyBlbmNs
YXZlcyBidXQgIA0KPiBpdCdkIGJlIGNvbXBsaWNhdGVkIGFuZCBub3QgaW1wbGVtZW50ZWQgeWV0
Lg0KDQpObyB3ZSBkb24ndCBpbnZvbHZlIHN3YXBwaW5nIFZBIHBhZ2VzIG5vdy4gIEl0J3MgYSBz
ZXBhcmF0ZSB0b3BpYy4NCg0KPiANCj4gQlRXLCBJIG5lZWQgY2xhcmlmeSB0cmFja2luZyBwYWdl
cyB3aGljaCBpcyBkb25lIGJ5IExSVXMgdnMgdXNhZ2UgIA0KPiBhY2NvdW50aW5nIHdoaWNoIGlz
IGRvbmUgYnkgY2hhcmdlL3VuY2hhcmdlIHRvIG1pc2MuIFRvIG1lIHRyYWNraW5nIGlzIGZvciAg
DQo+IHJlY2xhaW1pbmcgbm90IGFjY291bnRpbmcuIEFsc28gdkVQQ3Mgbm90IHRyYWNrZWQgYXQg
YWxsIGJ1dCB0aGV5IGFyZSAgDQo+IGFjY291bnRlZCBmb3IuDQoNCkknbGwgcmV2aWV3IHRoZSBy
ZXN0IHBhdGNoZXMuICBUaGFua3MuDQo=
