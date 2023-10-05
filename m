Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E828C7BAB6C
	for <lists+cgroups@lfdr.de>; Thu,  5 Oct 2023 22:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjJEUZO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Oct 2023 16:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjJEUZN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Oct 2023 16:25:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4814695;
        Thu,  5 Oct 2023 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696537512; x=1728073512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tv6nUDDROYfDYrhdCoODl/bo9d5ZcsURZedbndU8Q/8=;
  b=TcsTu8qy8Sy4r9hlwnNEFH++va1+NWPzR/1jt9sSszpkbeCigvbtRUJj
   6oSxVNZSJvkuEDbBtxWld/z1uFq968ZBYGK8T2pSJsNZwhwPOaCL8Ejf7
   qVp7apEbTQ6LqvTy0nMFuaLWJ1FjEw5RFjbFxO9F7dLFu6XL15amlC+cs
   FbTKFvS6iDbHUJY3p5thUAePXqai0dMw7FAXZ9iRb5OJ+eI0acSreKDAN
   GPG7dmSMCuLj8u7SXI/J9wcIomRGgTkDno39IBThY39BrhZkNBPqBRDMQ
   MBPANkyL2oLeJ4UehGdk+AY90MXfkUujuQiURviKpILXfSNeyBL8dGrpR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="380884858"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="380884858"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 13:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875670413"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875670413"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 13:25:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 13:25:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 13:25:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 13:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBVN0eoh7cxe3X9Hv4es7nYSoBld5XQXxZyvbqL17lZcHBV21EwiiL8kYlATFexKnuDwxHngwJoSwZdyYeo4ABzoSd72YyI961LBGwviK23Bbz3wYEURzXOWMoMht62H8vd/EAOBQ9FoN96IXrjxnzSR4u6eg8+97Sfhph4bZ4sCSrdYSty2O1DOhewckKbYfehohzYeGyqnl32FiB/F0agHcWHlV/PoJNHE66KDfjNDsnzSeqKbYO9Rinznk0TxK/BT3CMKSpTOyT2Okp6MjKAnwYA3ISxH7CLQ51lQUn011vt1O8vYq6y0VxMPqKZk4leRL+5jyEufpK9q2WJ81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv6nUDDROYfDYrhdCoODl/bo9d5ZcsURZedbndU8Q/8=;
 b=bCyXPYlpf0J6qLroANPuWPNwfHGKEknFkQebAJUpcI3IlJ8dW3P81rL8utv29jIYTRlpBn0yBsFejbH7iozYm4drWgg6Ro1EsOL9wzHZsAixG2V7VomPUQ8to2cwWRMiHr1mrdw9ArxaqQxlegPb1G10SKRo8PA/so+wFTTE/8LM0Y4UQMEZKcBpuWw391/ClnjQWwuYEEv3OHHNABfu6WQBRwaDrqqdfpZM65Zv2318rMv2FGN/0+jTvJh1lslU+wyASr4nIqfS+kBFNFLCqAySmqaxum/7O5+E9s0An6ZTu1OW4mhlns08Tj1Hb9CdlIvHRQ1TYDmYBuwzBNvlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 20:25:02 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 20:25:02 +0000
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
Subject: Re: [PATCH v5 13/18] x86/sgx: Expose sgx_reclaim_pages() for use by
 EPC cgroup
Thread-Topic: [PATCH v5 13/18] x86/sgx: Expose sgx_reclaim_pages() for use by
 EPC cgroup
Thread-Index: AQHZ7csijtHESmbqeky3jjE6y2bmv7A7MhWAgAB1G4CAABE/gA==
Date:   Thu, 5 Oct 2023 20:25:02 +0000
Message-ID: <44db76f151a83367069d83e3f9db585f3fa627bf.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-14-haitao.huang@linux.intel.com>
         <a03cf29a5ff35b9467470a0cd38e4096820eab8d.camel@intel.com>
         <op.2ccv41dwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2ccv41dwwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB4952:EE_
