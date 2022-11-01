Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD60C614F8E
	for <lists+cgroups@lfdr.de>; Tue,  1 Nov 2022 17:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKAQkn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiKAQkc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 12:40:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC921B2D
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667320825; x=1698856825;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=sM0CAe0h1xIfZR6B5nhj2Lu5/wz/p1dk+jzqRAKMtFE=;
  b=YkHKdVSUk0Zjlaag1XxHYNNaZJcbwd624HgHZlB4U2Z0DSHgfKXZwYHm
   FQldaPbhdlM6ZG6pEwSSwMGCVYLckl7bZfTvYiSoQwBJZxAdqsCiGEvX0
   bHWIxmYBWMYLojlL45FhTCqB92P6xvHc9nVTkVm1epWS09Hn0JIp61KHS
   u6Cp+oozAx0bCJDUYhCEh4tX6GcM3CbT2PGNNdC90wWUBaLXa3WgNY3oH
   oz+OozAidJjHI66sDBWt8puIs6eNFVeuZmgsc9/m2cfTJaRsZl5IIAWTW
   ytF529svrNkoc2D7K9wOAV08JgfonJjnQMVldIkezTF5fSdmkxeY2Lmpk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="306800155"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="306800155"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 09:40:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="702935331"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="702935331"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2022 09:40:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 09:40:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 09:40:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 09:40:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOg5DvLo7rVhAC7+X3eECFRikCOBG9fDW0BZZvgjLymbfhhGfWd/iwFL7KTCKb1OFdX2a7RP/iMzKDLRhPgFhc11E+LiKOUzI5Y5POu9ZCWkA5qv6+uphhdK2fVWkeN3oYy9r9eRtwmujJp07G09M3DDZxUkZdEhoXjorraKliroVUdLBnHtV7vW4gYWdvkXwRXXL4KmQ7stmVxISpOyCFTnbywQsX11kWx+7C2tovCWvTcb4JKoluLrLrwEGUMGCttEIYst9dVU1fdCJPKSgyO1Pvw5nI+qblzjTNHVyYbAsF/bemn+vLAUwLtHNaxq5xNUPCK+2TjQgiSDSBYvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM0CAe0h1xIfZR6B5nhj2Lu5/wz/p1dk+jzqRAKMtFE=;
 b=E+fWd1jaz4gUQgSKeIFz5ul5ykMLXL16XyHIM7tNpRpoCiugXTvGaws/WgSMpXA1oogNI5m+7cvTn8UkvwS4szYRfiJ2WbP9vlBbhLiWxVdttFk8WdwFg1AqqvYaZXpa9qSe37q1AMcYdN5GRTH4d6DsbWadGZLGXlHg4juxMAgiLFgTGIhlxTTXhf1SARqR9LTVOqWokeMg/JaBSHBflKuFHpE4cBmpbVNZexSgNtRFOFTF6JTcbFlxCg+vcy3irOb4GwzuoP9otlYL5g4r4XNNOADYCgVHTCHNgvfoxJw9glx7+YDXjoPPDCEBWpa0bzm9M5icEfBSiPaPJUNBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6)
 by CO1PR11MB4899.namprd11.prod.outlook.com (2603:10b6:303:6e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 16:40:22 +0000
Received: from SJ0PR11MB5069.namprd11.prod.outlook.com
 ([fe80::281b:86da:352a:a5f9]) by SJ0PR11MB5069.namprd11.prod.outlook.com
 ([fe80::281b:86da:352a:a5f9%5]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 16:40:22 +0000
From:   "Accardi, Kristen C" <kristen.c.accardi@intel.com>
To:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: clarification about misc controller and capacity vs. max
Thread-Topic: clarification about misc controller and capacity vs. max
Thread-Index: AQHY7hCiGzLqKkC6K0ayKj3a6Ooztg==
Date:   Tue, 1 Nov 2022 16:40:22 +0000
Message-ID: <2f7b7d6b10bdcbc9a73ea449d3636575124afa25.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5069:EE_|CO1PR11MB4899:EE_
x-ms-office365-filtering-correlation-id: dc394063-68dc-4c14-0965-08dabc27c52b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGd7QR6m44PzLBrivHKuZ13is5I6wNyHYIaEc7eC4Nm5z/XGSBr/6ugWt6F0kg+0Hs2wGzQXxH6NUctJMrwo8/WNaqcq9FIFqWdAnIm6XVMzXatCiq4B583U/2S0CMcrOyjtCW33Bl3eRkln+1hBzsUEaWwRvsrQuxcExkvvrWcZzVAziT+MAAvK5bRX1+Xb7+7JEIDvCYTD5RSkme24X95CNEz9laMLanQHntS80lraQrp0gY5bEUKQXbrnNjBLsp6rsFLkpAl5Q0ooJpHUDyCGgDeIuTdn8zi84RsqGz9CnIxz8x9fIQ/9chtLqIInccLX5UtOCV73noe/kTH6CzEbOnO1w832sft8rV+fpCcz8ztXSNk81euPZuYsRu3C39KXvGJiHTan88Haoxc0ccVCt5/9OArxGx15MbGfpxbamhNshVR/ArTg5qI6RkapjhmK8kQSDOzyWgIwqKRDoh9003d0aG9coxdecd1qXU7HMzvO/Ty5UNoo70qCXrqhP31w7xSulgqmAAG6LqYCxnZUN6W8zd5k/w0rNZPZA3BJgGETtkOeKRaUfmSOD1KkdD0NH7CcSaeXL2V2Lei3cmHo3LwYuZC2HgKYwV4RtykhyXp/VIMggtC/A/6FBkaEUg5Zul5MiQA3B7SggICB+lzyuI+hNMOGnoBEfeXqsSdViidF/p0iin4NDVYdXglU0SawOEbm90gHFYnEVnyK9d90RBafXjD0Ko5O8jWmr1KOtBSF1WjPq0LdVGbu96A2ueh18qp1DUj4SmwxHNC/wuVM1zGul9F3qemE+610Tj4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5069.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(2616005)(186003)(26005)(6512007)(66946007)(478600001)(6506007)(4744005)(83380400001)(2906002)(316002)(110136005)(71200400001)(8676002)(66446008)(8936002)(6486002)(66556008)(5660300002)(76116006)(64756008)(66476007)(41300700001)(86362001)(36756003)(38100700002)(122000001)(82960400001)(38070700005)(151413002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFMyTVNwWEw5TnREUVZYa3FNNFErb3h5bnBDaTJEYzVicjBpVEhWRXREaTln?=
 =?utf-8?B?dmdrKzg5RWZueFdzVU16MHdlL1VoNENZY2ROWEd1dXBLVGNpTE5MMmRmQzVm?=
 =?utf-8?B?bTV2UlpFR2NTU08wSFNSRDZPUXlod3hCM0VnT0U4dnYvUERORkxaMCt1RWY2?=
 =?utf-8?B?ejFxZmUyckx5MHo2WWRDdzlMK2ZBZzRjVGZPOUhLRkNwb3dtSVVjUjRQV2tO?=
 =?utf-8?B?dXY5Y0dtbUZtTi93ZzNSRGd5UHlXQlBQZDNmOUdTa0hxUUZwQWgvLzIvT0Va?=
 =?utf-8?B?OWovNFQ0NkJ6bCsyWVdmOHF5aGpla3Q4TXdVNGZKanZsckN1SzdmMHpnb2lG?=
 =?utf-8?B?V085VEEyeUd6UFdhZnh3SXMvZXlnVFY0dzl5ZTVyYTgrNW9sVUtDMzc2RFR6?=
 =?utf-8?B?dVVDbWgyZzlLZ2hsMUhpOFJ6VGovaUpMYml3TUxoTC9KMmJtWDhUS2pxUldh?=
 =?utf-8?B?UnV2a1VsL1YvUkRLTmVUN2F3K21IZWxLOFJqTi9uQ293Unkzci92UEh3Z3pq?=
 =?utf-8?B?eGRNR1Rmc3hCc21CVWRtYndwRDhzclJhUWhydnRDNUZMMG84VWpnTzVzZXFJ?=
 =?utf-8?B?Z3NUSFpkcXlPZVQ2UW4ra0pvU09sVklGYldmekFzd3gyZjFkZWs2bGtzcTFa?=
 =?utf-8?B?K25RRnJSTG8rVVVSMjFtenFCWW1OS2ZJMTc3MWNXOGJvOHN6bzZ4MjBWd0gw?=
 =?utf-8?B?MStsQ2psWjRiSjhLS3RWa2FYRkxxL0FzOU96d1d3c1F1VU1jd1VvMm02eUxW?=
 =?utf-8?B?b011K1V5OTYxQjViK0Z1QzFkU0hRc1FrVTZKcHIrZFUxbUMwRG5NV0N3YmFz?=
 =?utf-8?B?V2tXTmhGbVpFYVVKNFV4dXNabFB5VEVtVmFZVys1QVpmUmNGVFEzRktjK0RH?=
 =?utf-8?B?eDRxa0F2MGNxL05WdXVWbFNOcDErVXl2eVBuZTdTZTY3MXpYa1o3QVJPdkFH?=
 =?utf-8?B?cmxPaW9FR244a2M3TU9KWU9PS1EyL0k1ZTVTZ29yUkhoR2lURkZJeUdhZ25I?=
 =?utf-8?B?M3RrZEhiSS9pYVFxNit5U0NPODh4TVFmK3lNc1lySEhucEJCZk0wZU9mRC8z?=
 =?utf-8?B?c1EyeEFXVVhFTzdTNElkRldWODV2dTF6eFE4RTl4SlJKRXZTa0czNjlMNzNo?=
 =?utf-8?B?UmwzcWRucWw3YVBsaXBueWZuMFZhQy9yVlpkWE1YbUVnQ2JURCs2ck9EWnBH?=
 =?utf-8?B?VG9UYjJwR20wcnNwNDRPbkNTMGF5UHdZQTFWSEY3alg5b3haYitaZVZVMGpV?=
 =?utf-8?B?TUNKWVlJajBKMzdSYVZqZjkwbXUyTUZ2Kzc5YTdQYnVsQW8waVRtVXpMVENt?=
 =?utf-8?B?cUgzUHl5MmV0YnluWnBaVnZVQTZONTBzcXg0YXBtdnpOWC9NRGhyQnRzbWFG?=
 =?utf-8?B?am5rWUt0d09CNU5FYTBHVldrQ3BzUUkyMlU4YzYraGFmbFk1aVBlZFMzaEZm?=
 =?utf-8?B?L3praDJqbFFEbnpOeElWUFJTeWFBUHR5aW5vZXdIN3gvV3lkOWsrOHpUUWxE?=
 =?utf-8?B?VFhlcTNabXVIV3U0dHRaOW1wYWRzZytzZDhJdjVyS1NtZG4xK0luelpnTi9u?=
 =?utf-8?B?Nm1CaVRpeWFOZmlUSG5XRjNueFg0TGxMQU1HVk5qR05HZ0pycHFGZWd6QVFX?=
 =?utf-8?B?MzBBY0FwYlNqZWlyYmFkNVdGMXJNekUzbVNob0Y5bHNtVHp4VTB2Sy9oVEN4?=
 =?utf-8?B?M2sxaHg1MndQWWNjbmZWTkFRSWVRQk1Lb0tzZERBK25obkwwRFJzSVhGMFB1?=
 =?utf-8?B?b3RDWVVpZ29GbDZvdTVrWXFyUkZ2TThLUXFueTdQY0JZUWNFbkRFc0p3anp0?=
 =?utf-8?B?QXQvbkVVazJJY0ErUFQ2MHNadDdrQW56dk5pNEMzdUwwbDZvdWphZ05QRE5H?=
 =?utf-8?B?Y2lwUVhsQVlHNmlpSFJMangwYlkyUkU1dm5TdzVkcHVZd0FXdmp3UlpKd1BP?=
 =?utf-8?B?N0RGMUpTRnl0ZGpacVZLUk1tcDh3TE5xUXBVQVg1UDlKLzZrU1N0a3M0UlVv?=
 =?utf-8?B?UW1BYWhpWEI0blpiLzZNQXlJM2ZNSGc1YlZvV3R1TDZxT05ZZUc5T2xoOWdO?=
 =?utf-8?B?eWphWmM2d2hma0pna0R6am5YMHAzbnczSWdMSi90Si9GVGp6WmEzd0k3Nzdk?=
 =?utf-8?B?YmJzUXFWazBDY2tidk50QmJMUGRYblNzbU5wWStOalk1Q2VneW4wVUxFZEs0?=
 =?utf-8?Q?u4NC1D3EGmVAPXPPwotVTGQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64FF881EB77A744184D02C8D12B917E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5069.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc394063-68dc-4c14-0965-08dabc27c52b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 16:40:22.3556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvNw3LCdKaRt/OoW1Z7UUlH/2/ktfRdXwgU29MmqvDzqDDy/uBlv02YD/g0HEoGuaq/rhCQeS+pq2fqb/oBik4v6NZwTVpFPc6tOrwJ9mOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4899
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGkgdGhlcmUsDQpJIG5vdGljZSBpbiB0aGUgY29tbWVudHMgZm9yIHRoZSBtaXNjIGNvbnRyb2xs
ZXIgaXQgaXMgc3RhdGVkIHRoYXQgdGhlDQptYXggbGltaXQgY2FuIGJlIG1vcmUgdGhhbiBhY3R1
YWwgdG90YWwgY2FwYWNpdHksIG1lYW5pbmcgdGhhdCB3ZSBjYW4NCm92ZXJjb21taXQgd2l0aCB0
aGUgcmVzb3VyY2UgY29udHJvbGxlZCBieSB0aGUgbWlzYyBjb250cm9sbGVyLg0KSG93ZXZlciwg
aW4gdGhlIG1pc2NfY2dfdHJ5X2NoYXJnZSgpIGNvZGUsIHRoZSBmdW5jdGlvbiB3aWxsIHJldHVy
biAtDQpFQlVTWSBpZiBtYXggbGltaXQgd2lsbCBiZSBjcm9zc2VkIG9yIHRvdGFsIHVzYWdlIHdp
bGwgYmUgbW9yZSB0aGFuIHRoZQ0KY2FwYWNpdHksIHdoaWNoIHdvdWxkIHNlZW0gdG8gZW5mb3Jj
ZSB0b3RhbCBjYXBhY2l0eSBhcyBhbiB1cHBlciBsaW1pdA0KaW4gYWRkaXRpb24gdG8gbWF4IGFu
ZCBub3QgYWxsb3cgZm9yIG92ZXJjb21taXQuIENhbiB5b3UgcHJvdmlkZSBzb21lDQpjbGFyaXR5
IG9uIHdoZXRoZXIgdGhlIHJlc291cmNlIGNvbnN1bXB0aW9uIG1vZGVsIGZvciB0aGUgbWlzYw0K
Y29udHJvbGxlciBzaG91bGQgYWxsb3cgZm9yIG92ZXJjb21taXQ/DQoNClRoYW5rcywNCktyaXN0
ZW4gQWNjYXJkaQ0KDQo=
