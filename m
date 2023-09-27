Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFBF7B0DFE
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 23:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjI0VVc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 17:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VVb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 17:21:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C8311D;
        Wed, 27 Sep 2023 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695849689; x=1727385689;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=clsAwteIM0W8QER0hUDPNbDuSasdIjj9GTDHFCZpltA=;
  b=IPYPc+YxxV9BIAhHH1oC+HU13SMKhytzuNU2xE5mXjxpI8k9MDr0wO0J
   rkj4cH9tJy1iL9q6RQSMi5P3RnH/QbQg1P3vonDSckLIOLINXlCcavtX8
   Q9iwpz9TiKYZ21T9S9gHuWi5CX0nn/fxIeohvpzyoopZMlsSjvQqOrECT
   sMma63o4pYxbmh0cpG2OhUv9wuIujWEsfMWSFJvGqZW7YC4X+bxx/F+ml
   ZJDGoJYVZtjt8nQh7chF3eJ03Lx4zoGkQ1RQFCQu3l41xnNFY0OHzIeJr
   L8S/783M9atCEbjvrRR3V3VbeR2NWdPT1914eTzn84dfgpfrK2gOOlfyr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="385792451"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="385792451"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 14:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="815001260"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="815001260"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 14:21:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 14:21:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 14:21:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 14:21:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKiiz1GToS81ZSC/TZ+Te/1oK7pmwz1YgOvuD/vjfAAugESeYXwRUDA92dgc2GmzL7WCYGurRC37BMuthoai8o8EA34ERCBBGGtKvxAkYuwEp+/ktaGXIEN/SMV28i0lAn0TIM8ImifU/zDFPqBMFHRw7XDGA3xaPa2AUn418IRwAZ6Sd2QP25yAgnWwD6YvuMr/pHXYayKcnxGb7PkOUMK9A8ZrR2yGaMi8zIMs+PIpVvw9oZpL7ctx3wlkTMFTgGfSgWFt4J5C8yrrGV38JJzjTS/x/wAIDJPnyRrnSYmlbjA/987T7ygEzLaFfKQ5EXDdPKsw6FZEUGu+mObGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clsAwteIM0W8QER0hUDPNbDuSasdIjj9GTDHFCZpltA=;
 b=JuyLEZb1DevIir6CIbVaR7n9yiL2XRnSiqPtgsp8ma3ZDRVhZ35GaglxnUm3D1lY0OdrUfS8jAy1WMvqoarWICv2QxX3rnWcGkMk3vC6wfg8pc5okfzbajDy1TV05lG5QBexwPwMF9BWizCO859WKrmLi8fsI50Z/hKgQUT9S4oYEj6CLllpH3vWWnCGcwOvaQ7dPsce7KZWGMFLQFKcZ62KgJ0mZWHwXPQ95MHBoVczSkKKoQWXt0LjpMroOhKdCROt4XhREhpTk/imvN2QOqYtvNDo4GjL5ppmlPKBQXSXK6yhDIFd2x5mdfhsFzmJB0c5+N/qRL17sB+U5MfzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.41; Wed, 27 Sep
 2023 21:21:19 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::e8cd:d21e:fe87:2e39]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::e8cd:d21e:fe87:2e39%6]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 21:21:19 +0000
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
Subject: Re: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Thread-Topic: [PATCH v5 09/18] x86/sgx: Store struct sgx_encl when allocating
 new VA pages
Thread-Index: AQHZ7cscCwFKzsfMlUe7K1500sBqu7Aui+oAgABI9gCAAGCkgA==
Date:   Wed, 27 Sep 2023 21:21:19 +0000
Message-ID: <fd2049b46a2e508a90006731a5d0cd2b90db9e45.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-10-haitao.huang@linux.intel.com>
         <46fecb95ae2c4cd156ad7bda99522214fcfe5774.camel@intel.com>
         <op.2bxr9aj7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2bxr9aj7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|IA1PR11MB6098:EE_
