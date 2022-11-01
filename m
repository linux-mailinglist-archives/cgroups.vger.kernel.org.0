Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8F61502E
	for <lists+cgroups@lfdr.de>; Tue,  1 Nov 2022 18:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKARMD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 13:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiKARLm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 13:11:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AD91D67A
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322685; x=1698858685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NBRa5mZ4uMC7rNYE6MB9Zy2fcq4NhTVnlI+sf4/ZXuo=;
  b=kgrXqDIeHbpKllKXBmj95dLv3fNdjUg+SfEP/nMUaVgZJ4cmLvR1ooGO
   /8GweiGjfcrJ44pQ8MkhpLPYSJbWnUb0bxK02rui7u/GAE32D/+mE+n/t
   mOPoIr8QZvJ0zHCD952NskAZwl4h0q/HGH1UlXcFsHyAsfIxS7CeGL8pi
   Un+YXOmB/Fa0pGxPNPP2kPNHbjE4l/R2gb8cZFOc+5ktmjhW9jHe/TypF
   90BLSu8PhWw0EW/9VsAe71+iGuW7DJRsaZ/PJ1T9RpLJNcjkB79ARqouH
   uQOLibc+MFAM0w6QpDYBxGpM/f+LnMmwMlEqDDuFptH6ZE7FPk4Sr71ve
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310287557"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310287557"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="611913653"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="611913653"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 01 Nov 2022 10:11:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 10:11:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 10:11:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 10:11:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsH1op6WTcPe55u/tHux3Gqy3lqQ8N6xOkQajbsg7dYdystNZ8se30qRH6VitwngWWYjvNDNJA2zcaFWVVBGBoCaV4zuxvmwrCOxvppSgtFmo+cFdw3kpzVXSCGj2CBVrbjMXFXksrZbW8+xe3LsUUXLHkvFSkAP4ih8Uk5/WVuCycyXlb0uuJtz3bCdjMxJXtBRbJuLOGMrfUWJC4nYSOvO+vCFBku/Wdq/Aic1wpd+0FkVYKjA6/vesiYwSIk97/kyNXWieyEN6biS044g1LQIlknL4GgAyh4aKX+o3P8q5l8rukvEEEHPLKfqM/kooiEGFTSSORyQaNk/woGNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBRa5mZ4uMC7rNYE6MB9Zy2fcq4NhTVnlI+sf4/ZXuo=;
 b=alwRwdj4oLpGIV2u7G1gStcc0bXMYFUi0cwtOIcONCOqEKdhsTta7i72TY+RsR35UL/NXTuiNWsrAvxHELyFwbusDo2NkhiCHROS1Ea86GFTeyqGv2I92xzOANQ4aKA2xStSEh4bG9bsxF3N/4Ou4XyOyxMHgGbGlsDs/kzw/zxK/Gzb8BTSBjeIo3P2ZoOYSwd9//SUEFsFKRz4ecauxB2mQ3Ofbg3dGlEJsRoEbxnn3azADrapQS+vwyCQ01xAPNw8/YcZ3pJl136NXiAGgOZV0YF/4O+a+URT6O5dX2M8yWN2icmDiyXiVUc8GRinIVBpPmagRCClHI/0C8cZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 17:11:13 +0000
