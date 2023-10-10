Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AFA7BEFE7
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 02:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379250AbjJJAu4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 20:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379232AbjJJAuz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 20:50:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A9299;
        Mon,  9 Oct 2023 17:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696899054; x=1728435054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZKCFbsszABK7AWYx+ndqsYjTwiBBCiYXx5lPonvtTww=;
  b=aPQEitNXJ+wgyr+5aNKqZ0eAsmA1YU+N8OQgFfWppLdZil60nEckOAop
   5oP+FPpAMzef7OmvHQvlRYW0vhZXNei+vJQuvemAoK8GO8xTYPdoJmss2
   vvJ16wzWKMhnAKiF1eCMv+5sIg/2dCVV4Be3ZKXmiIP8xtagMSb1hX5iV
   fZktACbVtuoTbS6ItPY4QCSeYxSghcHb6hbis0zylMwl1Vp3YN3T14Qi1
   P5MRAg6zWlPV78FpBOTbd8xa+vowkVjisqbIvQVVFF0b4WLEsLoXd0Co8
   YFGaWC6VDemTyF3bQ7wRtrjROg1PFdV/yENLhGnkpZ6VEu86LdeQvt84Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369351290"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="369351290"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 17:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="788376673"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="788376673"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 17:50:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 17:50:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 17:50:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 17:50:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 17:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St9gpCwsXYbPlp/UYIenAC9J7XhN2ihneae+Ivm3kmchAjtmdQhMiSNfwrTj4/tfQQEJ6jG5IQN0HLtNdp05FNjxBma7+th+CIxCwK6GCNMKpKlw2alsR+tmhDv4/L1LDAQlkaiEJCLCaKqsYDWWFdSmo0YxE6s0Wb8M5OsMrE9LHxdOtVjObHi0ZOoPaSAPB8HE65g29UF4cvFmCa1vncCIDj+fDLVyJ6mnptw83/ANGbAb/Yow7heAKnM6wqWWKCZyRV6MwDejJtQJWwD2xa4kyJXh2YhSNYw4er0b7ELi7cA3P/zDWHvsRz78lnnjK7kGmi5OhAUEKMgV7zTgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKCFbsszABK7AWYx+ndqsYjTwiBBCiYXx5lPonvtTww=;
 b=dGorsHDAuoHAft+mN5rgdbcTxwY3thRz1ug6VGW+ufCqG3Tk3u1u+srHpLVhcru3BI2Voa0zOfRwhAFaDQfQCn5PK9+rDJrrJMjfUV4U7EiejyC/STNPIlX4JshzOC9aHW6Yf7fRTOf/XLa6zs+QC8peGvLYwYWCa4C6TiOsRDktAmkkCoM0YJ7cdIbMuHRR3chsMkULoo4kvwFONstQT55apgUIDM8speAAGz7eRy77MEEU2YRKEv15tcmgHX/kTshnYjzhywZUB1Jr7yMcKWlUUpQ5JYLL5vpDitdsZHFR7WNA0hxAYUJj/UR1t/eftD46mXHdfIAZoFm0feAqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 00:50:34 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 00:50:33 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>
