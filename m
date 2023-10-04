Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E37B8E7C
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjJDVF5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjJDVF4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 17:05:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260090;
        Wed,  4 Oct 2023 14:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696453552; x=1727989552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CvPoTx3rjpvE2V1zkdskpsAMJkFnU6iPPaWl6iNF1bM=;
  b=nrnzJ0oawArvMX4xumun4sC0UOmrltAwXoGG/nsFq3/xdQzjly3g5cNf
   yf0NjIaFXX5TTIzI/8xEV0LH59kTCM9/85OFpzDB1aKc1y0iCjw9nLSKq
   Z5zeuIzKg2IQDaYTCO5xzl0gJNZnAq38MEE2evsby5BqTBluzp3XeIz28
   amEgGVY7cYCDiC9fj7YJbsXH6vqjEe7PHZkse55hDgJFEyDmYluaXZ/Kw
   GeuX9xqff48twAPOqFQkN/DmgPLPK9atJlirptWgodTuXVfgvVMUElJ95
   wJjXPA5bszPhccIAzMrC1LfhUZzkkL/KHHwwrkin33Y8GYjR8lp4P0rOq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="382173457"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="382173457"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 14:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="728168329"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="728168329"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 14:05:51 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 14:05:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 14:05:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 14:05:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+yBYi85qW6r//tZsuqgMbJOyqaiIXaONmIP5ukR1bTvbYBGIf/7izxMh+By7HswrlB5iGhd7JY/EO4Jk5CC8uSEP5DoYg+FLne7r0JzJm28pk1HfnYbF5GEZ+PFHnSZIqpPnR6YBn6/NXqjqhp/mKNTiepaea8NsaATPkkUpee9LxxhZai+LKW0B31sBsvTazzjq4rkiq7vCiqgku0xz9Zv8C8qkIfugBPkAcvvysn3iAZM+rhwv8r6L6uRAjctBjFs9/Drx6Hyhql1GD7BJv8bNMO0+ZRlsK0Ea7SMH5G4PvRM7LfHKWMRkhDF0ym/3RqA5vXdH0AnfklZ14jLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvPoTx3rjpvE2V1zkdskpsAMJkFnU6iPPaWl6iNF1bM=;
 b=LdmjwnHy1ySdTGlhxY1v/FehhWcWRk8CNRj/E6FGDbHOK25EQn9HFF0M67NutQTZymAWqNHRy48QnUwOz0IP5FmQ3vbVXy1EKWH6+wyQy3d78CRHXRn6p7y1T4nbNaN1wC4G87dAs4apjpPBsTTGfFVK9fDP+Y5Ps1dRlC6ZBJQlRCDC+tm6waFIvVDL4jIHnQRqfcSuoiF9oZ6uRRrMBeWmhC9Zdkf41TKDZgMbiSyvLlwik0bY6dq6SJ73y6RlDj/z3jchdqwffPQcw/02cDx3Ne7O9Mx3AsjziyXmj/ACZ/2JAHXmGjhirKlek8cTk+b5x8eYS8q46cHMPaVTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 21:05:44 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 21:05:44 +0000
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
Subject: Re: [PATCH v5 06/18] x86/sgx: Introduce EPC page states
Thread-Topic: [PATCH v5 06/18] x86/sgx: Introduce EPC page states
Thread-Index: AQHZ7csUaq56ebRDx06C7sjZBwfv+bAufyYAgAkPTwCAAP9igIABRF+AgABfRIA=
Date:   Wed, 4 Oct 2023 21:05:44 +0000
Message-ID: <128730d9c552cccea3f94228b79dd546b6504dea.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-7-haitao.huang@linux.intel.com>
         <b1d7199262b9da496a04a36447541e9166f35f19.camel@intel.com>
         <op.2b72c4brwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <0c296ec0011afc51b90d77db7a2b1ae0a239aff6.camel@intel.com>
         <op.2caqfhkawjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2caqfhkawjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BL1PR11MB5977:EE_