x-ms-office365-filtering-correlation-id: 1f8e83e7-bff8-42fa-0456-08dbbf9fb12a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rw+gjTBw1vT4ADL9YjvIdGTjyB0zk/fI9M4jPcXvFND5NNTkD5rpsO1CV66dCerMz5l+KObycKFJs+VQYwka2I0E1KTGkPBBswDkkS7hRuuZSems/DKvf5kgXricxtgtVsOoPP9ZQY634AlxPyVXLTgeB/JmKLDfORw6JHnQ2XV6lHV1hExJFXW0C5QAKouuaTTvir0iMedxjV1W4A+oah+J0vT/HHrGvCrtWOeD15HgQ4nSdXgpuVAfP0HkqTHml9v6MVQXAJSEpOQghpeAmYQ/cTkdirZ/7cwwFA/IntIy7GqE2SIjcZmAumLdmOPUuIRJAU5f0rcKSk6f9g+zZRP0JlVnvwo4M183W6bIi74FNEhw/ch7EmCASzntJj4Q0MUU5hFfYxm6Tscp0avXvZaiZlpJ9bryzmnro983chAD/V1I87QSoEtZccgNtLcvDlpnVKtG8J6WUxhEKN2QPDDZdBCy5UBiWYWHRx1vE9L+i+9CEHWYG5eINIjlwp1Lqsa4DCY59/bw1NqkUQbDZc959lfOggR/1HL/+85kr07U3V1COHPxDfH35h96qkAqFW0a6JxXp84e/zpG17CO+EYCdJx+1Q2TkkbejojMUPAc5+AVHaTSNFL2IxVc4uJb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66476007)(91956017)(478600001)(6486002)(6512007)(54906003)(76116006)(110136005)(41300700001)(6506007)(316002)(66556008)(6636002)(2616005)(71200400001)(66446008)(64756008)(5660300002)(8936002)(4326008)(66946007)(8676002)(86362001)(26005)(36756003)(82960400001)(83380400001)(38070700005)(921005)(7416002)(122000001)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3lTdlNRMVpoeFJ5MUQyQ0E1UXF1Y2cvR1RzRnlPcmVDUExOdzRIZ3Q5b1dk?=
 =?utf-8?B?ZkJSZWRldzR3WFMyT3g0OUIvMXdWaTB1TzR0MFNCZGYzWjZweXNpdkpNRE5V?=
 =?utf-8?B?M0x5Kys2UERWU3J1TnBJY2o0T080eDNuTmtDOHVqMCtDNVE4bXltNDdSeWww?=
 =?utf-8?B?dDNqN0R1aU1HdGdMNmMrVTNsMDNIUVk3c0JpZ2h5eWNoTGhpOVBkVUdrcGtn?=
 =?utf-8?B?Q0FRQkttZkpYTkxjNXpWd0lMTnpmZ24wSnZ5RkRrWi9oRU9UUFJCaStVMUZ3?=
 =?utf-8?B?VURHalRyRlZjMlViZWhpRWx1MWwxWW83dUhmdDZHUHp2cVhjd2hkTHhxZUFW?=
 =?utf-8?B?NFUxQkJROFVzL0NpKzhaVENSdDBFbHptT01aSGR2WlZDV3ZhVXRmcStDbmJq?=
 =?utf-8?B?NXo1MkVlRzJVN3FpeXlVZkkxRGs3Smk5UldqOUxvL1kvTkk4OXAyMVRCUUJW?=
 =?utf-8?B?aVhSMTdKdmtDbUgyVmdXZG1WUE5DbzBPOXJSODJieldNRUh0UEtzOE5LckJ6?=
 =?utf-8?B?TGx0aHlabm1ncExMOTlCa0xKK3VyK0ZQUDVXbWpJUmVnSFpRWE9FYkM0YlM2?=
 =?utf-8?B?Wm9RaHJUSnpWU0NWNlZBcE1lZ0J5TmxQRXkyWGVwNXVNbWpicUpvZG1wYTRV?=
 =?utf-8?B?clg4ZTIxcEl4QWRValVvbUNTblEycFUyNEdRL1pzUWRkV0tvOTlHaTFrMDE5?=
 =?utf-8?B?N1V3N0hlL3dnOC9ubmdUMXQ0bEVUL1BXQ2xJYittK09Ia1UvQ3R3VVZxOER1?=
 =?utf-8?B?QnJybU0xby92L0F2aWFuZ1c5UnRtSnZnYkhneDZJTFNoUXV3SXBqcDJiYWpZ?=
 =?utf-8?B?cy9STVN4T3JXcHVrSnlINjRCaFRQU3ZuOHdNeDhINjU0a1NmVmp2OEdobXFx?=
 =?utf-8?B?OWpsWUFabjcvamJHUlQzSWFLd3hPS3FVT3cyOFprRGEvY0lNTHVRakw3b3NX?=
 =?utf-8?B?NW9JOEUyRTgxRkdLM1pHWDFvNm4waFhXeFFoTmllcXdqV0p3dGhZZlprNVN6?=
 =?utf-8?B?ZlRYOHk0cVdUVDZHNTU4dkpFWXRoR2JsOUJkSkMyNityalNMc0xneFhiMG5p?=
 =?utf-8?B?QWtDRjM5dGZIc1d6K3NucjcxZS9yVWdEMGtoWmtFOHhGVHpzSDdMQjdUZi9T?=
 =?utf-8?B?aUc0WWg1UVhKSlFvSUIxMTMxemRYaGdPN1lIalAxZW5KMWUvQTJ3ejlTMThn?=
 =?utf-8?B?Wk1FM1JRaXkwYXcvU1UwLytkdVBwN1dobVY2YXBOYU9Za0gxY3JHeHJ2UEk4?=
 =?utf-8?B?YTBRVkdHYm10TCtDQnpSTitLTlg0Y3VvUlZtUEdMcmdudFArRTR6c0IyVm9Y?=
 =?utf-8?B?REliRWd1OGhUOTZleFd1M1Vja3g4VkpPMnpTd0poOUV0OGJoZkJJeEtmSTFh?=
 =?utf-8?B?M2tCMzliZ3NhTVEvU1BRS2tNSFQ3UlJrN2ZtSms2c0laZklvNXBKaEs4R2p0?=
 =?utf-8?B?eGd5aTNIUmRMY293SE9XWExMWHk1dmVnZGtKaWxvZWdhekFSbk1IbWlGUEZB?=
 =?utf-8?B?aUxQU2FZTGdWUG9HaURoL1ZrcWloREwrOTFmZ29Xek9VdFRxRDFIb2NIZFU1?=
 =?utf-8?B?anpadmpGUThZN0k1VlJRSDdrVlk0bk9tRVVEMEJBSG56Y0pXa1BGbTlhSGNn?=
 =?utf-8?B?UEZvblEzd0hKYzdJeDRmNVNRU1F6WGlNODNPNDgyVi81YWVXL3dxdmpkNnFY?=
 =?utf-8?B?Umh2QjZyeDVLY1hEMlN4NUVBWWxxZExPM3FmelhaenI4Q0ZvSkdJc3A4WkhS?=
 =?utf-8?B?RUticDZuQXN0TjljcVgwSThJMUZuRVJFYTVkWW1UZmE2VHdxeXYwN05UM0JZ?=
 =?utf-8?B?aWg1WWtuZ2picVl0bGRneGtDQTYxTGJ5b3c3ZWI2WURrRlJUNWpTNXdEdFFL?=
 =?utf-8?B?TC9oYkdYOWdOSmgxQTBOb3ZjZGJCZTVzdDJrZ0twbTNTcXhXeUttUnZUZ0g5?=
 =?utf-8?B?dzlXazU0TXRueHp6SjlWM3V3ZERocEkwSTVxdFRwQXNkSjY0MEVIWlh0eExF?=
 =?utf-8?B?eVNicEN6N1JSc3hzemFHWmI2SUxiamRrNTF4Wk9MSnplamoyV0pDREFEMjYv?=
 =?utf-8?B?eW93UERMRFlUbDdMMG0wYmxxUWdDM2JMRHpId25OTzY4bWNZWVBFazJub3dR?=
 =?utf-8?B?SmlpNlhreEh4QXBOcGVGaU5zSmtmaUQ2L2Z6U1N4alNmT1A0UEZRRjhMa20v?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FA7D8664A50304FB1DA11D2EA786F26@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8e83e7-bff8-42fa-0456-08dbbf9fb12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 21:21:19.5808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYa9KcWH7CABq1Gmze29HBXhrayqpa5UJr/u4bvBHL92zvvlqM80B/gnybNNNQnKTLR+5LLg9TTJ3M4THxt1aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6098
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gV2VkLCAyMDIzLTA5LTI3IGF0IDEwOjM1IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ID4gPiArDQo+ID4gPiArCS8qIFBvc3NpYmxlIG93bmVyIHR5cGVzICovDQo+ID4gPiArCXVuaW9u
IHsNCj4gPiA+ICsJCXN0cnVjdCBzZ3hfZW5jbF9wYWdlICplbmNsX3BhZ2U7DQo+ID4gPiArCQlz
dHJ1Y3Qgc2d4X2VuY2wgKmVuY2w7DQo+ID4gPiArCX07DQo+ID4gDQo+ID4gU2FkbHkgZm9yIHZp
cnR1YWwgRVBDIHBhZ2UgdGhlIG93bmVyIGlzIHNldCB0byB0aGUgJ3NneF92ZXBjJyBpbnN0YW5j
ZSBpdA0KPiA+IGJlbG9uZ3MgdG8uDQo+ID4gDQo+ID4gR2l2ZW4gaG93IHNneF97YWxsb2N8ZnJl
ZX1fZXBjX3BhZ2UoKSBhcmJpdHJhcmlseSB1c2VzIGVuY2xfcGFnZSzCoCANCj4gPiBwZXJoYXBz
IHdlDQo+ID4gc2hvdWxkIGRvIGJlbG93Pw0KPiA+IA0KPiA+IMKgCXVuaW9uIHsNCj4gPiDCoAkJ
c3RydWN0IHNneF9lbmNsX3BhZ2UgKmVuY2xfcGFnZTsNCj4gPiDCoAkJc3RydWN0IHNneF9lbmNs
ICplbmNsOw0KPiA+IMKgCQlzdHJ1Y3Qgc2d4X3ZlcGMgKnZlcGM7DQo+ID4gwqAJCXZvaWQgKm93
bmVyOw0KPiA+IMKgCX07DQo+ID4gDQo+ID4gQW5kIGluIHNneF97YWxsb2N8ZnJlZX1fZXBjX3Bh
Z2UoKSB3ZSBjYW4gdXNlICdvd25lcicgaW5zdGVhZC4NCj4gPiANCj4gDQo+IEFzIEkgbWVudGlv
bmVkIGluIGNvdmVyIGxldHRlciBhbmQgY2hhbmdlIGxvZyBpbiAxMS8xOCwgdGhpcyBzZXJpZXMg
ZG9lc8KgIA0KPiBub3QgdHJhY2sgdmlydHVhbCBFUEMuDQoNCkl0J3Mgbm90IGFib3V0IGhvdyBk
b2VzIHRoZSBjb3ZlciBsZXR0ZXIgc2F5cy4gIFdlIGNhbm5vdCBpZ25vcmUgdGhlIGZhY3QgdGhh
dA0KY3VycmVudGx5IHZpcnR1YWwgRVBDIHVzZXMgb3duZXIgdG9vLg0KDQpCdXQgZ2l2ZW4gdGhl
IHZpcnR1YWwgRVBDIGNvZGUgY3VycmVudGx5IGRvZXNuJ3QgdXNlIHRoZSBvd25lciwgSSBjYW4g
bGl2ZSB3aXRoDQpub3QgaGF2aW5nIHRoZSAndmVwYycgbWVtYmVyIGluIHRoZSB1bmlvbiBub3cu
DQoNCj4gV2UgY2FuIGFkZCB2ZXBjIGZpZWxkIGludG8gdGhlIHVuaW9uIGluIGZ1dHVyZSBpZiBz
dWNoIHRyYWNraW5nIGlzIG5lZWRlZC7CoCANCj4gRG9uJ3QgdGhpbmsgInZvaWQgKm93bmVyIiBp
cyBuZWVkZWQgdGhvdWdoLg0KDQpBcyBtZW50aW9uZWQsIHVzaW5nICdlbmNsX3BhZ2UnIGFyYml0
cmFyaWx5IGluIHNneF9hbGxvY19lcGNfcGFnZSgpIGRvZXNuJ3QgbG9vaw0KbmljZS4gIERvIHlv
dSBoYXZlIGV4YW1wbGUgaW4gdGhlIGN1cnJlbnQga2VybmVsIGNvZGUgdG8gcHJvdmUgaXQgaXMg
YWNjZXB0YWJsZT8NCg==