CC:     "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Topic: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAKoQCAAAepgA==
Date:   Tue, 10 Oct 2023 00:50:33 +0000
Message-ID: <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <ZSSZaFrxvCvR1SOy@google.com>
In-Reply-To: <ZSSZaFrxvCvR1SOy@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|LV3PR11MB8507:EE_
x-ms-office365-filtering-correlation-id: df503bd8-6cfe-416a-d542-08dbc92ae917
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5nsPF1ZHcaGhoEG780EArw5MsPJmX7vCcb1wnjsD80Nsll0MYeh2cNclS+b6YqCrFB1qxX1o8KaqIuBd2GpWXfKEqtiag7FluofnkD5kurw5gQeU3tACHRLFZGwd2VCXQn466QpOqjnwBBlBJeLVOfAyA8WzGNtWScUpK1sPq8JYpJEgLhGy6vGeu9PQL00MKVF1niwAKkxiH62dWGMIWv0Q224qVvBSz2Ftamhnu6u6c+7uHcc/kVjb3vJS15gTDVpPo28+HOs72jTpgLkD+tPjxxhcL6lMtV0wqHNGnFoRtSqVmLIupEbYlC0rz0FRlV+yqt21xNRr/8wJDY6yfSSaVOPy78qDPYtzrkmafnKBj7IJa2WM/GpL1VpY1k+NS7+VFy10RNMqhFD2z6zZtCGPaLYMcRq4Pl+SgQT1fe6zhoAk0D4sfzdvyK2KDHRvtuqbiljD614C0J4OGc9S5+TE/oawMUCiU736XlvX5thqVSRua80vKUWKenbzD7ZDpdubZ27eJSj05iTjgfphLpHieP21uSUAA8A2n1rmidG260CRnbYEnydNi9yNBPzoGnvy+g0jMnRjpv4TYOqkHBgBSNEGhv5Bgr8IoiDcuSTYGCv7Czw9pkHWzmyXcVvp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(83380400001)(122000001)(82960400001)(38100700002)(8936002)(4326008)(8676002)(54906003)(6916009)(66446008)(66556008)(66946007)(66476007)(316002)(76116006)(91956017)(2616005)(7416002)(5660300002)(478600001)(41300700001)(2906002)(6506007)(71200400001)(6486002)(6512007)(64756008)(38070700005)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzR2bkNDWTBkK1k5OUV3eS9VSkFZYy9iNFdteWJYWGw2UlZzNUJUQ0hDcTRJ?=
 =?utf-8?B?ZVRFTVdmamYvU0RNMUJucHBMbEtZNlVodVlQNlRlMVZkanowOFAyM3hrdEtW?=
 =?utf-8?B?ODZXdkRsb3VUS2U0VXhLdXpkeStKQ2hnOGN0K3JwamJaT3NjNEZDWDdrcyt3?=
 =?utf-8?B?RFFaVW5jdFdVaUh1WmFmTmV2YUFNUkVOTUFFT0dmK0FYb0xQYXRLUXk4TTA4?=
 =?utf-8?B?M29EMVZlZlhNa0UxcXN5anJiYk5iQ3U0ZzlHc1k1eFBXWlQ3R0JTczVFOUJT?=
 =?utf-8?B?R0xMQ3RTMjFla0RGakZWcEsxMmpzemN1VWtwNXJWOWdSRlNRdmV3SFB2aEwx?=
 =?utf-8?B?bFV6RWpIa05VdVR4K2kxc0d0YU1scGJjSTlLaW1kbmJZaWJKUVB2RlVuYk81?=
 =?utf-8?B?dzIybXg1R0FGRjNSdWFiRnprVDJZWHVETWtzZmN6TnF1Wmo5Y0FjdkZvRGNP?=
 =?utf-8?B?SWVYNFF0aC9qbFlmemMydSs2bHpNVkR5WTNQa21XbDdQa3A2cmlzSEppUDdD?=
 =?utf-8?B?eVd1VDd2eXNBd0tZT3NvQnE5dHlVNDkzY05VUjFaMnpBcFZ4anJwaTg4ZjZG?=
 =?utf-8?B?cXNXcDQyWXEzM1ppV0V2SERNd1lqYkUva0NKMVNKeFhoL01ubUR4RGJZQ1Ir?=
 =?utf-8?B?Q3ZJblpaL0hUZk1aeENiZE5lYisvU05YcWpjU1M5VTQ0WFlITEhLZWU5T0VM?=
 =?utf-8?B?L3VlKzQ5Q0JxWnBET1dsVGZsMHFuUUhzSy9PN2pOVVhnSE1JSUFDYXpBcFds?=
 =?utf-8?B?Z3YvVGJIZ0hXSFhNdE9RN0pCWXc0cndXejhjaFpyTUJ3cWpTMnhhWXg5bS9J?=
 =?utf-8?B?UlhucllydTU3T3d3aUxhS0ZHMDJCK3krZFBEMEpXbnBuUWkzcTM0VlhzZENL?=
 =?utf-8?B?ZVNaQ1Rsa3lVRDRkbngyWjRKZkNLSU9iblFlbEZxN00vVkFVZnd2WXBzZElW?=
 =?utf-8?B?WEIrNDBpVzYwNDdLbWxmUXZmQmxQNzBFRmRUL1FKM05sSVMvalFkNGdSeC9i?=
 =?utf-8?B?ZzZmOFkyOU5kZjZheWlHeGx2Snc1UjdWK2lrcnZqSEI3SjhUNlpSTnVWY21D?=
 =?utf-8?B?aDlGR0JZdGpaY2w5MGErc3MyeWJ5clVvaThHaTJxY3Nkd1c1WnZ2NlNpaGxx?=
 =?utf-8?B?VXNuRTJ6cFhVR25reUo1aWFHa3NUcEt5ajY1TzhGdm9XZFBFSVpaS0M2Lysx?=
 =?utf-8?B?M0RFMExEL0V1QlpuMDhUVGRJZVFtdmt5SGt3SmZIVVZVcDRKS2szTnlFeXZE?=
 =?utf-8?B?bDhreEFMUmhieFhsWWk5TUN3NEZYSXR4enorbTAyeXVOZzUrU1pWcjVjTzQ0?=
 =?utf-8?B?UStSRXVQMjZUa2VZQ3FoenRVS1FhYWJyTU83Q0h5RHBDbWdUbXdBam9KTWdB?=
 =?utf-8?B?UC9oaWRsNjdaT3RqN3lQSFNUaTE5cjcvQWRCRzhqNFRaWXlPdVh4TWlwQnMz?=
 =?utf-8?B?YklzakRMeWUvdWp1NG5XeTRkWXVZSUs5WTNld05WMVk1QkhkM3F0eXVqVzlY?=
 =?utf-8?B?RlVMY09zbjIyZ0VNRXVFZEpFMUp6ajR2MjExWHRXK2p3bW45MHJPalZUTHpN?=
 =?utf-8?B?UTRFZFBuWGMzNThpWUpsaWRzTEpuQUVVR1Z5Q2g0RTZicU1jdmI3eXh5K0dS?=
 =?utf-8?B?d29xNWErU0NLUXdxZGdPSFc5bit6eG1pd1pOcmdHcXlJVm04UmlrME5lTnQ4?=
 =?utf-8?B?b3hSZEN2UWcxTzA5cUhRbEpJWk5ZbTYvNDRKRWVoUlRBaWxFY1JJUzU1YlY2?=
 =?utf-8?B?dno5Vnk4U0pvcDVJdmRBZnFOcUUxbTF0OFo2SzBIVzVzdVkvS3RVR3doaTFI?=
 =?utf-8?B?b2kyNTN5ZHZ0UFRUdmVlVzNYRWlaR2FnMEtVODcwaGQ4ekwzTmVyOVB0V1ps?=
 =?utf-8?B?YThHWGFKaXVKSWN3eW9WMDlNQ1A3VWQyYWIxKzI5UFZlNEFVa08rbzlVTFEz?=
 =?utf-8?B?bmZCNTl4YXp0QTVKZmlydXlNWEpRNWhCWDBBV3RUWXFUZWtvdnRpcjAzZjRm?=
 =?utf-8?B?K3JXUmZucWo0R3VWWTU3K3JKd3YzWFlUMjRzcmZiZ2MzSzZSK1lPU0FYQWhj?=
 =?utf-8?B?MTBwc3MvYXJoMHgxRWdBdXBNUitScnFJSmtoTDVQV3dTSWd3T2ROdThnUkd1?=
 =?utf-8?B?clZuNmFiQzM3dlNvWk96eXRJaUE1cFNLcC9FeURGZ09DMm92NzRxTnpvWTZm?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F7CBC77CB36F94E9B3C4B4034FE1692@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df503bd8-6cfe-416a-d542-08dbc92ae917
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 00:50:33.9331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WqUgeA8zvgMC/lXfOVm8pmGUVR3GVKnEw777quh0Q0LdvhzNM5y+HnFEFTVXvRV5l5vVqGxeZiwJM3JOEUffQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTA5IGF0IDE3OjIzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIE9jdCAwOSwgMjAyMywgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIEZy
aSwgMjAyMy0wOS0yMiBhdCAyMDowNiAtMDcwMCwgSGFpdGFvIEh1YW5nIHdyb3RlOg0KPiA+ID4g
Ky8qKg0KPiA+ID4gKyAqIHNneF9lcGNfb29tKCkgLSBpbnZva2UgRVBDIG91dC1vZi1tZW1vcnkg
aGFuZGxpbmcgb24gdGFyZ2V0IExSVQ0KPiA+ID4gKyAqIEBscnU6CUxSVSB0aGF0IGlzIGxvdw0K
PiA+ID4gKyAqDQo+ID4gPiArICogUmV0dXJuOgkldHJ1ZSBpZiBhIHZpY3RpbSB3YXMgZm91bmQg
YW5kIGtpY2tlZC4NCj4gPiA+ICsgKi8NCj4gPiA+ICtib29sIHNneF9lcGNfb29tKHN0cnVjdCBz
Z3hfZXBjX2xydV9saXN0cyAqbHJ1KQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IHNneF9lcGNf
cGFnZSAqdmljdGltOw0KPiA+ID4gKw0KPiA+ID4gKwlzcGluX2xvY2soJmxydS0+bG9jayk7DQo+
ID4gPiArCXZpY3RpbSA9IHNneF9vb21fZ2V0X3ZpY3RpbShscnUpOw0KPiA+ID4gKwlzcGluX3Vu
bG9jaygmbHJ1LT5sb2NrKTsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKCF2aWN0aW0pDQo+ID4gPiAr
CQlyZXR1cm4gZmFsc2U7DQo+ID4gPiArDQo+ID4gPiArCWlmICh2aWN0aW0tPmZsYWdzICYgU0dY
X0VQQ19PV05FUl9QQUdFKQ0KPiA+ID4gKwkJcmV0dXJuIHNneF9vb21fZW5jbF9wYWdlKHZpY3Rp
bS0+ZW5jbF9wYWdlKTsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKHZpY3RpbS0+ZmxhZ3MgJiBTR1hf
RVBDX09XTkVSX0VOQ0wpDQo+ID4gPiArCQlyZXR1cm4gc2d4X29vbV9lbmNsKHZpY3RpbS0+ZW5j
bCk7DQo+ID4gDQo+ID4gSSBoYXRlIHRvIGJyaW5nIHRoaXMgdXAsIGF0IGxlYXN0IGF0IHRoaXMg
c3RhZ2UsIGJ1dCBJIGFtIHdvbmRlcmluZyB3aHkgd2UgbmVlZA0KPiA+IHRvIHB1dCBWQSBhbmQg
U0VDUyBwYWdlcyB0byB0aGUgdW5yZWNsYWltYWJsZSBsaXN0LCBidXQgY2Fubm90IGtlZXAgYW4N
Cj4gPiAiZW5jbGF2ZV9saXN0IiBpbnN0ZWFkPw0KPiANCj4gVGhlIG1vdGl2YXRpb24gZm9yIHRy
YWNraW5nIEVQQyBwYWdlcyBpbnN0ZWFkIG9mIGVuY2xhdmVzIHdhcyBzbyB0aGF0IHRoZSBFUEMN
Cj4gT09NLWtpbGxlciBjb3VsZCAia2lsbCIgVk1zIGFzIHdlbGwgYXMgaG9zdC1vd25lZCBlbmNs
YXZlcy4gwqANCj4gDQoNCkFoIHRoaXMgc2VlbXMgYSBmYWlyIGFyZ3VtZW50LiA6LSkNCg0KPiBU
aGUgdmlydHVhbCBFUEMgY29kZQ0KPiBkaWRuJ3QgYWN0dWFsbHkga2lsbCB0aGUgVk0gcHJvY2Vz
cywgaXQgaW5zdGVhZCBqdXN0IGZyZWVkIGFsbCBvZiB0aGUgRVBDIHBhZ2VzDQo+IGFuZCBhYnVz
ZWQgdGhlIFNHWCBhcmNoaXRlY3R1cmUgdG8gZWZmZWN0aXZlbHkgbWFrZSB0aGUgZ3Vlc3QgcmVj
cmVhdGUgYWxsIGl0cw0KPiBlbmNsYXZlcyAoSUlSQywgUUVNVSBkb2VzIHRoZSBzYW1lIHRoaW5n
IHRvICJzdXBwb3J0IiBsaXZlIG1pZ3JhdGlvbikuDQoNCkl0IHJldHVybnMgU0lHQlVTLiAgU0dY
IFZNIGxpdmUgbWlncmF0aW9uIGFsc28gcmVxdWlyZXMgZW5vdWdoIEVQQyBiZWluZyBhYmxlIHRv
DQpiZSBhbGxvY2F0ZWQgb24gdGhlIGRlc3RpbmF0aW9uIG1hY2hpbmUgdG8gd29yayBBRkFJQ1Qu
DQogDQo+IA0KPiBMb29rcyBsaWtlIHknYWxsIHB1bnRlZCBvbiB0aGF0IHdpdGg6DQo+IA0KPiAg
IFRoZSBFUEMgcGFnZXMgYWxsb2NhdGVkIGZvciBLVk0gZ3Vlc3RzIGJ5IHRoZSB2aXJ0dWFsIEVQ
QyBkcml2ZXIgYXJlIG5vdA0KPiAgIHJlY2xhaW1hYmxlIGJ5IHRoZSBob3N0IGtlcm5lbCBbNV0u
IFRoZXJlZm9yZSB0aGV5IGFyZSBub3QgdHJhY2tlZCBieSBhbnkNCj4gICBMUlUgbGlzdHMgZm9y
IHJlY2xhaW1pbmcgcHVycG9zZXMgaW4gdGhpcyBpbXBsZW1lbnRhdGlvbiwgYnV0IHRoZXkgYXJl
DQo+ICAgY2hhcmdlZCB0b3dhcmQgdGhlIGNncm91cCBvZiB0aGUgdXNlciBwcm9jZXNzcyAoZS5n
LiwgUUVNVSkgbGF1bmNoaW5nIHRoZQ0KPiAgIGd1ZXN0LiAgQW5kIHdoZW4gdGhlIGNncm91cCBF
UEMgdXNhZ2UgcmVhY2hlcyBpdHMgbGltaXQsIHRoZSB2aXJ0dWFsIEVQQw0KPiAgIGRyaXZlciB3
aWxsIHN0b3AgYWxsb2NhdGluZyBtb3JlIEVQQyBmb3IgdGhlIFZNLCBhbmQgcmV0dXJuIFNJR0JV
UyB0byB0aGUNCj4gICB1c2VyIHByb2Nlc3Mgd2hpY2ggd291bGQgYWJvcnQgdGhlIFZNIGxhdW5j
aC4NCj4gDQo+IHdoaWNoIElNTyBpcyBhIGhhY2ssIHVubGVzcyByZXR1cm5pbmcgU0lHQlVTIGlz
IGFjdHVhbGx5IGVuZm9yY2VkIHNvbWVob3cuIMKgDQo+IA0KDQoiZW5mb3JjZWQiIGRvIHlvdSBt
ZWFuPw0KDQpDdXJyZW50bHkgdGhlIHNneF92ZXBjX2ZhdWx0KCkgcmV0dXJucyBWTV9GQVVMVF9T
SUdCVVMgd2hlbiBpdCBjYW5ub3QgYWxsb2NhdGUNCkVQQyBwYWdlLiAgQW5kIHdoZW4gdGhpcyBo
YXBwZW5zLCBLVk0gcmV0dXJucyBLVk1fUEZOX0VSUl9GQVVMVCBpbiBodmFfdG9fcGZuKCksDQp3
aGljaCBldmVudHVhbGx5IHJlc3VsdHMgaW4gS1ZNIHJldHVybmluZyAtRUZBVUxUIHRvIHVzZXJz
cGFjZSBpbiB2Y3B1X3J1bigpLiANCkFuZCBRZW11IHRoZW4ga2lsbHMgdGhlIFZNIHdpdGggc29t
ZSBub25zZW5zZSBtZXNzYWdlOg0KDQogICAgICAgIGVycm9yOiBrdm0gcnVuIGZhaWxlZCBCYWQg
YWRkcmVzcw0KICAgICAgICA8ZHVtcCBndWVzdCByZWdpc3RlcnMgbm9uc2Vuc2U+DQoNCj4gUmVs
eWluZw0KPiBvbiB1c2Vyc3BhY2UgdG8gYmUga2luZCBlbm91Z2ggdG8ga2lsbCBpdHMgVk1zIGtp
bmRhIGRlZmVhdHMgdGhlIHB1cnBvc2Ugb2YgY2dyb3VwDQo+IGVuZm9yY2VtZW50LiAgRS5nLiBp
ZiB0aGUgaGFyZCBsaW1pdCBmb3IgYSBFUEMgY2dyb3VwIGlzIGxvd2VyZWQsIHVzZXJzcGFjZSBy
dW5uaW5nDQo+IGVuY2FsdmVzIGluIGEgVk0gY291bGQgY29udGludWUgb24gYW5kIHJlZnVzZSB0
byBnaXZlIHVwIGl0cyBFUEMsIGFuZCB0aHVzIHJ1biBhYm92ZQ0KPiBpdHMgbGltaXQgaW4gcGVy
cGV0dWl0eS4NCg0KQWdyZWVkLiAgQnV0IHRoaXMgbG9va3MgY2Fubm90IHJlc29sdmVkIHVudGls
IHdlIGNhbiByZWNsYWltIEVQQyBwYWdlIGZyb20gVk0uDQoNCk9yIGluIHRoZSBFUEMgY2dyb3Vw
IGNvZGUgd2UgY2FuIHJlZnVzZSB0byBzZXQgdGhlIG1heGltdW0gd2hpY2ggY2Fubm90IGJlDQpz
dXBwb3J0ZWQsIGUuZy4sIGxlc3MgdGhlIHRvdGFsIHZpcnR1YWwgRVBDIHNpemUuDQoNCkkgZ3Vl
c3MgdGhlIHNlY29uZCBpcyBhY2NlcHRhYmxlIGZvciBub3c/DQoNCj4gDQo+IEkgY2FuIHNlZSB1
c2Vyc3BhY2Ugd2FudGluZyB0byBleHBsaWNpdGx5IHRlcm1pbmF0ZSB0aGUgVk0gaW5zdGVhZCBv
ZiAic2lsZW50bHkiDQo+IHRoZSBWTSdzIGVuY2xhdmVzLCBidXQgdGhhdCBzZWVtcyBsaWtlIGl0
IHNob3VsZCBiZSBhIGtub2IgaW4gdGhlIHZpcnR1YWwgRVBDDQo+IGNvZGUuDQoNClNlZSBhYm92
ZSBmb3IgdGhlIHNlY29uZCBvcHRpb24uDQoNCg==