Received: from SJ0PR11MB5069.namprd11.prod.outlook.com
 ([fe80::281b:86da:352a:a5f9]) by SJ0PR11MB5069.namprd11.prod.outlook.com
 ([fe80::281b:86da:352a:a5f9%5]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 17:11:13 +0000
From:   "Accardi, Kristen C" <kristen.c.accardi@intel.com>
To:     "tj@kernel.org" <tj@kernel.org>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: clarification about misc controller and capacity vs. max
Thread-Topic: clarification about misc controller and capacity vs. max
Thread-Index: AQHY7hCiGzLqKkC6K0ayKj3a6Ooztq4qSRsAgAACdoCAAACqgIAAAYeA
Date:   Tue, 1 Nov 2022 17:11:13 +0000
Message-ID: <f678f325b47ac64e101c0ccea54c1cd1c4ea4206.camel@intel.com>
References: <2f7b7d6b10bdcbc9a73ea449d3636575124afa25.camel@intel.com>
         <Y2FPSqOaQGnISvXu@slm.duckdns.org>
         <14c21f13ebbcdbd0ea4f75b7fff790b31a05a5aa.camel@intel.com>
         <Y2FR6SYazbxyK5nj@slm.duckdns.org>
In-Reply-To: <Y2FR6SYazbxyK5nj@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5069:EE_|CO1PR11MB5041:EE_
x-ms-office365-filtering-correlation-id: 69946b33-7415-4f01-1d82-08dabc2c148c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hsi7TRUtGEMsFZCHVfPulhzTUH8lSkzNyVkgANp9twuP9AlTDFBjyh7vnGYfXxoeddrH+PvC+WjOeR2FICVEI6jkegkt0UN5b7nujLYGV1DAqtw7z3MC62nd0RAYfkaOUFPncuFlyA2ACWv7KWvlwcNC9ldne1QUYupLwfeV/LmrTeVRo/Q0krjxZAZL6BZlBLjfbCKBfzSI3QWa/dRkXid0lf1n9Gb7X6hKd5BdBori64f7IhvrkbRHDt+J3Pr6AXQ1XLEzmClDx4dwQSjUxfKQyvLenF6J8JVoEqZiHySInRtns/jM5jHn0PpahQWpPFeaAAH1xMyWfgj4SX4NRjn2AhU9vlzlbludbUzXpOGPtRlya3gTG2+YjxNp2Mmiw5QNuYh1bctr4naYuTuVVjxj9kz8Ogy/XGeWFrVYSkCKLG35zSpYPvrCTF7DegeR6w6Is4tPPIjcFBG1FNCSFMaDlnyR6kIyq6TTcyhyXS6frMb+sOH9HIenuTgU2/8osvJ47E63zDrhqyzz9tNJv6XF0NBBewRiJ6/MCfTpeeGuGt4zvcLhqZ+1zqc0JlsPXX4CXiD6ZI7BjIEfsAQfa9Jkgmwn2u9mgMwNAWbuSVWUM2GQgvCu16nTQ6nUK0kUOqMXE3uU4IK1wjE4YnvUaucErJAD5R9e7Yq0VJ0k6qb6C2e32yAv3KLl8ir+8wfL8HYm4nCUmNg6i/d6Y9YS/67IBXUpuTWAKt3k4bAx3mxW8+mFMesSA9DRHN00Fl4pRz7aJUJwK78u9ZC16mRtZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5069.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(2616005)(64756008)(66556008)(66476007)(66946007)(66446008)(6916009)(4326008)(76116006)(38070700005)(8676002)(316002)(8936002)(6512007)(36756003)(4744005)(54906003)(26005)(5660300002)(86362001)(6506007)(6486002)(186003)(41300700001)(66899015)(71200400001)(38100700002)(83380400001)(2906002)(82960400001)(122000001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk9wMkF3U2p6VTlVOUMzbWw0eFlEdE50UEo5ckREMUl4ZVFpZDZMN1RMN2s5?=
 =?utf-8?B?a2FEVElWa0svTEZVRnhSc3ZkNHlwVmZwVm0rNVRiUnZtclF6eDJJOW5Ua2VR?=
 =?utf-8?B?VlE3NStsYS9GZHF5QmZrditBZ2pJbkNrNHVKOWRkZWMvVHMvR0E5TnpaN3lv?=
 =?utf-8?B?dWpJRHByanh4cjZDRm91TTdNWEJiS0Y0NllXMnV2WWEvclNhY2pHSXM5YXho?=
 =?utf-8?B?K2JaUEtLY0QrMFcxdVh6b1B4TUhPaVBaNGJzL0g1aFRsZVhGVjNFUnJVNU53?=
 =?utf-8?B?dE5sK3FSeWpySHBLNkVrVHJ3d1Btejk4YWxUV2xYMlNYVTlrRlpZcVg0NGNw?=
 =?utf-8?B?V1VMR3Z5WkhSVE90MElFUzR2Ti9IalB0a3JOaUpSRmV4TThqYnVwNjZIOUVG?=
 =?utf-8?B?SzdWTDRYSEF4UVdJcFZmQ1d2ei9JVHBTS2xkaFBwbjFDL2pZd09IRmc0V2t1?=
 =?utf-8?B?QnR5ejdxdXpjV1RqS2JwaE9kQWdXNHJHR3JiZzFhWkl3ZHRYTFVFZmNyb3dF?=
 =?utf-8?B?dlp1ZFk3d0dUcmNKTEhJVEUzUUZjcVdqbHJiak85QUFBeHhaNWhxaVErM0xJ?=
 =?utf-8?B?am1DSXhoSjZFVTVUK3MrM1JuQ0dUQmhqeFA5dVlDMERHbVlmOERZR3lVRnpi?=
 =?utf-8?B?Z1U5UlhaOExIcnpXMHpoaG96aXN5RDBSY1NKelBIdHd1RElxbGQwRm0vTWp0?=
 =?utf-8?B?QktIRDlrcCthSXAvTG0wRzEreDkrR2Mza1Z6SDFwbmJjT3ZtbXFPNHIwSGc2?=
 =?utf-8?B?YXZlYTYwK20rSGRhQnZhbkh4Ym04SnFCV2hqSm9kVEZBQ1FHOEp1NEpWdHpl?=
 =?utf-8?B?TytvTmRkcDZUSFN2UmMvVnVkZkdWcTRBa2hVTUM5QU5ESEdWOVkzUDYzUlFT?=
 =?utf-8?B?L0Irc3VtZ2J2Vjl3OUtpQlVqKzFVbEQxbTJ6Rjl4TERMbmYwRUdoQ1g3enNI?=
 =?utf-8?B?dWw0RWFPc2lvL2ZDb2NzUUJuRStMRS9oN0ljZ1EyNVNSakRmOUNwbk04V1dJ?=
 =?utf-8?B?b2hiUDlwL0k4YXlFYnh6cjd3WFJwbVFONFhFbFJmVnczU0JrbHUwOXZUaHQ0?=
 =?utf-8?B?YnpUSUIvcHpnL0hEaXlZbmhhNHpSM3hqSFZjNVN4OTAwWEZSTzRvYzdNZDZL?=
 =?utf-8?B?ZXgwTzFnTHZsaGRqbnRIR0xvVElRS3FiRXdNU0RrS1d1bVlRbXVpTndvV0FW?=
 =?utf-8?B?RnNQcUJtejViZDZBUHk2RExnN1JTMXp2cGVHQW5yU0M5VFlCMytSWS9SWlNO?=
 =?utf-8?B?L3V4VFJWRkdUVno5RlZEdXRpZkxYU3p3dWc3MTdVRE9NaStSVWFvTTI2Ykdu?=
 =?utf-8?B?dm1aVWFyYXI3aHVuMXRZVGdsS0dER3hJbmFvbTU3TDY0WWZEd0ZJb01RaXls?=
 =?utf-8?B?RkNDdWROTWFBSXdyTWo2WXQxMzhnQUs1c09US3hERjNjRmltcW5MTXlBb2V1?=
 =?utf-8?B?VWRmSC9LNUMxTk9UMGNaVm91TXMybTMvVjE2dXI3TmIrVTZaWnBqODRjcUx3?=
 =?utf-8?B?ejErUHNkOERBa2hPWlMxdThLaXJHa1piYzRlbGR2bEZ2Uk5kZ3dYQ3NNbG94?=
 =?utf-8?B?QWNaaGt2WEVONTFkM1dMNmJETEU2SGpnQWcvTEJ0R1VIK2lnYjY0Wk04cElK?=
 =?utf-8?B?Y1pCZ2gwYlBQN21melBoQzdjK0FlQnVnUUdBeDdlNHB0eTkwVTVHdDNRUmRh?=
 =?utf-8?B?d0wzR2h2VHFlem5VVURuN3JYak1UNmRUUGhtZVoyUlY4M3JSaDVoWFNJb1Bx?=
 =?utf-8?B?ZGgzejFwMHJvRHR3YjQ4VlV4aXBJRnlYUDYwRjNobWJWeEtCSnJ6T1ppT2xy?=
 =?utf-8?B?TVFTdDl2NnNpN2ViM0xnNGRpZ2Fka1htZW1iSlZES0g3TmNkaTNxS2VIN0lo?=
 =?utf-8?B?cEVFK3FZS09FazI4Y2h2dzNKeEJRdGhyUUJoNGc3bnIzYzYzaDAxUUw1Nmpn?=
 =?utf-8?B?MFNaYzdvVW5WYmlrU2NnSm9ibnJ4MExTT20vaGZzWWRhZmQ1WEI5SjloanMy?=
 =?utf-8?B?VkdDUzJwaStQYlFpZzVBV2JRakk2VDBRZ0g1Q3VURkNkWjNXOVhsb1EyZGVG?=
 =?utf-8?B?K3V3bmxTajlmOCsyMWdNQ2NaNW5pQVJ1UHJoMUgxT0h5aElJWElyTEFQTlYy?=
 =?utf-8?B?OVlKRzNFcVliVjliSTY4YkUxRFEvUVg0MXZRUEFoa05mMXcxVzBSUStiaEpH?=
 =?utf-8?Q?m8mpTpftl9hUdvPC7ka7yLk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1BC5F3B7EA61547B0CC6750064736BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5069.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69946b33-7415-4f01-1d82-08dabc2c148c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 17:11:13.5343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mP6E43vS8GMy8gKNoWwbWrH6yZKBTy4Tb83exA5NZfxXdp6/+ICpcmnZ/+tH4HMnCbHWqyoiXPll7Ip7pAeM32ggDbVsMehoztc+40YEPxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTAxIGF0IDA3OjA1IC0xMDAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBPbiBUdWUsIE5vdiAwMSwgMjAyMiBhdCAwNTowMzoyNVBNICswMDAwLCBBY2NhcmRpLCBLcmlz
dGVuIEMgd3JvdGU6DQo+ID4gU28gdG8gYmUgY2xlYXIsIGlmIEkgaGF2ZSB0aGlzOg0KPiA+IA0K
PiA+IC9zeXMvZnMvY2dyb3VwL21pc2MuY2FwYWNpdHkNCj4gPiBzb21lX3JlcyAxMA0KPiA+IA0K
PiA+IGFuZCB0aGlzOg0KPiA+IC9zeXMvZnMvY2dyb3VwL3Rlc3QNCj4gPiANCj4gPiB0ZXN0LmN1
cnJlbnQgd2lsbCBuZXZlciBiZSBhbGxvd2VkIHRvIGV4Y2VlZCAxMC4NCj4gDQo+IFllcywgYnV0
IHRlc3QubWF4IGNhbiBiZSB3aGF0ZXZlci4gU28sIHRoZSByZXNvdXJjZXMgdGhlbXNlbHZlcyBj
YW4ndA0KPiBiZQ0KPiBvdmVyLWNvbW1pdHRlZC4gVGhlIG1heCBsaW1pdHMgKGllLiB0aGUgcHJv
bWlzZXMpIGNhbiBiZS4NCj4gDQo+IFRoYW5rcy4NCj4gDQoNClRoaXMgaXMgYSBiaXQgb2YgYSBk
ZWFsIGJyZWFrZXIgZm9yIHRoZSB1c2Ugb2YgdGhlIG1pc2MgY29udHJvbGxlciBmb3INClNHWCBF
UEMgbWVtb3J5IC0gd2UgYWxsb3cgb3ZlcmNvbW1pdCBvZiB0aGUgcGh5c2ljYWwgRVBDIG1lbW9y
eSBhcyB3ZQ0KaGF2ZSBiYWNraW5nIFJBTSB0aGF0IGlzIHVzZWQgdG8gc3dhcC4gV291bGQgeW91
IGJlIGFtZW5hYmxlIHRvIGhhdmluZw0KYSBmbGFnIHRvIGlnbm9yZSB0aGUgdG90YWwgY2FwYWNp
dHkgdmFsdWUgYW5kIGFsbG93IGZvciBvdmVyY29tbWl0IG9mDQp0aGUgcmVzb3VyY2U/IElmIG5v
dCBJIGZlZWwgbGlrZSB3ZSBkb24ndCBoYXZlIGEgY2hvaWNlIGJ1dCB0byBjcmVhdGUgYQ0KbmV3
IGNvbnRyb2xsZXIuDQoNCg0K
