Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A647B50D4
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 13:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjJBLF2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 07:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBLF0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 07:05:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A7FBD;
        Mon,  2 Oct 2023 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696244720; x=1727780720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0M6hJiuDtTGlqKLEIvttw08SJU/udHsoQ01s0lBRPCs=;
  b=aB2OjiJMT9WcY4UhLs6DnrIg9wjCyH7ynBC+wiPz9aO4k+qsInmHeqvo
   JBXCeoFfbl0n6OIVggCbacsa0zq9xwZ9Pf44Bh7ruWZ9fRvIFsceChzxJ
   BixgxpiNVwEbCoHZA0/Ow97ySf4E6o1mm5kQsCMAZD3l+dOBJYdXkDE6Z
   CFTXNlKeGIQ5HASDyS5HIW4z99cI2qEOyIFLXB1W9yOB8kEIju8lSFHTX
   ++3xuFXH6wos51Mvu+8uxAxstlQiMU+cFQyhOd4J8MVm7BrunvPn9Vx84
   vg50bdDYiqQmb5RLUnueXI/HTKoIW7VxbhsExfdRqHFo0arsMIDCjxQAE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="386492493"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="386492493"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 04:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="727229522"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="727229522"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 04:05:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 04:05:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 04:05:19 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 04:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fxn9NvHpcBDeO8vm/Cn1nomjEEbqoxS5KpzZ6F1S1kUmK83eGb0J2idk4Vx3U+hv9WQmFZSICJMw49omFqqTJ5d8AsSwZJhWBmv+79/VbZLA+U2mD+2dH/zXgM85uE7/NMj7CRGlKWVg+ubBwV3JHnMTlfxwXwIS1820NxkbVqKaewj7juNKnXO2fA2hlzw5RZiinQGJmkQdjfRzfkVQHew6vymIjb6uXe/73Hq2IQaidFTRX6AprRJ3rUeiCBKCREpY1ZVGAx1uuIqx9844ES7fNyK9kwJ6NMnXuVTZPjsTdOkLO5j2+dkJyBMfifsZpDNpWf+E+vhFHESI07U3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0M6hJiuDtTGlqKLEIvttw08SJU/udHsoQ01s0lBRPCs=;
 b=gFXfrw1nNashU/i80QURpHnf91hXOxWpqfH9mwbGzQpdnRnHMmi+8lO5TZtD+5N6Kes+B7Z3bxzqLuy4uHkpT0MhvD/1ZN7T/iLBtr69hwHcOw+KBZkJvhmb3WnOdnFCf+7fMCJpYgCEpkM7AC+XOwALnwtfsDCyE+EWMPfPsh8FtvnPiGlNAXsw0eLesbdcBjrCLIeHZg3OtDZJN11MnHRsAXHOOU87jczp+nO2q58d33FTWm0oP2nmObYO9y1GJNQqK8LTZqnkJ8E0YRSmTMqnQGrbweraxC59OAdWmLNXKhNp2Tmok/GKxZ2pAWrL8s58FVwFR5RmmyufElhjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB6944.namprd11.prod.outlook.com (2603:10b6:806:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 2 Oct
 2023 11:05:16 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 11:05:16 +0000
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
Thread-Index: AQHZ7cscCwFKzsfMlUe7K1500sBqu7Aui+oAgABI9gCAAGCkgIACu9qAgARzmIA=
Date:   Mon, 2 Oct 2023 11:05:16 +0000
Message-ID: <fcdf25d46785c195d73815d52b9829efaa376bfc.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-10-haitao.huang@linux.intel.com>
         <46fecb95ae2c4cd156ad7bda99522214fcfe5774.camel@intel.com>
         <op.2bxr9aj7wjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <fd2049b46a2e508a90006731a5d0cd2b90db9e45.camel@intel.com>
         <op.2b1f8j1bwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2b1f8j1bwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB6944:EE_
x-ms-office365-filtering-correlation-id: 369a8bfc-bc32-4c15-2370-08dbc337759c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+xwrETiM63iQ8qflhdQDZQj9u8pEpSOc7V/3GDUrR+vYNfyKYebW0Ev3UNQ2D5oy9Ueed/hEZuAQdS7VdQpSOYxzG9KopdFBvbBeMtg7BohVOEIxHzI2q4D0jo5vdo1U8EhXq1RIfIEBwcMU/7zF3YhN5VBmc7k/j1ohlXI1r1c56zsDy+Ox3sRcGzcvcAWDFCEI5yZf0uIuXnb+S43pyfceAby3GnkCn4FOCfPU8BHuPcB1jbkh/oHN1B0EVu7umih4XFTgrOum8a30Pz+JD5y84P+oEXrfFwtukVCbiqT3z12klcXkSx9M/+v8BALN7ABFfHnj8Bmk6fO67qSIxXVr6KxMP3nkCf7sTZ0gxlQkF/HxkSgAv3Y/l1xGm+xks3/+z3Td/umdmtOFmQT4hEALlvnB4ohLcKme67yR+YxFE34rb1+BBQfOh5xMMpefH0C0S+eh5Co4mXiRGWYLk8CyaK9FSQ5JvdwJg6ONO1V2MikZmZeeATG9U1T9az7DAXfUyNuJJAOSw89KxtJrOSFCAstscSFRASIps3qo5l4Kj7Oh2TDt8n8b/KQ2ZaW51DcYWTjzsWuE8j4ejxBsECOejH6bLfQb36v/JaLneOxJ3KaEwvrWJ0Ckgag2aHafuBI4keA9ytV8w+fb5/ksT0oBJ6fI5zs7EG8Ybx4aUrv25P8qOOYFdSOhf7if4dU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(2616005)(7416002)(6512007)(6486002)(6506007)(71200400001)(86362001)(82960400001)(36756003)(26005)(921005)(38100700002)(38070700005)(83380400001)(478600001)(122000001)(66556008)(66476007)(64756008)(66446008)(76116006)(5660300002)(54906003)(66946007)(110136005)(91956017)(316002)(8936002)(8676002)(6636002)(4326008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3liWmxJMlUycWJuaUdRMVA5R3RtYWdxcGRDbkZxZHFzK3ZmZVk2WEgrK3ZT?=
 =?utf-8?B?TkQvWEVLdkE2aXpHanpvOTNVTDNFWUdYU2xkVEE4dEdSVU1kT3k1OFM1LzVC?=
 =?utf-8?B?TjNpOWd5L3pTQVdacHpWRkJxN0lhVDFjSFlwcmV6R01JQzBaOEREMFQ3QzF4?=
 =?utf-8?B?YW54NE1GYk96em16WE9nUTVjd1dCeHJvbmNuTk9QOFdHbXBGZDN6SGxNSFR3?=
 =?utf-8?B?OERZZnFZRm9BUjEyY1VDdERDTnJ3TE91TkdMejRZcUtod3RMV0NuL0d2NXZM?=
 =?utf-8?B?bkZaTkpWdlhkUitESGVwcW9XMnYydUd4djhsd3ZXQVJkTzg4RHpZOTlOcFNx?=
 =?utf-8?B?TTZFS0MyZE1uL0ZtcGw5RU5ReEtoWnpURVJSK3ZoTmx1ZW84WGRIL0NwYWhn?=
 =?utf-8?B?WnhNSnpvaWFoWFpYelpBM21mWWZieXQvR1FaYWtmcHNFdklBRCtGc3BRMWh4?=
 =?utf-8?B?Q3FiOU1IYW5veXcwYityaFlydUFEcTE4Zm8xSVBFUlVIWXFIcDlvTG5iY3lm?=
 =?utf-8?B?dWlKNnFnNXA4MGM5cXZQaGV4SVhSNVAvSFc0QW1uTzVac2dCbHBxVVBqYnJN?=
 =?utf-8?B?ejF2RWl2Ymt0OVJJNTRCcHhzdDFDVk85ZjhIZE5aRE4yVXZyeGZ5SzBIVkFP?=
 =?utf-8?B?UGQzTkJ4OGoxeXN2Sk9peDdUSytJN0tuOC9WRjYzdDNIVzlsbEEyTUdSU1RH?=
 =?utf-8?B?cnpBRHcwSi9nMFNsaDRyWTdBM3FsR1dYeFYrazVnT0MxUi8rbUtSVjg3L2pQ?=
 =?utf-8?B?dEhLTlFXSnhVZDJOQXNQQWF6KzI1RlpsWmtsR2JETWowRlhKVGJtODA5OTJO?=
 =?utf-8?B?bm9WbjJkaXJEbFhQb3pzVUh5YTJxYnpESmhWN1NSZXprYkQvaTBHUDc2cDIy?=
 =?utf-8?B?NktFUU1YNWNYY3UvWlV4WldreFU2MzNJMzVVTW4xMVBIbit3SXdBSHhBaysv?=
 =?utf-8?B?VThtWGp2Y0NKQjRCM1kxTTMxa0FnUDRIZkExdUthbUd1eVJHWm13RytwSmtR?=
 =?utf-8?B?QTdEU1lVdW1zdFA5WnJXR3ZRWU9XTUE1dVVqZFArdk1yOHpOeEhkMm5VOVli?=
 =?utf-8?B?UEhNN0pRcGxSek5Za2RTa0RQT2xBd2NvcWYyb1MydDgwTnZlVE5Qbk9vbVM0?=
 =?utf-8?B?R2hOUmhoQzYzQ29nRFU5a1ZSTHk4UjlrMjhkVlVPZkhzQks4UnExeU1vT1Jo?=
 =?utf-8?B?THZQZ1hFNFFoYUhEa1VjYjZZdGM4bURTaUROWmlrTXVaa2FFeGdxNVR3Z3po?=
 =?utf-8?B?SGhlRStHTGpKRm5Bc1lQSmtNcjdKUG15U1dOWTNmdkdiWnQxVW84SXM4T2I4?=
 =?utf-8?B?ZzRDQ3JmRTlsWU9oSHVHUFAraXNoMmlOVGwvVzJuNWRmcmh3a0VZc3g5Zmgy?=
 =?utf-8?B?b1d4ekpLQ1ordWhibzhpQWVjSE54cFlmSVhzY0J0OUNab2tkUEorb0VCSWk0?=
 =?utf-8?B?VzlLaHpZNFE2UG9CTVRvTkxXLy9uUFZUeWlRVm91MXdFN05vQ2E3bzZSQytR?=
 =?utf-8?B?WFFaU2pId3RjWHlOUnZUbHZsYjhqNDBQY2YzdnVZcEZucm1zM0NHdkpZM0pB?=
 =?utf-8?B?cG9uWW5lYUF3cDI2dlo3enQyd1hpaEt5dlNvWnplenZQS01xK0ttNm84aWhQ?=
 =?utf-8?B?RjZTM1hQRDZCY0NBY1hOTll4SXNNR2hUS0FnZkZlNDF0RlBZNkNlZTlZU2FB?=
 =?utf-8?B?NjE1SlN5d0VaVHIvOTUvQkp4NG9BSTVMNUFlZlZ3YlpxaTg2Q05pSGJOcXlX?=
 =?utf-8?B?WEJjdENpMVY0S281eXUxMHBoL3ZVRTB5cCtPSENnd1dYdkhiWVR2WVByRk8w?=
 =?utf-8?B?Yk1zbE1oZVp1Z2hYeG92T25uSXRjL2NObkNPR1hTYytiampMbjBxR1VFcTFy?=
 =?utf-8?B?dGkrNHViaXBBenlzZzhPa1E4bmJ0ZkpnVFZ6bHpYUy8zdU0vYy9qb3N3NklZ?=
 =?utf-8?B?RkJOQmhOeHhIZ29yc05kR2VzRWZMM2gxeE52UGlQUGYzS3F1a3hjWk1pK29O?=
 =?utf-8?B?eitGV2JsMDVCcjlRZGo3VTM1MGYzQTkvUWVxYkRKdFhuS1RLb0pFR1RVd3VN?=
 =?utf-8?B?UTU1NUhVTUhnSHM2ZEpsSW9yTGNWUUw2bSt1NTZjVWVDZ3htdHdsakVHRUV1?=
 =?utf-8?B?OXNWNnA3TjI4MWpyWk96QkJwRzhNQklGOVFhS0VmcEd4T25nNmQ5YXNmTjlP?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E42CD5013E93814A87D51C245B5328D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369a8bfc-bc32-4c15-2370-08dbc337759c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 11:05:16.6431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tsPsgzGkYkUTxK1zP8mzP9BhXA5kpESixVq47alP9IvaSWaRndCj4ecdAMBrCuqXi1djXV1Ya0ONtz6MEXoTRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTI5IGF0IDEwOjA2IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFdlZCwgMjcgU2VwIDIwMjMgMTY6MjE6MTkgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBXZWQsIDIwMjMtMDktMjcgYXQgMTA6MzUg
LTA1MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwkvKiBQ
b3NzaWJsZSBvd25lciB0eXBlcyAqLw0KPiA+ID4gPiA+ICsJdW5pb24gew0KPiA+ID4gPiA+ICsJ
CXN0cnVjdCBzZ3hfZW5jbF9wYWdlICplbmNsX3BhZ2U7DQo+ID4gPiA+ID4gKwkJc3RydWN0IHNn
eF9lbmNsICplbmNsOw0KPiA+ID4gPiA+ICsJfTsNCj4gPiA+ID4gDQo+ID4gPiA+IFNhZGx5IGZv
ciB2aXJ0dWFsIEVQQyBwYWdlIHRoZSBvd25lciBpcyBzZXQgdG8gdGhlICdzZ3hfdmVwYycgIA0K
PiA+ID4gaW5zdGFuY2UgaXQNCj4gPiA+ID4gYmVsb25ncyB0by4NCj4gPiA+ID4gDQo+ID4gPiA+
IEdpdmVuIGhvdyBzZ3hfe2FsbG9jfGZyZWV9X2VwY19wYWdlKCkgYXJiaXRyYXJpbHkgdXNlcyBl
bmNsX3BhZ2UsPiAgDQo+ID4gPiBwZXJoYXBzIHdlDQo+ID4gPiA+IHNob3VsZCBkbyBiZWxvdz8N
Cj4gPiA+ID4gDQo+ID4gPiA+ICAJdW5pb24gew0KPiA+ID4gPiAgCQlzdHJ1Y3Qgc2d4X2VuY2xf
cGFnZSAqZW5jbF9wYWdlOw0KPiA+ID4gPiAgCQlzdHJ1Y3Qgc2d4X2VuY2wgKmVuY2w7DQo+ID4g
PiA+ICAJCXN0cnVjdCBzZ3hfdmVwYyAqdmVwYzsNCj4gPiA+ID4gIAkJdm9pZCAqb3duZXI7DQo+
ID4gPiA+ICAJfTsNCj4gPiA+ID4gDQo+ID4gPiA+IEFuZCBpbiBzZ3hfe2FsbG9jfGZyZWV9X2Vw
Y19wYWdlKCkgd2UgY2FuIHVzZSAnb3duZXInIGluc3RlYWQuDQo+ID4gPiA+IA0KPiA+ID4gDQo+
ID4gPiBBcyBJIG1lbnRpb25lZCBpbiBjb3ZlciBsZXR0ZXIgYW5kIGNoYW5nZSBsb2cgaW4gMTEv
MTgsIHRoaXMgc2VyaWVzIGRvZXMgDQo+ID4gPiBub3QgdHJhY2sgdmlydHVhbCBFUEMuDQo+ID4g
DQo+ID4gSXQncyBub3QgYWJvdXQgaG93IGRvZXMgdGhlIGNvdmVyIGxldHRlciBzYXlzLiAgV2Ug
Y2Fubm90IGlnbm9yZSB0aGUgIA0KPiA+IGZhY3QgdGhhdA0KPiA+IGN1cnJlbnRseSB2aXJ0dWFs
IEVQQyB1c2VzIG93bmVyIHRvby4NCj4gPiANCj4gPiBCdXQgZ2l2ZW4gdGhlIHZpcnR1YWwgRVBD
IGNvZGUgY3VycmVudGx5IGRvZXNuJ3QgdXNlIHRoZSBvd25lciwgSSBjYW4gIA0KPiA+IGxpdmUg
d2l0aA0KPiA+IG5vdCBoYXZpbmcgdGhlICd2ZXBjJyBtZW1iZXIgaW4gdGhlIHVuaW9uIG5vdy4N
Cj4gDQo+IEFoLCBJIGZvcmdvdCBldmVuIHRob3VnaCB3ZSBkb24ndCB1c2UgdGhlIG93bmVyIGZp
ZWxkIGFzc2lnbmVkIGJ5IHZlcGMsIGl0ICANCj4gaXMgc3RpbGwgcGFzc2VkIGludG8gc2d4X2Fs
bG9jL2ZyZWVfZXBjX3BhZ2UoKS4NCj4gDQo+IFdpbGwgYWRkIGJhY2sgInZvaWQqIG93bmVyIiBh
bmQgdXNlIGl0IGZvciBhc3NpZ25tZW50IGluc2lkZSAgDQo+IHNneF9hbGxvYy9mcmVlX2VwY19w
YWdlKCkuDQo+IA0KPiANCg0KQW5kIGFsc28gc2d4X3NldHVwX2VwY19zZWN0aW9uKCkuDQo=