x-ms-office365-filtering-correlation-id: 631b7a31-c732-4462-bb07-08dbc51dacc7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jek3Au8mMd8DC6cjBC6+TPVGmVhARQIYjpKckYkc98IWI0qXmX9+V82Bp7qyC72ylNDt406JdmrvumUTze/32mZT5aVzzQVE5XQrzPWEuq7+1I/Obm21u7bJHthbvFfz/yanVXUSpWF0bqUS8tR3dXS8tY//i4sNfmgLWkUM894RmWDDPKjM9ljmeSJNx98Vx9ur5OpQxs3FrvTeSH+dVFtB3e9pRXf7Ar6FtJcPYZZuGYL7XDKjvTxDXt6yDog9EXy4E9mIEMkYwl9YcPNH7KtkexJijm7llW8FM6tb8eJlJPIwlyReN+cKOZ7LMexHkiFdxXE7CCWaFPI6y8BfIX0MOA1FTPXKQkVUu9pq5AtLJ4vScw0LLUoKOpHqHYgG0XdBBNG4qO+B/f8/NviUIxD3KU4Hs7DDbG3Q+SedM+OW7KshNIv9FMiygnx3rzoiFI0wQDWkJF24BbokF6JUv7x59RZH9/MRZBNY+VnmGeW30lZ9zRWcbO+FmS4t8IQo7XqKDRPCFcxRXKUoVqVOOHG9m2TbTW+cc19q7yMFjX4arEULIBjccft35TVCHn6x6LjtRC2fJ237eT+gcHNTgSWX0WAFELuD2WF4a0KcPD+3m8o5nVj+GbntW+haGtn8wi9+4kXugIzCOn5D2i3DBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(6512007)(2616005)(2906002)(921005)(82960400001)(122000001)(36756003)(86362001)(38100700002)(38070700005)(66946007)(66476007)(66556008)(54906003)(110136005)(91956017)(66446008)(64756008)(83380400001)(76116006)(5660300002)(478600001)(41300700001)(316002)(6636002)(6486002)(4326008)(8676002)(8936002)(6506007)(7416002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0RsUElBbllQMW52Uk4wMjBpYkgwUkQvTW9BSmU2N3U1ZmhHSFVCd0dGekxE?=
 =?utf-8?B?Q1lOSlE2K28xcDl0R1A1K2xSVGtqMk1KSDhUQVpKUE5lcExET3BDbzlXTlBZ?=
 =?utf-8?B?TFdVUHlnSDdEM1ZsQXZETG0xU2xYb1Y3clhibGZEdElrSmVPOHVkeXdVcUNz?=
 =?utf-8?B?NExDVnhFZUtRbS9hOFZ3QmNqVlRxRHNzaThUWmlKQXp4dXFsMnZQMytQenYx?=
 =?utf-8?B?R0x1TzBtQVo5RDdDaE9vS3FHaDU3dzRDOGIyVDJrMDBtb2pCSkN2amMwWU5E?=
 =?utf-8?B?SmQxOUZKYmlMNmJsUGlveHFmNTR0eFg5anhTeUtOMzArdHkxV3J3aVZvZEtM?=
 =?utf-8?B?ZzRkM0VvTU51b3RPQ2hvRXIveTBEeXVEYUhTT3lkOEcrQjYxNk5IMzgwVE9C?=
 =?utf-8?B?OUdVOGh4dUpFbkpEMHQ3WjZJMVM3RVNaTStRQVdTMjFsMm91MFBHZHo0QlZy?=
 =?utf-8?B?aXJHSzBTNU4xYncrY2MvbEVxSGk1N25DaXc2T0htbjB5dWxsdFhwRkRvcnVL?=
 =?utf-8?B?OTE3N1RLRDZCRVY2R0Q2bDl4aXZ0SFFrV0FadWtNdlNNbXExSEJjVUxwQU54?=
 =?utf-8?B?eUxyRWx2SnFpWGNtelcvVWpESTRJb1diRGxWV2k4QzhXenhQZVEwQlk3VU1l?=
 =?utf-8?B?YzcxR0pINkYzWUxGcFdWSVkrZG5QQWRKRWlTMU1LSFpKSlUxZ0xyVGtYM0VL?=
 =?utf-8?B?eFF2S1JQVUxqSWJqRWh5Sks2WlA4WDZady8zSWJIT2tNdk0wbHZMeC9CK1dB?=
 =?utf-8?B?NWdOL0dmdXhoRGZ5WUI3alYwMlFJQ0JvZXkwYUFKTEJaM3ZUUDlDWjUrdWJS?=
 =?utf-8?B?MC9kN1FLWjg0UXZTdk1mQnpsMEpBK0p2WWhXUXVDS2UxcWlEaGNaTnFiZEVx?=
 =?utf-8?B?MDJsalhQN29pazhXejFFakVkekJpMGRhbFRhMGJKZHRMOGtQUWR1VlVFdlZ1?=
 =?utf-8?B?V09MNnlrVUZ2Wk15d3hEMlJkbThDait5bmtCeUF5dmQ1WVRCT1kzQitwbjVm?=
 =?utf-8?B?VG9RaUhibkdMSXpKdFUvUUxKaWFzMVpHcjFpeURjTkhDN0pnakU4OVBDWTBP?=
 =?utf-8?B?UmM3a3NDRkRNK2V3M1U3b05DQ3Bibm91OFV5aHNUcmM0VXc3dnZXL2dDaS9G?=
 =?utf-8?B?LzBQV3dTUHVhcUxyTi9zQ3ZiZE9wcXdPbVNzaFh2Yy9ZUnF2L0RPMis5bVJi?=
 =?utf-8?B?eHVkMG9STkgwQmFqWjlVUjA4NDhta0R1Q0g1cUJYM3d5VldIbExjRXNLZEo4?=
 =?utf-8?B?ckZBT1pzMVJHdk1WR2hKR1VZK0t1Y2Vsbkk2cTdiZFphQmkzM202ckdweDZk?=
 =?utf-8?B?MjZkL3dIdFlIUmJHci81MmRBVkE1Yi9IUDF3MEREUG1jeEZKbUZSYTR1ZkpT?=
 =?utf-8?B?NDBCVzBGQ2hqRTB0NWVuNmU1OEtaYTFrQ2JCUGt1TDFEQjdGVlphS3VyOGZr?=
 =?utf-8?B?WjQ2T3VPVytWQmMzTHRsdUEwWVVjbUpYMUV1NDlKNUNnM2pDY3pYMGl1UGwz?=
 =?utf-8?B?bkFDUFE3SWxEbVdod1c0ZGxFakNrcHhIRFR6ZE83UkxjZW5hMlFkNXFXYmVU?=
 =?utf-8?B?SHR4QmlNTHRjdEczcFVUdC9SU1lEYlU4ejdjWUorb0hORTh4YWRQdUsxME55?=
 =?utf-8?B?Z3lTSjgrM2lJVHNwMkY4U3ZkYUZ5WkRlRzkwV1hrUWdSQjk1aFVTTElzcE1m?=
 =?utf-8?B?RlNneTZlN0lYN0xrTGxQZGh2NVlmc2hIajlQbDhWbWxkWlFzYWNuOEE2TUht?=
 =?utf-8?B?Y2U0QWpkNWZiZ2VWS3dDbnE4d1JZZGxJY3VLeHdkcmgwU25VdllpZTBranZ5?=
 =?utf-8?B?N2hJQXB0c0xMWFc5S3RXWHhlTHQyc3VSSERFUEQxbXNKbk5pMEdDaTF3czRo?=
 =?utf-8?B?N01kMGNZUzNXZ0hkZHgwb2hQQnNzL0dWOG0vVUhFTWtTaUE5SnV2WUFzWEk1?=
 =?utf-8?B?TFpnVU5JR2JTckZCVHVBcjdyWnVWcUFxRktLdGhWZEs5ZWNCWk5uQWlDSUJv?=
 =?utf-8?B?bU9ENTBWRnUwTzB2VVI4Q2p5VzlIanVQZm1KSnJCWVNJVlY3Zzh5YkdnTFlu?=
 =?utf-8?B?aDBaaGdWcldSNU1JVVdBL3AvUGpzcm14TzFCaVlQelJvL1o3N0dmaFZZVVhS?=
 =?utf-8?B?OHhNaHhHejlrTW1GbnBXSG10TDBOYXRrOGp5djdkM3BZRG43cnROR0I0ekND?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D9A067D571E5E489C9D50AE587447AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631b7a31-c732-4462-bb07-08dbc51dacc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 21:05:44.6400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QE6ufdYtQG9kOdd9+FJpaoshjwURp9s5rnT8ImY8Q2WIbdPibK29o9FwdKooKCgbXolKaAi4gy/9IHtS7AlbwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
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

