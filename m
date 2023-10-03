Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC17B7255
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 22:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbjJCUId (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 16:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbjJCUIc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 16:08:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DAAD;
        Tue,  3 Oct 2023 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696363709; x=1727899709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aLUFVREmy51ukWKKSEgrTs1HlPk6vudyLE7ZB+An6Nk=;
  b=dTVfCaYXKneHXY2nER244oOan9rnSrQhmmguuQVD3sc6/x9GUnMbw8TT
   v3k/nwyDbVK3QpEseg7DFPRvt3hH0fBIDi8LbdVt58QL/8Xv1fpHpDxBt
   mVq3DR50X7xms47F87FHLpnoBIhMzC0OR2qjFW4C6CkLV3Boecv7wX+1b
   bledHZ+omlMCkZjdNhF0T47hbAg3oTZMLN/UsO4fqq/U8OUcoxQoKQ4re
   mraS6T+OvfDRMM1HUto+WeQxwF9dM5+/WrLKSWz6DIrnF9BLznSrR6uOq
   /waR5FAcmg45EwpS7fvCDqWRj4/YS5vjCySEA1ArpScIYMa3yu7EpT3NL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="380243348"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="380243348"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 13:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="894629720"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="894629720"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 13:06:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 13:07:47 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 13:07:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 13:07:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 13:07:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e33JPuqHKQRjIKRDyrkYMaalkhbS8/81EiRE4QW38r1nGQWIiijl4f5NLVPf8ekxJHUnyYQOLb5hgHWc/hLulF6wX7ZSIBhAD3j4PKXyHOHo401N4/As0tTwbh0O1MpFe7k2PguGWJ7zgaEJ/D0dRPoB1vCbg2UpKWNbk9xavn/4tVJGF2yNmejuqJR/Cu60v+qzeiKHYPmFKIjAqfYYAIMy7Qyem9+6PxSNBJCFESuVr4M5HEcvtfKPMVORQ5cE8A8W48UHE+7ihe9WCaQwpyXCWuGseQz2Gk1GuinLtHteokPNzTZZVkrZl3JOPDZWGxZSG7VNBmhOicg5j1SJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLUFVREmy51ukWKKSEgrTs1HlPk6vudyLE7ZB+An6Nk=;
 b=ROaHwjzs1t2ox84cs8RnmJJ0TP6JNSK7UvD5cp/2Zvpz1p02RpV2yyNy/JfqYy7TEYOM3AEqlWtPwZArbzGvSnlkNL+nGBdn1QaSXZj5uwge0f3rb6M8RmUOfNKYyNNmO9v4LPrk6aLITh3LF5l9IKILk/CCrQPMD6tHnmZzxJwXYLLy71jVt4q4FBTJP/tmPQ1QPGi/R8AEey1n5aBvNhBPoDbwbgoR+dNPj+46rmEzqDpD6ZU+YNMZf00vXSrVZvPsBlO53N9wo9VcSl8k950Svc0AfkBXukwsQvbUcMtgR0w5wiyMK832rBJlZYcm3dMng/ViH5MPIK2VxmHVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 20:07:43 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 20:07:42 +0000
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
Thread-Index: AQHZ7cscCwFKzsfMlUe7K1500sBqu7AukfYAgAkcyICAAOAtgA==
Date:   Tue, 3 Oct 2023 20:07:42 +0000
Message-ID: <0953e4fac90921ff53570e2e6ebd2689fc1cd8fa.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-10-haitao.huang@linux.intel.com>
         <ac66cb2b6e057f5e5e78345bcddea13a3e72ee5e.camel@intel.com>
         <op.2b77pp0wwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2b77pp0wwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6359:EE_
x-ms-office365-filtering-correlation-id: 2cc12182-4fd4-40fd-d995-08dbc44c6715
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LVramOPwgUdwru7abLD9WwZ2CcPmC3kowTHjAxONR++V/jy5Y0jCc+XkkZlDCJwwabOf99DlHqC/tCnQQ+HwUOP2uUxABb+oB+TFQt2PkV0vj4s9JNhGf1ZbxDVeJ+aauapBvhLIYIT1pLJV98QtY9JkbUbSPbfIwflSOiRm7bW2ltKk01kPRavS3eVpFTMpW4EKoOAfcHDuCvLUgzFOIRKNqRQanB+iMcMa1TvrorAzMoIdrS4O+zDclOC3IEr6Ir65sBov85hmw9MojJ1uXC7T6OhyvopLaigLVdSi4ivoqYt1rA+EYvWQ6zAQOuiSi4hi9V02D3SrgtdJo0HknqwuESOqTYYwUVTbuDeay7kkrGfEES9BI1dcbn6NJkzNWCOs4QHHT9G20vSWgkC1VB0knoSscStoXD+Iaq9DVxED4d/cZB5HQE8oBiAwTIiB4WDebWn0fklyUa78y4/NS3qcoopRPVqzmgr0VYm/o7ZRabzzNgdYdhXtB+XO94MxWY+ss9w7uxRww/PgNqPs2jU6x/GprFFL6frl4QU68mvGvopgoJxOe8LMsLnfvicFjevVAcDCEmZy0dww8LIx/XX9jk0S19JKoj50xID55Uq3mGKAaVapSFnpydKsiRN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(110136005)(91956017)(6486002)(2616005)(6506007)(6512007)(6636002)(316002)(64756008)(66476007)(54906003)(66556008)(76116006)(66946007)(66446008)(4326008)(8676002)(26005)(8936002)(5660300002)(71200400001)(478600001)(7416002)(83380400001)(2906002)(38070700005)(38100700002)(36756003)(82960400001)(921005)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M09hT2Ira2tXRFR5TVFmcjNpb2oxcTI3RGRIbnAxYUsvWWx3VEpwWlhxTDll?=
 =?utf-8?B?eU1kaS9yWmRhbHdrRms5QjBBMHVLaEc1c3U1VFhtWFJaNTJaaTVuOFkvaVFK?=
 =?utf-8?B?SWRsNDBTTmJORUlCT0JpdFJGTU5QdDNWdEFFeWJqMGxTYzd4b1pvVE5WMnRV?=
 =?utf-8?B?ZzNaa0hPcjFtTkdKNUtUeC9sSkdmZ2xFQ01HcTBjdlNhQlZGeWlGblo2SXhM?=
 =?utf-8?B?MmhSS0VWUFg5Z0V1Tmp6bWJIdlYvZGt6S0VGb2xtVHlVdzJwcXpUWnBEdGl6?=
 =?utf-8?B?K2pUckRQNHNvcDRoV3pJTG13MEd0dFhzWWx2bHpqWjVCU2htVVpnakk3emkr?=
 =?utf-8?B?WEtBQnJxb2xjWWVYZHY4N0NSMDhzZmZQRG5sK2REb2RqWjk3RzdIcmJXa2VB?=
 =?utf-8?B?U0ZqeXBLN1MxMGdic040VUtBOG5rWjdvNXNNckFISlUwT0pJNjRtczRCK1Br?=
 =?utf-8?B?R09ZVkdQQ2JxNFMxd3V4YVdneDMzZmtLUXBGb05ieW90ZS8wRlduYWhabktj?=
 =?utf-8?B?QUNPQ3dCNW96bXZVMWJQenNzZVJpb3NuenNKekNjcjlDZGtISEE1TnAvbk5o?=
 =?utf-8?B?WGV4WThXUit6MURkV3ZhWktqMTRsMDdnbHVUZklIMmZJQU9EaFVUYXhpaFJw?=
 =?utf-8?B?WDRMMGIxTHQvVDNjbGtXN1drMklYd1NXUGZNZHNNbEp3MDZUdDVsUEI0dDZX?=
 =?utf-8?B?dVFQeUg1NnZ4UmNtcUFSNzB3K3g3VDZIcVA2MjBnM0FOZXJZdGxsMm9XVEFO?=
 =?utf-8?B?YzN2RzNMNVhLdUdkQkFvRmNtVFJjeG5LM1RGeHhzT0g1djR3bnhodlpZL1E0?=
 =?utf-8?B?QXdNbEtqNExJMnNLcDRjVWtSVlZZV2p3WTBISEtHU3pZZTZTM2tJWlRsMkc0?=
 =?utf-8?B?VFk5YkFWdUpOQUFvRktQby9GaVdiRkJHVGN5NXBhOHMzdG1MSG4xVXlSUnYy?=
 =?utf-8?B?eVY0K0tMSEVvZ3RpZktSbnZKTTRsOUVZWXBlOFFYTmZGZFIzUXJzRmdJUU9D?=
 =?utf-8?B?dVgxN1VTWnlQTXJJdUJVaUlVeG5XWllOVkJHcUhwTWUzd2hJWFd5aVl1Wm9x?=
 =?utf-8?B?cEVIb0hsWHRmd0pJc1FjcVE5ejd2V2VDK1VPTEtEVUJwWHFTOEtwWXIyejFX?=
 =?utf-8?B?eDV5dTgyeFhvdXZpMUZKUzZxZFA4SFFPMWo4eDdMaGxHcUROZGJCN1E1bzBC?=
 =?utf-8?B?c1FhTVJONW9MdVhFeHJZVzJ5bG9DRFp1Sm82U2JiSjVrdkVEQU1DVXpjT3ll?=
 =?utf-8?B?Nkd3UGhxMFFQa09wY2xlaWc2UW1OUVNlaWpZS1Zzam11YzlFVHM2K0ZEY0g3?=
 =?utf-8?B?eTNaWGJqUFJMYml6ajhSOE1yZlNWMWVHd2ozRzV4SmkvbjBLUWd2Y21BNnl0?=
 =?utf-8?B?dmx5c25saldkZ3hodStBNkRnN0haZVNERjczTGRYK081OUNHemRySXE5K0gv?=
 =?utf-8?B?NjNuS1RweHg3dEJUQlNEbzh2dm9LTG10aGgvQWRCMjluL1poam9scmpqMnZT?=
 =?utf-8?B?NkhzZi9SMlRRVitCb2hvQ29uNnNESHZFSndUZ25aYzRwZVFGYU51eHJPb3Rn?=
 =?utf-8?B?cHpiNUMzMlJQRXFUMWFFcW5WVzZ3eVdFSm80WkE3Z1BhVmc4dkRXL1FXWkdu?=
 =?utf-8?B?OENacWJTQkg0WFZYNTQ2NWJORUg1VDRxSHZCVU8zUmpud0Rrd0ZpODd4K0g4?=
 =?utf-8?B?SGltZ2pGeTFRaUhuK0w0MXAwWWtvNmljK3dBQitUSjNxdVdUSnF5OVZoaHlT?=
 =?utf-8?B?Z0E2YjhEMDJSSnVGZ005c1BTNGl2TnhNMzVtWlp0OC8xZGZTUEJCeUgxc1d0?=
 =?utf-8?B?MGNuWFNPWkVVeFNHcjlOT3FHeVBhQUF4QlpEYit3ai9rL1AyT29HZEpRM0Rn?=
 =?utf-8?B?ZGZlcENrdk1yUDNQeFRxNUxtYnU4eklqaXJ2ZEpqSmNkSFgwbUZ5VGltN1BQ?=
 =?utf-8?B?UUFGUjlSdXhNRHZZUkZ5clExZzhYdFlZLzJLakd2NHoyU0kyMHE5SHM1VEta?=
 =?utf-8?B?d3hyWGdHRVVscFdBVEh2eUx5YnhhT1lUNTVBR0pjQmhzSjNEVUVlVTYwMXdn?=
 =?utf-8?B?c0ErVlJSQzlaa01XSUg5NlBlRFN4bUJzQkJjQTBzYnpFRG55dmtzdkpQbmVI?=
 =?utf-8?B?R2x1RzhKNnJjVTJqNEg3Qk5NSUNwOTBmQjI0aDRCSzRORVRmZTZjSFZyMyta?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BEFEB3DEADF1045B7BCA035CC34E9BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc12182-4fd4-40fd-d995-08dbc44c6715
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 20:07:42.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dxrr0r8Kwhx7fbwxU8uAD98T1qAeNlGYTil1RkE0Ewnh5sgLG7xDR9oO1d+FK8Erm9Hao2a0TCuKSaOxPYbiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
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

T24gVHVlLCAyMDIzLTEwLTAzIGF0IDAxOjQ1IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
ID4gDQo+ID4gQnR3LCBwcm9iYWJseSBhIGR1bWIgcXVlc3Rpb246DQo+ID4gDQo+ID4gVGhlb3Jl
dGljYWxseSBpZiB5b3Ugb25seSBuZWVkIHRvIGZpbmQgYSB2aWN0aW0gZW5jbGF2ZSB5b3UgZG9u
J3QgbmVlZMKgIA0KPiA+IHRvIHB1dCBWQQ0KPiA+IHBhZ2VzIHRvIHRoZSB1bnJlY2xhaW1hYmxl
IGxpc3QsIGJlY2F1c2UgdGhvc2UgVkEgcGFnZXMgd2lsbCBiZSBmcmVlZMKgIA0KPiA+IGFueXdh
eQ0KPiA+IHdoZW4gZW5jbGF2ZSBpcyBraWxsZWQuwqAgU28ga2VlcGluZyBWQSBwYWdlcyBpbiB0
aGUgbGlzdCBpcyBmb3LCoCANCj4gPiBhY2NvdW50aW5nIGFsbA0KPiA+IHRoZSBwYWdlcyB0aGF0
IHRoZSBjZ3JvdXAgaXMgaGF2aW5nPw0KPiANCj4gWWVzIGJhc2ljYWxseSB0cmFja2luZyB0aGVt
IGluIGNncm91cHMgYXMgdGhleSBhcmUgYWxsb2NhdGVkLg0KPiANCj4gVkFzIGFuZCBTRUNTIG1h
eSBhbHNvIGNvbWUgYW5kIGdvIGFzIHN3YXBwaW5nL3Vuc3dhcHBpbmcgaGFwcGVucy4gQnV0IGlm
IGHCoCANCj4gY2dyb3VwIGlzIE9PTSwgYW5kIGFsbCByZWNsYWltYWJsZXMgYXJlIGdvbmUgKHN3
YXBwZWQgb3V0KSwgaXQnZCBoYXZlIHRvwqAgDQo+IHJlY2xhaW0gVkFzL1NFQ3MgaW4gdGhlIHNh
bWUgY2dyb3VwIHN0YXJ0aW5nIGZyb20gdGhlIGZyb250IG9mIHRoZSBMUlXCoCANCj4gbGlzdC4g
VG8gcmVjbGFpbSBhIFZBL1NFQ1MsIGl0IGlkZW50aWZpZXMgdGhlIGVuY2xhdmUgZnJvbSB0aGUg
b3duZXIgb2bCoCANCj4gdGhlIFZBL1NFQ1MgcGFnZSBhbmQga2lsbHMgaXQsIGFzIGtpbGxpbmcg
ZW5jbGF2ZSBpcyB0aGUgb25seSB3YXkgdG/CoCANCj4gcmVjbGFpbSBWQS9TRUNTIHBhZ2VzLg0K
DQpUbyBraWxsIGVuY2xhdmUgeW91IGp1c3QgbmVlZCB0byB0cmFjayBTRUNTIGluICB0aGUgdW5y
ZWNsYWltYWJsZSBsaXN0LiDCoA0KDQpPbmx5IHdoZW4geW91IHdhbnQgdG8gYWNjb3VudCB0aGUg
dG90YWwgRVBDIHBhZ2VzIHZpYSBzb21lIGxpc3QgeW91IF9wcm9iYWJseV8NCm5lZWQgdG8gdHJh
Y2sgVkEgYXMgd2VsbC4gIEJ1dCBJIGFtIG5vdCBxdWl0ZSBzdXJlIGFib3V0IHRoaXMgZWl0aGVy
Lg0K