x-ms-office365-filtering-correlation-id: d9a10a1d-b105-4217-ab57-08dbc5e12784
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZ8oJOhFo4qWzUOJbm0m5PFtIdKuCnDGRO6rbKaFMp5IUNdZL+8KT8S4pBBCV2yZH27XNI42d2kaKWxx9gne7AVNn8F5qfAK+lCKZ66xL6jy47QyHFjQIsYec4NpqqqDQk3r8XUrlmeSpOT7S/zT8bVY8J18zUlSP3UoTi3gmcFPLvgNlRHE4cH9lGQ43uWXkotC1qdqn9lcam2X/lDNUMOw173P6FUxn9GkObRje7UDwcXo062m82YUw753yINv9a4exQwdAG7Ox9GRUCQ1Jshmf6L8vhS0B2gF+sPxDt7XpRaVmHMQY37Wiw8bKsKD8SqbeGg5nc/AVUOytCOPj4VYO5K8ifcGMshYV3SAtLioVkL9evXXKDib/a5Wnl9i678oypGQqtWPdUIaRQDFgIaXMMb1CZmq8TcpwWKKM57gYIHCRyooYAYMXTna+YyS6MapFotEVG6sSNm4GIScaTwJ6grAO2pcLPHSg3DGRSVWW+XrxgL504Ecuz53haPJBDcNIIqejGAindHuSO4Rc1915RoLv9ee8Wg7h9D/hIWEqUNXjd8ATehdAqCGTLQOGtIFQ1P5ffWOOjIPWgxy9ZR/ZI0Tqe7Bh+8E2AvtUZ9Kh5yC7Ow5J1yaQa25yOvNFRAbhGcgMAuVb1xfh/p9+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(316002)(66476007)(91956017)(76116006)(6486002)(2906002)(66446008)(66946007)(64756008)(66556008)(478600001)(110136005)(2616005)(8676002)(8936002)(71200400001)(4326008)(26005)(54906003)(6636002)(5660300002)(6506007)(83380400001)(7416002)(921005)(6512007)(41300700001)(38070700005)(122000001)(82960400001)(86362001)(36756003)(66899024);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2xPTzUyWjlTQmJhRWVaOXZ3REdrN3E2UUhmcXdzanBETGs0TTdVeVZvTHlZ?=
 =?utf-8?B?aGhGd3J0ZWllaExzcmpIbWJKR2RtcVVtMXBXTEljSVVLVkVYTGhEVUdsa0tr?=
 =?utf-8?B?c2hVZmJiOFgzT0RMSFNCTk54ejYwZmJtYmFocDd3bzNnZG5XTGFvZ0g2M3ZI?=
 =?utf-8?B?OGJrSDJQWEF5enJydUZNQmlLYi9qWDZhM1pRc0FvWnBnZUtNYy9jV21IZWJZ?=
 =?utf-8?B?L25MZHEyQWtJSUxRSXo4Y2JqYmZLN2tCQmJwc0duaWV1cW0yZ1R1TkFIK1Qv?=
 =?utf-8?B?WitqZ3VlTFZieWVoNVVjY0tIZnRobkQrdkhwSUVIY09tU2hEcDE5MlNwVC9H?=
 =?utf-8?B?VnNsL0h2K0xrTGdPMGh0eXBMcXZ2WkFNQmZGWHFwMnZ2OVpGMEthMkFIK20v?=
 =?utf-8?B?QjQyTE5kWDdyaEN1b0psYWtzc1lnSEV3V0IzMUxPY1F3dUwxZjMydmo1YnF6?=
 =?utf-8?B?cExkeEJnaFpSREJ6YXFqZGh2d0ppbFFoRHZjM1lDaCtVV1JDWFVmak9LUzJj?=
 =?utf-8?B?UTdHaDY3WEVtRVJwbVo5MFhTV3oxbnlnSXlIRXVROENsWDFONDBuZHFDclla?=
 =?utf-8?B?M3IzN3FoZWcwTnJtSCtwQjcxM2xRbEJuMVhkOTVibkJRZTZLNGY1ZitkTEhy?=
 =?utf-8?B?TXBWcFVBRVFwS1BxZlE3UFJwQW54TlNlbHc1QWFmaHQzVWk2MDlmTUxmWmlK?=
 =?utf-8?B?NEJWa0dKem9BNEFFS091NWhTTHR4YnJlb1hNay95QWtyNS9Da3RUYk1OZ2dt?=
 =?utf-8?B?eEM1RFB1MVB2clRTNGU2RTZCeHQ3eldqejd0em9qOVhnckFDYkROVEE1R3pZ?=
 =?utf-8?B?bzF2d25hbzY5UmRWMTNUdWZUWEFqeWRpQ0tKTXBzUi9zZlBRdDUzSmVUQmJQ?=
 =?utf-8?B?cWpRd05nRzI2YXR3WVZOajU0ZWE0b0xMc2NWcG1LNnpNblA1UHlHQTJqY0Vt?=
 =?utf-8?B?Y1JlTDNMQmN1M3V6N3FYS1hSdmtDYTQyOGY0MWZhZzFVOUdmNFVtbU92SVBi?=
 =?utf-8?B?bElhd2tTRHgyRzJ3OWovWHo4MVpNd2hpTnVTWE1EaHNIV0lsSXBNM1B5SmJp?=
 =?utf-8?B?QVVJU1p2em8reXpObSsvUnNWVGg3aXRxc0FLY1gyZTgwTXdnUjFPcVE2b1Zv?=
 =?utf-8?B?cm95dnM0WUg3SXYrM3htdktUNHpldFZMQk5ERW8yRE55N0NmZVRuZkxEdkNR?=
 =?utf-8?B?Uk5KcmhTVmZMZVg0alcvak84R1dhQU1jY0cvbHRvbzN4VkRncU50azRmcTdl?=
 =?utf-8?B?TVNVTVZmTC9BWUFQQ1ZCT0ZCblpuakZSVmR3SVNNbU1ESEVGeHI2NHVFMUk3?=
 =?utf-8?B?VnBNNC9mL01uOGJQY01GQ2VOalNhazB0UmZUOXdBaTZDdHpyZkRyQjM3SXYv?=
 =?utf-8?B?WGRTa2pIWUhneGQ0cEtLOXpwaU5YRnhla3BYaWMxTzBSNHIyRVZ0ZjFKWVhM?=
 =?utf-8?B?b1gvaDdnYStSSno3N2NzVHRPOXdUSlFpUDlheUk2L3FpMmt3OXlBTzBlaklK?=
 =?utf-8?B?UWtYV0xrR1R2ZkwwQ0dnajJWVHZSU3JOU05KSzMyNHM1aXBSeU9mbkRaVnpF?=
 =?utf-8?B?d0djbDN5a3hQRmtQSWVrMUQwd0pYMktLTWIzcmZaeFNkWlQ2M08yU2dqc2Q5?=
 =?utf-8?B?ZzAraGFIRXZkSDl1YXNHVEtwMkVrVjNIb3JrMHlQY0RDUlNrSXByQnNmdFU2?=
 =?utf-8?B?amh2NmFmVWxFQlNqbUJsUlRGbHNHcGQ1d2EvRzgyRVdUb2NWYkRUTnVicGd1?=
 =?utf-8?B?T0lPM01sb3dUZ2YwZ3dVbGhPdDBoTjVOVUphbkh1WFgvTVFieEc3Wm9JYU9S?=
 =?utf-8?B?SzRZQ2xIY0IzYmg0TlRGM04xQklWMUtteUhjVi9meVZOQUlDVmNvRzNvcVMr?=
 =?utf-8?B?LzFpeHFPdkx0ZkpRRy9xK3JjazEyOEpUdE9mMnMrSnA0SVpGdlJSc1J0c203?=
 =?utf-8?B?RGgvdGJHVXF4QWRyVk54ZmVqeUpIcUUzd09FUGliN3RBK3pJOXVXc3JGY1Z4?=
 =?utf-8?B?RUhFbW9OdEs0dGd5SzBYY2dDeWEwSGRqVkhvcU0wbFErZFVZY3d0ak5FTnRV?=
 =?utf-8?B?cDlpZm5nZ0VBRHA4YUh5L09TcFVneC9paVRkT3NaeFFkaWxhNEpWR0ttZ05o?=
 =?utf-8?B?Z05oRHlEamlaVWY3a01ieFhJQ1ZyZHNCaWhISmFvUjVQQnlzTmVheEdKNmFB?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25F3C774BA68BC408AE5215EB87790A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a10a1d-b105-4217-ab57-08dbc5e12784
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 20:25:02.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2oPBgnROn54GanLh8/S/oauPvYDfkh1pWhFazq2oM/BfoPVYEZyGPZdQVTVSNxcl6A0lifpdvvWFSjYi3zkqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4952
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQo+ID4gPiANCj4gPiA+IC0vKg0KPiA+ID4gKy8qKg0KPiA+ID4gKyAqIHNneF9yZWNsYWltX2Vw
Y19wYWdlcygpIC0gUmVjbGFpbSBFUEMgcGFnZXMgZnJvbSB0aGUgY29uc3VtZXJzDQo+ID4gPiAr
ICogQG5yX3RvX3NjYW46CQkgTnVtYmVyIG9mIEVQQyBwYWdlcyB0byBzY2FuIGZvciByZWNsYWlt
DQo+ID4gPiArICogQGlnbm9yZV9hZ2U6CQkgUmVjbGFpbSBhIHBhZ2UgZXZlbiBpZiBpdCBpcyB5
b3VuZw0KPiA+ID4gKyAqDQo+ID4gPiAgICogVGFrZSBhIGZpeGVkIG51bWJlciBvZiBwYWdlcyBm
cm9tIHRoZSBoZWFkIG9mIHRoZSBhY3RpdmUgcGFnZSBwb29sICANCj4gPiA+IGFuZA0KPiA+ID4g
ICAqIHJlY2xhaW0gdGhlbSB0byB0aGUgZW5jbGF2ZSdzIHByaXZhdGUgc2htZW0gZmlsZXMuIFNr
aXAgdGhlIHBhZ2VzLCAgDQo+ID4gPiB3aGljaCBoYXZlDQo+ID4gPiAgICogYmVlbiBhY2Nlc3Nl
ZCBzaW5jZSB0aGUgbGFzdCBzY2FuLiBNb3ZlIHRob3NlIHBhZ2VzIHRvIHRoZSB0YWlsIG9mICAN
Cj4gPiA+IGFjdGl2ZQ0KPiA+ID4gQEAgLTI5MiwxNSArMzAxLDE0IEBAIHN0YXRpYyB2b2lkIHNn
eF9yZWNsYWltZXJfd3JpdGUoc3RydWN0ICANCj4gPiA+IHNneF9lcGNfcGFnZSAqZXBjX3BhZ2Us
DQo+ID4gPiAgICogcHJvYmxlbWF0aWMgYXMgaXQgd291bGQgaW5jcmVhc2UgdGhlIGxvY2sgY29u
dGVudGlvbiB0b28gbXVjaCwgIA0KPiA+ID4gd2hpY2ggd291bGQNCj4gPiA+ICAgKiBoYWx0IGZv
cndhcmQgcHJvZ3Jlc3MuDQo+ID4gPiAgICovDQo+ID4gPiAtc3RhdGljIHZvaWQgc2d4X3JlY2xh
aW1fcGFnZXModm9pZCkNCj4gPiA+ICtzaXplX3Qgc2d4X3JlY2xhaW1fZXBjX3BhZ2VzKHNpemVf
dCBucl90b19zY2FuLCBib29sIGlnbm9yZV9hZ2UpDQo+ID4gDQo+ID4gJ3NpemVfdCcgbG9va3Mg
b2RkLiAgQW55IHJlYXNvbiB0byB1c2UgaXQ/DQo+ID4gDQo+ID4gR2l2ZW4geW91IG9ubHkgc2Nh
biAzMiBhdCBtYXhpbXVtLCBzZWVtcyAnaW50JyBpcyBnb29kIGVub3VnaD8NCj4gPiANCj4gDQo+
IEluaXRpYWxseSB3YXMgaW50Lg0KPiBKYXJra28gd2FzIHN1Z2dlc3Rpbmcgc3NpemVfdC4gSSBj
aGFuZ2VkIHRvIHNpemVfdCBhcyB0aGlzIGZ1bmN0aW9uIHdpbGwgIA0KPiBuZXZlciByZXR1cm4g
bmVnYXRpdmUuDQoNClRoZW4gJ3Vuc2lnbmVkIGludCcuICBXZSBhcmUgdGFsa2luZyBhYm91dCAz
MiBhdCBtYXggaGVyZS4NCg0Kc2l6ZV90IGlzIG1vcmUgc3VpdGFibGUgZm9yIGJ5dGVzLCBidXQg
d2UgYXJlIGRlYWxpbmcgd2l0aCBudW1iZXIgb2YgcGFnZXMuDQoNCk1heWJlIEphcmtrbyBjb3Vs
ZCBjb21tZW50IHdoeSBzaXplX3QgaXMgYmV0dGVyLg0KDQpbLi4uXQ0KDQo+ID4gDQo+ID4gPiAg
CWkgPSAwOw0KPiA+ID4gIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZXBjX3BhZ2UsIHRtcCwg
JmlzbywgbGlzdCkgew0KPiA+ID4gIAkJZW5jbF9wYWdlID0gZXBjX3BhZ2UtPmVuY2xfcGFnZTsN
Cj4gPiA+IA0KPiA+ID4gLQkJaWYgKCFzZ3hfcmVjbGFpbWVyX2FnZShlcGNfcGFnZSkpDQo+ID4g
PiArCQlpZiAoaSA9PSBTR1hfTlJfVE9fU0NBTl9NQVggfHwNCj4gPiANCj4gPiBpID09IG5yX3Rv
X3NjYW4/DQo+ID4gDQo+IE5vdCBuZWVkZWQgaWYgYWJvdmUgZm9yIHN0YXRlbWVudCBmaXhlZCBm
b3IgbnJfdG9fc2Nhbi4NCj4gQW55dGhpbmcgYWJvdmUgTUFYIHdpbGwgYmUgc2tpcHBlZCBhbmQg
cHV0IGJhY2sgdG8gTFJVLg0KDQpJIGJlbGlldmUgdXNpbmcgbnJfdG9fc2NhbiBpcyBtb3JlIGxv
Z2ljYWxseSBjb3JyZWN0Lg0KDQpbLi4uXQ0KDQoNCj4gPiANCj4gPiBJIGZvdW5kIHRoaXMgZnVu
Y3Rpb24gYSBsaXR0bGUgYml0IG9kZCwgZ2l2ZW4gdGhlIG1peGluZyBvZiAnbnJfdG9fc2Nhbics
DQo+ID4gU0dYX05SX1RPX1NDQU4gYW5kIFNHWF9OUl9UT19TQ0FOX01BWC4NCj4gPiANCj4gPiBG
cm9tIHRoZSBjaGFuZ2Vsb2c6DQo+ID4gDQo+ID4gCTEpIFRvIHRha2UgYSBwYXJhbWV0ZXIgdGhh
dCBzcGVjaWZpZXMgdGhlIG51bWJlciBvZiBwYWdlcyB0byBzY2FuIGZvcg0KPiA+IAlyZWNsYWlt
aW5nLiBEZWZpbmUgYSBtYXggdmFsdWUgb2YgMzIsIGJ1dCBzY2FuIDE2IGluIHRoZSBjYXNlIGZv
ciB0aGUNCj4gPiAJZ2xvYmFsIHJlY2xhaW1lciAoa3NneGQpLg0KPiA+IA0KPiA+IEl0IGFwcGVh
cnMgd2Ugd2FudCB0byBtYWtlIHRoaXMgZnVuY3Rpb24gdG8gc2NhbiBAbnJfdG9fc2NhbiBmb3Ig
Y2dyb3VwLCAgDQo+ID4gYnV0DQo+ID4gc3RpbGwgd2FudCB0byBzY2FuIGEgZml4ZWQgdmFsdWUg
Zm9yIGtzZ3hkLCB3aGljaCBpcyBTR1hfTlJfVE9fU0NBTi4gIEFuZA0KPiA+IEBucl90b19zY2Fu
IGNhbiBiZSBsYXJnZXIgdGhhbiBTR1hfTlJfVE9fU0NBTiBidXQgc21hbGxlciB0aGFuDQo+ID4g
U0dYX05SX1RPX1NDQU5fTUFYLg0KPiA+IA0KPiA+IFB1dHRpbmcgYmVoaW5kIHRoZSBteXN0ZXJ5
IG9mIHdoeSBhYm92ZSBpcyBuZWVkZWQsIHRvIGFjaGlldmUgaXQsIGlzIGl0ICANCj4gPiBtb3Jl
DQo+ID4gY2xlYXIgaWYgd2UgZG8gYmVsb3c/DQo+ID4gDQo+ID4gaW50IF9fc2d4X3JlY2xhaW1f
ZXBjX3BhZ2VzKGludCBucl90b19zY2FuLCBib29sIGlnbm9yZV9hZ2UpDQo+ID4gew0KPiA+IAlz
dHJ1Y3Qgc2d4X2JhY2tpbmcgYmFja2luZ1tTR1hfTlJfVE9fU0NBTl9NQVhdOw0KPiA+IAkuLi4N
Cj4gPiANCj4gPiAJaWYgKG5yX3RvX3NjYW4gPiBTR1hfTlJfVE9fU0NBTl9NQVgpDQo+ID4gCQly
ZXR1cm4gMDsNCj4gDQo+IFdlIGNvdWxkIHNldCBucl90b19zY2FuIHRvIE1BWCBidXQgc2luY2Ug
dGhpcyBpcyBjb2RlIGludGVybmFsIHRvIGRyaXZlciwgIA0KPiBtYXliZSBqdXN0IG1ha2Ugc3Vy
ZSBjYWxsZXJzIGRvbid0IGNhbGwgd2l0aCBiaWdnZXIgbnVtYmVycy4NCg0KUGxlYXNlIGFkZCB0
aGlzIGNoZWNrLCB1c2luZyBXQVJOX09OX09OQ0UoKSBpZiBpdCdzIGJldHRlci4NCg0KVGhlbiB0
aGUgY29kZSBpcyBtdWNoIGVhc2llciB0byByZXZpZXcuDQoNCj4gDQo+ID4gDQo+ID4gCWZvciAo
aSA9IDA7IGkgPCBucl90b19zY2FuOyBpKyspIHsNCj4gPiAJCS4uLg0KPiA+IAl9DQo+ID4gDQo+
IA0KPiB5ZXMNCg0KcGxlYXNlIGZpeCB0aGlzIHVwLCB0aGVuIC4uLg0KDQo+IA0KPiA+IAlyZXR1
cm4gcmVjbGFpbWVkOw0KPiA+IH0NCj4gPiANCj4gPiAvKiBUaGlzIGlzIGZvciBrc2d4ZCgpICov
DQo+ID4gaW50IHNneF9yZWNsYWltX2VwY19wYWdlKHZvaWQpDQo+ID4gew0KPiA+IAlyZXR1cm4g
X19zZ3hfcmVjbGFpbV9lcGNfcGFnZXMoU0dYX05SX1RPX1NDQU4sIGZhbHNlKTsNCj4gPiB9DQo+
IA0KPiBTb21lIG1haW50YWluZXJzIG1heSBwcmVmZXIgbm8gd3JhcHBpbmcuDQo+IA0KDQouLi4g
T0suDQo=