T24gV2VkLCAyMDIzLTEwLTA0IGF0IDEwOjI0IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIFR1ZSwgMDMgT2N0IDIwMjMgMTU6MDM6NDggLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBNb24sIDIwMjMtMTAtMDIgYXQgMjM6NDkg
LTA1MDAsIEhhaXRhbyBIdWFuZyB3cm90ZToNCj4gPiA+IE9uIFdlZCwgMjcgU2VwIDIwMjMgMDU6
Mjg6MzYgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFuZ0BpbnRlbC5jb20+ICANCj4gPiA+IHdy
b3RlOg0KPiA+ID4gDQo+ID4gPiA+IE9uIEZyaSwgMjAyMy0wOS0yMiBhdCAyMDowNiAtMDcwMCwg
SGFpdGFvIEh1YW5nIHdyb3RlOg0KPiA+ID4gPiA+IFVzZSB0aGUgbG93ZXIgMyBiaXRzIGluIHRo
ZSBmbGFncyBmaWVsZCBvZiBzZ3hfZXBjX3BhZ2Ugc3RydWN0IHRvDQo+ID4gPiA+ID4gdHJhY2sg
RVBDIHN0YXRlcyBpbiBpdHMgbGlmZSBjeWNsZSBhbmQgZGVmaW5lIGFuIGVudW0gZm9yIHBvc3Np
YmxlDQo+ID4gPiA+ID4gc3RhdGVzLiBNb3JlIHN0YXRlKHMpIHdpbGwgYmUgYWRkZWQgbGF0ZXIu
DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHBhdGNoIGRvZXMgbW9yZSB0aGFuIHdoYXQgdGhlIGNo
YW5nZWxvZyBjbGFpbXMgdG8gZG8uICBBRkFJQ1QgaXQNCj4gPiA+ID4gZG9lcw0KPiA+ID4gPiBi
ZWxvdzoNCj4gPiA+ID4gDQo+ID4gPiA+ICAxKSBVc2UgdGhlIGxvd2VyIDMgYml0cyB0byB0cmFj
ayBFUEMgcGFnZSBzdGF0dXMNCj4gPiA+ID4gIDIpIFJlbmFtZSBTR1hfRVBDX1BBR0VfUkVDTEFJ
TUVSX1RSQUNLRUQgdG8gU0dYX0VQQ19QQUdFX1JFUkNMQUlNQUJMRQ0KPiA+ID4gPiAgMykgSW50
cm9kdWNlIGEgbmV3IHN0YXRlIFNHWF9FUENfUEFHRV9VTlJFQ0xBSU1BQkxFDQo+ID4gPiA+ICA0
KSBUcmFjayBTRUNTIGFuZCBWQSBwYWdlcyBhcyBTR1hfRVBDX1BBR0VfVU5SRUNMQUlNQUJMRQ0K
PiA+ID4gPiANCj4gPiA+ID4gVGhlIGNoYW5nZWxvZyBvbmx5IHNheXMgMSkgSUlVQy4NCj4gPiA+
ID4gDQo+ID4gPiBJIGRvbid0IHF1aXRlIGdldCB3aHkgeW91IHdvdWxkIHZpZXcgMykgYXMgYSBz
ZXBhcmF0ZSBpdGVtIGZyb20gMSkuDQo+ID4gDQo+ID4gMSkgaXMgYWJvdXQgdXNpbmcgc29tZSBt
ZXRob2QgdG8gdHJhY2sgRVBDIHBhZ2Ugc3RhdHVzLCAzKSBpcyBhZGRpbmcgYSAgDQo+ID4gbmV3
DQo+ID4gc3RhdGUuDQo+ID4gDQo+ID4gV2h5IGNhbm5vdCB0aGV5IGJlIHNlcGFyYXRlZD8NCj4g
PiANCj4gPiA+IEluIG15IHZpZXcsIDQpIGlzIG5vdCBkb25lIGFzIGxvbmcgYXMgdGhlcmUgaXMg
bm90IHNlcGFyYXRlIGxpc3QgdG8gIA0KPiA+ID4gdHJhY2sNCj4gPiA+IGl0Lg0KPiA+IA0KPiA+
IFlvdSBhcmUgbGl0ZXJhbGx5IGRvaW5nIGJlbG93Og0KPiA+IA0KPiA+IEBAIC0xMTMsNiArMTEz
LDkgQEAgc3RhdGljIGludCBzZ3hfZW5jbF9jcmVhdGUoc3RydWN0IHNneF9lbmNsICplbmNsLCAg
DQo+ID4gc3RydWN0DQo+ID4gc2d4X3NlY3MgKnNlY3MpDQo+ID4gIAllbmNsLT5hdHRyaWJ1dGVz
ID0gc2Vjcy0+YXR0cmlidXRlczsNCj4gPiAgCWVuY2wtPmF0dHJpYnV0ZXNfbWFzayA9IFNHWF9B
VFRSX1VOUFJJVl9NQVNLOw0KPiA+ICsJc2d4X3JlY29yZF9lcGNfcGFnZShlbmNsLT5zZWNzLmVw
Y19wYWdlLA0KPiA+ICsJCQkgICAgU0dYX0VQQ19QQUdFX1VOUkVDTEFJTUFCTEUpOw0KPiA+ICsN
Cj4gPiANCj4gPiBXaGljaCBvYnZpb3VzbHkgaXMgdHJhY2tpbmcgU0VDUyBhcyB1bnJlY2xhaW1h
YmxlIHBhZ2UgaGVyZS4NCj4gPiANCj4gPiBUaGUgb25seSB0aGluZyB5b3UgYXJlIG5vdCBkb2lu
ZyBub3cgaXMgdG8gcHV0IHRvIHRoZSBhY3R1YWwgbGlzdCwgd2hpY2ggIA0KPiA+IHlvdQ0KPiA+
IGludHJvZHVjZWQgaW4gYSBsYXRlciBwYXRjaC4NCj4gPiANCj4gPiBCdXQgd2h5IG5vdCBqdXN0
IGRvaW5nIHRoZW0gdG9nZXRoZXI/DQo+ID4gDQo+ID4gDQo+IEkgc2VlIHdoZXJlIHRoZSBwcm9i
bGVtIGlzIG5vdy4gIEluaXRpYWxseSB0aGVzZSBzdGF0ZXMgYXJlIGJpdCBtYXNrcyBzbyAgDQo+
IFVOVFJBQ0tFRCBhbmQgVU5SRUNMQUlNQUJMRSBhcmUgYWxsIG5vdCBtYXNrZWQgKHNldCB6ZXJv
KS4gSSdsbCBjaGFuZ2UgIA0KPiB0aGVzZSAicmVjb3JkIiBjYWxscyB3aXRoIFVOVFJBQ0tFRCBp
bnN0ZWFkLCBhbmQgbGF0ZXIgcmVwbGFjZSB3aXRoICANCj4gVU5SRUNMQUlNQUJMRSB3aGVuIHRo
ZXkgYXJlIGFjdHVhbGx5IGFkZGVkIHRvIHRoZSBsaXN0LiBTbyBVTlJFQ0xBSU1BQkxFICANCj4g
c3RhdGUgY2FuIGFsc28gYmUgZGVsYXllZCB1bnRpbCB0aGF0IHBhdGNoIHdpdGggdGhlIGxpc3Qg
YWRkZWQuDQoNCkkgYW0gbm90IHN1cmUgd2hldGhlciBJIGFtIGZvbGxvd2luZywgYnV0IGNvdWxk
IHdlIGp1c3QgZGVsYXkgaW50cm9kdWNpbmcgdGhlDQoidW50cmFja2VkIiBvciAidW5yZWNsYWlt
YWJsZSIgdW50aWwgdGhlIGxpc3QgaXMgYWRkZWQ/DQoNCldoeSBkbyB3ZSBuZWVkIHRvIGNhbGwg
c2d4X3JlY29yZF9lcGNfcGFnZSgpIGZvciBTRUNTIGFuZCBWQSBwYWdlcyBpbiBfdGhpc18NCnBh
dGNoPw0KDQpSZWFkaW5nIGFnYWluLCBJIF90aGlua18gdGhlIHJlYXNvbiB3aHkgeW91IGFkZGVk
IHRoZXNlIG5ldyBzdGF0ZXMgYmVjYXVzZSB5b3UNCndhbnQgdG8ganVzdGlmeSB1c2luZyB0aGUg
bG93IDMgYml0cyBhcyBFUEMgcGFnZSBzdGF0ZXMsIGkuZS4sIGJlbG93IGNvZGUgLi4uDQoNCgkr
I2RlZmluZSBTR1hfRVBDX1BBR0VfU1RBVEVfTUFTSyBHRU5NQVNLKDIsIDApDQoNCkJ1dCBmb3Ig
bm93IHdlIG9ubHkgaGF2ZSB0d28gdmFsaWQgc3RhdGVzOg0KDQoJLSBTR1hfRVBDX1BBR0VfSVNf
RlJFRQ0KCS0gU0dYX0VQQ19QQUdFX1JFQ0xBSU1FUl9UUkFDS0VEDQoNClRodXMgeW91IGFkZGVk
IHR3byBtb3JlIHN0YXRlczogTk9UX1RSQUNLRUQvVU5SRUNMQUlNQUJMRS4gIEFuZCBtb3JlDQpj
b25mdXNpbmdseSwgeW91IGFkZGVkIGNhbGxpbmcgc2d4X3JlY29yZF9lcGNfcGFnZSgpIGZvciBT
RUNTIGFuZCBWQSBwYWdlcyBpbg0KdGhpcyBwYXRjaCB0byB0cnkgdG8gYWN0dWFsbHkgdXNlIHRo
ZXNlIG5ldyBzdGF0ZXMsIHdoaWxlIHRoZSBjaGFuZ2Vsb2cgc2F5czoNCg0KCVVzZSB0aGUgbG93
ZXIgMyBiaXRzIGluIHRoZSBmbGFncyBmaWVsZCBvZiBzZ3hfZXBjX3BhZ2Ugc3RydWN0IHRvDQoJ
dHJhY2sgRVBDIHN0YXRlcyBpbiBpdHMgbGlmZSBjeWNsZSBhbmQgZGVmaW5lIGFuIGVudW0gZm9y
IHBvc3NpYmxlDQoJc3RhdGVzLiBNb3JlIHN0YXRlKHMpIHdpbGwgYmUgYWRkZWQgbGF0ZXIuDQoN
Ci4uLiB3aGljaCBkb2Vzbid0IG1lbnRpb24gYW55IG9mIGFib3ZlLg0KDQpCdXQgdGhpcyBkb2Vz
bid0IHN0YW5kIGVpdGhlciBiZWNhdXNlIHlvdSBvbmx5IG5lZWQgMiBiaXRzIGZvciB0aGUgZm91
ciBzdGF0ZXMNCmJ1dCBub3QgMyBiaXRzLiAgU28gSSBkb24ndCBzZWUgaG93IGFkZGluZyB0aGUg
bmV3IHN0YXRlcyBjb3VsZCBoZWxwIGhlcmUuDQoNClNvIEkgd291bGQgc3VnZ2VzdCB0d28gb3B0
aW9uczoNCg0KMSnCoA0KDQpJbiB0aGlzIHBhdGNoLCB5b3Ugb25seSBjaGFuZ2UgdGhlIHdheSB0
byB0cmFjayBFUEMgc3RhdGVzIHRvIHJlZmxlY3QgeW91cg0KY2hhbmdlbG9nIG9mIHRoaXMgcGF0
Y2ggKG1heWJlIHlvdSBjYW4gYWRkIE5PVF9UUkFDS0VELCBidXQgSSBhbSBub3Qgc3VyZSAvDQpk
b24ndCBjYXJlLCBqdXN0IGdpdmUgYSBqdXN0aWZpY2F0aW9uIGlmIHlvdSBkbykuDQoNCkFuZCB0
aGVuIHlvdSBoYXZlIGEgcGF0Y2ggdG8gaW50cm9kdWNlIHRoZSBuZXcgdW5yZWNsYWltYWJsZSBs
aXN0LCB0aGUgbmV3IEVQQw0Kc3RhdGUsIGFuZCBjYWxsIHNneF9yZWNvcmRfZXBjX3BhZ2UoKSAq
QU5EKiBzZ3hfZHJvcF9lcGNfcGFnZSgpIGZvciBTRUNTL1ZBDQpwYWdlcy4gIFRoZSBwYXRjaCBj
b3VsZCBiZSB0aXRsZWQgc3VjaCBhczoNCg0KCXg4Ni9zZ3g6IFN0b3JlIFNFQ1MvVkEgcGFnZXMg
aW4gdGhlIHVucmVjbGFpbWFibGUgbGlzdA0KDQoyKQ0KDQpZb3UgZG8gdGhlIG9wcG9zaXRlIHRv
IG9wdGlvbiAxKTogSW50cm9kdWNlIHRoZSBwYXRjaCANCg0KCXg4Ni9zZ3g6IFN0b3JlIFNFQ1Mv
VkEgcGFnZXMgaW4gdGhlIHVucmVjbGFpbWFibGUgbGlzdA0KDQouLi4gZmlyc3QsIGFuZCB0aGVu
IGNvbnZlcnQgdGhlIEVQQyBzdGF0ZXMgdG8gdXNpbmcgdGhlIGxvd2VyIDMgYml0cyAoYWN0dWFs
bHkgMg0KYml0cyBpcyBlbm91Z2gsIHlvdSBjYW4gZXh0ZW5kIHRvIDMgYml0cyBpbiBsYXRlciBw
YXRjaCB3aGVuIG5lZWRlZCkuDQoNCkRvZXMgYWJvdmUgbWFrZSBtb3JlIHNlbnNlPw0KDQo=
