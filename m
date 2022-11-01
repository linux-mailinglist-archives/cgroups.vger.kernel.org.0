Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA5614FF4
	for <lists+cgroups@lfdr.de>; Tue,  1 Nov 2022 18:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiKARDj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 13:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiKARDe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 13:03:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E605730C
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 10:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322208; x=1698858208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gisOpu+6fJfgCJjwCNI9y3/gdC3vw9tIkfD5zzbh8FI=;
  b=DgLnE7HucIGpOmR9w6hPfDtcCOyCJRvkMm7KkJYPNyTmW8Mzy/3AyouY
   aRReZr4WWGd43HkrPzru/3W3IguWorJ4yPcT+Ij9wslLbscSp+7Z1nwIy
   K97f93aJsFvsVnLU5EzW3Hilml46cWACI01M85YCSMNQxVz6/K//T4oy4
   l/JpgUfDr/wzV6GMxtsRH2hi4G3wuSVzb9exnGiIei8eKPpGN+pPYUm4c
   VCsNRhBLbQv9qZfvha+fIfi3OGti8bRoSSZvRg96kUBlWECrKMjE+IIvK
   Uz9+6UEZkUb+ifSRtBDthV27rRnU++y2jbCQjYsHdfqV7/ctEfFk7WI4p
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289577095"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="289577095"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="667260283"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="667260283"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 01 Nov 2022 10:03:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 10:03:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 10:03:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 1 Nov 2022 10:03:27 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 1 Nov 2022 10:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHzC12QPWybfk//QuomTZoZ0MadS52jsXNwDFGj1rITrd/gsFe6kmJspedv2LKjdNumlGl2aUHALoAeco5TcEwfsvKj2s2/Yb3KwPuI45gRF8ErkjOeWlkaugxFNo5d4DlGZrM2nZL8POexJKsJZ9yn2jRTzDnkLWIZ0kPjZahSDZUXVjv3qJ9MfF+Im+WfdaxRBbeXRuG3Oub7DQl2yjRpOBJRgOGDqi0TdZmBM/B7DsvCoi/HoH5w3gd0SFG/BUvsC3pKtOSit35esUEFKY9pFFnaY3Zx2ciI2fw5IraQMmA2xsE/+/5NBjlOJIXK0rcnm1/eeGFy1fOv22ZNwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gisOpu+6fJfgCJjwCNI9y3/gdC3vw9tIkfD5zzbh8FI=;
 b=mQJ+23XidMdQberXUyIyElw0aaWrVy3bmcvN5g2AUkFAFugF9NZytb8U6ucOlYVoXhoaUx9auwgsSY7Pa+i+ccofQx3TDYDEJdHQPc52X/m0vIhvtBXwTHTxsOUBQbzmRXptG4hNgRX+N6cpj3mU+L/VRT96rc58QNEaOT246NfSBimY2uRiW46/fB/8Xo4I/GVZTxcZgE9eZo/Opwss17qpG4QVpgYuPhLJwC1hln2R+s4Sv6ywejeMdwYO6/D+fJUxa5jv0rCDDQ4owmhVy426LruywGXLPtiVTs1GFz9GsQrA3Lave76BYWDv/AklDe2oiJp5nvWCQXqDO2DYhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6)
 by PH8PR11MB6729.namprd11.prod.outlook.com (2603:10b6:510:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 17:03:25 +0000
Received: from SJ0PR11MB5069.namprd11.prod.outlook.com
 ([fe80::281b:86da:352a:a5f9]) by SJ0PR11MB5069.namprd11.prod.outlook.com
 ([fe80::281b:86da:352a:a5f9%5]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 17:03:25 +0000
From:   "Accardi, Kristen C" <kristen.c.accardi@intel.com>
To:     "tj@kernel.org" <tj@kernel.org>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: clarification about misc controller and capacity vs. max
Thread-Topic: clarification about misc controller and capacity vs. max
Thread-Index: AQHY7hCiGzLqKkC6K0ayKj3a6Ooztq4qSRsAgAACdoA=
Date:   Tue, 1 Nov 2022 17:03:25 +0000
Message-ID: <14c21f13ebbcdbd0ea4f75b7fff790b31a05a5aa.camel@intel.com>
References: <2f7b7d6b10bdcbc9a73ea449d3636575124afa25.camel@intel.com>
         <Y2FPSqOaQGnISvXu@slm.duckdns.org>
In-Reply-To: <Y2FPSqOaQGnISvXu@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5069:EE_|PH8PR11MB6729:EE_
x-ms-office365-filtering-correlation-id: 0742ffb6-4dc7-466e-9472-08dabc2afd76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JtF5d+rHb652pEFLTNT8kifs3gmwypoPwWuo7HjsMacsOMftGvRf+0eBEV8uGBF595BEkMsroPo5lNiCg7jnL+jQ9CI1tx95olxi6uiUZvzVYI4TPF/40kri5jbZ1+U236YYU+gIQrMVd+W1lBJZdOk1ScAd4UG0acbDAK7C03UKCgujlrYT0hz3iG5qwOdrOPxR3xFyWL8Vnk/Fwa0i7pOPHwi6magzE5iLoxHm0b2xxKeF5o2tQYSJJt9qHULIcKuAfMoiI1CLuKxzT2Jf81C80l7slbJPzxYCjREqilrb22VUDqZnuVM4jVGeNIGgBZg3nT+n+p9sqD4j1AnBYUJsUCP43+eUWOyjKsnZrWA6IbAifonCiKOshMac+DXkMIvdHH1xWTEnxGz+p0ujKWGwy6BBB2tRVEtsL5Ysfaj8gWlP3IhRmxEji+ni0RV517iu3b/NnW7bP4lRMJk3yXpk+GQuP1N7x3MpBLmGWDZnU0n1cm1mkWmkwWPmcNNyd9FRi2oWBq7wR39At/A9shjVZNvxubVJ99hBRPpDRKJM6h2BYD7HCr0+Zaf6PX8rdvyo9VUNYfD88imDnsMELNuBDZo4dRpecmKQlpgOunUIvXVolBq+G73sV8l33zNtPceL7psuywJAMDYgXtVBGLoGUozzhdwG3NnbWqgKYVJkkLNN1hYDMKVmMjx73isXDDuXhVpUPxqQDRyZNGPZed3Kr8l3eiYOeaVnRNMtLCCBI7t8Xe0Nd8XYyel54CHJKgs11305sGKjByCBn7jug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5069.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199015)(6486002)(41300700001)(8936002)(478600001)(316002)(54906003)(5660300002)(66476007)(64756008)(66446008)(8676002)(66946007)(76116006)(66556008)(83380400001)(38070700005)(6916009)(6506007)(82960400001)(122000001)(38100700002)(6512007)(186003)(26005)(4326008)(86362001)(2616005)(71200400001)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnNZVFIrUldaUFZhN1MvaWYraVZuMys1U2M5QUxlaXpybXJrTVRKNkhtbmVn?=
 =?utf-8?B?WXZRN2hiRWR3Z1JQZEpRdzcxNW5GRCsxb2hSQVZHZzM4ZVhWYklCaXJQUWhQ?=
 =?utf-8?B?RUg1ZjRRZU1GM3FpR01tZlZmbXU1WXp2Q2lsdW1PUzZYMTVDSERkMnBqN081?=
 =?utf-8?B?RktqbXNsZlhDajA3TnpaUEZ6TUZFc1B6dEFBVVdqZEh3ZjlKSFI5WloxNlE1?=
 =?utf-8?B?bzYyM2NMRTlGQjEvKzFUQXFkTkFOeDNFM0VIVmNqMHZRb1FIdnltam9zR0dm?=
 =?utf-8?B?dHIzMnlCZHBEMU56aXFIZTlkMlNhWnRrWEVkQzRIQWI5SmlDMTR5WG0yVHpr?=
 =?utf-8?B?czRhd2lXRExCaTJ1Zzl3Wkh1YjJ1VDFxb1VEbmptc014alFzWDJrRHI1anMx?=
 =?utf-8?B?dnY3dTRUaHNiQldVdStOTmZ6bDBjbUhjbk0ySnZOdXZBb0ZmYTBGZlRVZ2V2?=
 =?utf-8?B?ZEtkYi9JQmhNOHJRdG9COTNLOURjUnhCUnllY2xIUkJmNXNOV3BHcElLUVRx?=
 =?utf-8?B?OEpwMDFReGNQS2lsS1crN3c2ZzBCeXNjV1ViUlJibzhSclp2Zi9GclhlMUhm?=
 =?utf-8?B?OUgzUGpML0czK203OEZZVTJ4dmVTZUVUbUU2a0YvbTRobnhxRUFkeXhuWXND?=
 =?utf-8?B?UG5YRDFYNnVSUzVsQXMxckpXY1RTSVhMdTZ5Q1hxYUhqbXUwUitLTU91NEVi?=
 =?utf-8?B?Nlo3dEtidVI0eE5ib3pjYjE3M09kVlptb0dsVWQvMWxUOWQ1YmV6UkNrOGdw?=
 =?utf-8?B?MUtTdUYyaTVhdHE2Vytta2xLY0tORDJ6ZWM4UTRzd2N1WDlleUdQUnlTYk1n?=
 =?utf-8?B?RXBSNUwyWXQ4SWZVY0J4QVNtS21wWEg0NmtMbnpnMW9pdUhoSXVyQ2dIeE9w?=
 =?utf-8?B?Z1ZwYWVUYlY4RE95Z0RsR2Y1U2JzNm5EdmpReWNkWEQ3NEdZVGxZZjZoRUhw?=
 =?utf-8?B?TEhXcWs3Z3hJd0sxak1DSVVyWXZKRFRweXF3TFJ5NUxKOWFXanp4Mk1lUW01?=
 =?utf-8?B?YmUwbDNpVXhqR2RYNGNxbTJnOTdadmFaNmVWMXNFMDJPVndBQVJpZGtOWSsr?=
 =?utf-8?B?Z0FCMnRrSkF0eWNqeFFoZ3hETnk5WDJyQ0oxMmJ4a0hDMTAyb0R3bU5vMXY5?=
 =?utf-8?B?dEthdEtzQnlwS2VnYk9oZXdKTmFxb2dJa3VDQTVxdGNIZjc3bTFzcERKaVho?=
 =?utf-8?B?VmVKakJZS3VqWUUvaTQ3NE4xL1pmODFmOGJIelRwVzNvdzdUbFZoMlp5eGdk?=
 =?utf-8?B?K25XeXRObWw1SGVqVysvYVYyVm04SHZFV2RWYndaOXBXUXVmak9kMXEyYStR?=
 =?utf-8?B?ejN2TXhrM21QRklKYlJ0WW4zVmJDdEtBc0YrTHFoUk5zRFBUQnlJdndmU0FS?=
 =?utf-8?B?dWtVNFN2WkxTbE5aTXV4b3pxaDFMT3M2V05ZeGlDeHNKQjc2bEo1ekc5NjA0?=
 =?utf-8?B?YzNLMFBkSlN0Mmc5VjRSN1AxMkJySlowQmVZSTA1dkNnSnpZbGJVdUg3bE0z?=
 =?utf-8?B?VExHY0dsbXVUVE9IWWM4WmFPMU14TFN2S3lVVE83Q1NyZHpBcm50NGFCdWdn?=
 =?utf-8?B?dTg3Ky9rblFVNkdKbHlwS0FISHFPOE0yaGx2WkZWamlGcE9HSXBJcmljdHJX?=
 =?utf-8?B?SVEwYUNBZkgxTGpReU4xTm92RU50WkVTbS9lRlZWblNCNStvLzVOMHRuTWVy?=
 =?utf-8?B?WGRBZWFIQkxMZk5xeFFXZElqR2V4NmFmbCt4YXFEV1d5MjJtc2M1YXBtWWw0?=
 =?utf-8?B?S2RkUjZHSDAvdzlWaU1uNjd4KzBBaWx3UTRDeTNCaVd5ZjZKUDVoQkk4ZHNW?=
 =?utf-8?B?TW1BSlgrd3FwcGFOcVlhdzhJS2lkQXMvWUZteTFiUy9vcWs1WlVva1h6M1BZ?=
 =?utf-8?B?a3NUWkRIdzBKNG9pVWRIamNBY1lmMDFzNGNmVXBibC9SZW5uMGpQTVZiMWhl?=
 =?utf-8?B?bVpJd3g3c2JlRC91bmczZUF4aTJNWTFncmNtSTNBRVRLczRSdWxwSUVhNnlS?=
 =?utf-8?B?K05yR3NRQlN5RXFoWm1sd3JTbDhEM1pMTWVROG9LeWNPKzZJdFB2YzR4dGJN?=
 =?utf-8?B?anR6MmZxeXdIQVQ5M0RLNmtaejVWeVRHWEF6cTlzSVdPMVpoSjhUQy9pQVdU?=
 =?utf-8?B?T1pNZTQwNG1UajJMYTdKczFWRytTVSszTnYzaHg4N1FSSmg0K2QxWHVFUXMr?=
 =?utf-8?Q?U1gGqGe7wi4wJeUjmnRtCr0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E1DD9176524D0418E4CF86D8D12F559@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5069.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0742ffb6-4dc7-466e-9472-08dabc2afd76
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 17:03:25.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2msYoOqe0mIUwZw0xhJBkoJ2lcEeduAaKzrhEwIBWB7xTIRTbQTu0WdguK9PyA2WI6H2TBny6Ldnvwpzq4wf11qpSxXtTgvj22dk7JgQ5YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6729
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTAxIGF0IDA2OjU0IC0xMDAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBIZWxsbywNCj4gDQo+IE9uIFR1ZSwgTm92IDAxLCAyMDIyIGF0IDA0OjQwOjIyUE0gKzAwMDAs
IEFjY2FyZGksIEtyaXN0ZW4gQyB3cm90ZToNCj4gPiBJIG5vdGljZSBpbiB0aGUgY29tbWVudHMg
Zm9yIHRoZSBtaXNjIGNvbnRyb2xsZXIgaXQgaXMgc3RhdGVkIHRoYXQNCj4gPiB0aGUNCj4gPiBt
YXggbGltaXQgY2FuIGJlIG1vcmUgdGhhbiBhY3R1YWwgdG90YWwgY2FwYWNpdHksIG1lYW5pbmcg
dGhhdCB3ZQ0KPiA+IGNhbg0KPiA+IG92ZXJjb21taXQgd2l0aCB0aGUgcmVzb3VyY2UgY29udHJv
bGxlZCBieSB0aGUgbWlzYyBjb250cm9sbGVyLg0KPiA+IEhvd2V2ZXIsIGluIHRoZSBtaXNjX2Nn
X3RyeV9jaGFyZ2UoKSBjb2RlLCB0aGUgZnVuY3Rpb24gd2lsbCByZXR1cm4NCj4gPiAtDQo+ID4g
RUJVU1kgaWYgbWF4IGxpbWl0IHdpbGwgYmUgY3Jvc3NlZCBvciB0b3RhbCB1c2FnZSB3aWxsIGJl
IG1vcmUgdGhhbg0KPiA+IHRoZQ0KPiA+IGNhcGFjaXR5LCB3aGljaCB3b3VsZCBzZWVtIHRvIGVu
Zm9yY2UgdG90YWwgY2FwYWNpdHkgYXMgYW4gdXBwZXINCj4gPiBsaW1pdA0KPiA+IGluIGFkZGl0
aW9uIHRvIG1heCBhbmQgbm90IGFsbG93IGZvciBvdmVyY29tbWl0LiBDYW4geW91IHByb3ZpZGUN
Cj4gPiBzb21lDQo+ID4gY2xhcml0eSBvbiB3aGV0aGVyIHRoZSByZXNvdXJjZSBjb25zdW1wdGlv
biBtb2RlbCBmb3IgdGhlIG1pc2MNCj4gPiBjb250cm9sbGVyIHNob3VsZCBhbGxvdyBmb3Igb3Zl
cmNvbW1pdD8NCj4gDQo+IEkgdGhpbmsgd2hhdCBpdCdzIHRyeWluZyB0byBzYXkgaXMgdGhhdCB0
aGUgc3VtIG9mIGZpcnN0IGxldmVsIC5tYXgncw0KPiBjYW4gYmUNCj4gaGlnaGVyIHRoYW4gdGhl
IHRvdGFsIGNhcGFjaXR5LiBlLmcuIExldCdzIHNheSB5b3UgaGF2ZSA1IG9mIHRoaXMNCj4gcmVz
b3VyY2UNCj4gYW5kIGEgaGllcmFyY2h5IGxpa2UgdGhlIGZvbGxvd2luZy4NCj4gDQo+IMKgwqDC
oMKgwqDCoMKgIFIgLSBBIC0gQScNCj4gwqDCoMKgwqDCoMKgwqDCoMKgICsgQiAtIEInDQo+IMKg
wqDCoMKgwqDCoMKgwqDCoCBcIEMNCj4gDQo+IEl0J3MgdmFsaWQgdG8gaGF2ZSBBLCBCLCBDJ3Mg
bWF4IHNldCB0byA0LCAzLCAyIHJlc3BlY3RpdmVseSBldmVuIGlmDQo+IHRoZXkNCj4gc3VtIHVw
IHRvIDkgd2hpY2ggaXMgbGFyZ2VyIHRoYW4gd2hhdCdzIGF2YWlsYWJsZSBpbiB0aGUgc3lzdGVt
LCA1IC0NCj4gaWUuIHRoZQ0KPiBtYXggbGltaXRzIGFyZSBvdmVyY29tbWl0dGVkIGZvciB0aGUg
cmVzb3VyY2UuDQo+IA0KPiBUaGFua3MuDQo+IA0KDQpTbyB0byBiZSBjbGVhciwgaWYgSSBoYXZl
IHRoaXM6DQoNCi9zeXMvZnMvY2dyb3VwL21pc2MuY2FwYWNpdHkNCnNvbWVfcmVzIDEwDQoNCmFu
ZCB0aGlzOg0KL3N5cy9mcy9jZ3JvdXAvdGVzdA0KDQp0ZXN0LmN1cnJlbnQgd2lsbCBuZXZlciBi
ZSBhbGxvd2VkIHRvIGV4Y2VlZCAxMC4NCg0K
