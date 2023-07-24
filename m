Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E0760219
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 00:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGXWRz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jul 2023 18:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjGXWRy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jul 2023 18:17:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3550E10CB;
        Mon, 24 Jul 2023 15:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690237072; x=1721773072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iRaQG8oA51d1U/OxRKCbJABhr3dX4Ptnngbq9LEtfzA=;
  b=RE5R+aE0RXwedmIkplvUjqnFF1lLg7D7Yj62jkK9cxfos98VlQ8wT6Wj
   gawxl6GJnziGQtFExe1uIBab4qCWAdBMPs6adr9K7/ASkoiLaOVgrPU9J
   +oQ99zCDJ3fnwWKIfKROv9vPO5L87OI7oJKshAcX7Nuz1TTY/q93JVvDX
   ed7mNNGI9fnbMuQsuu6vXjtflxZPW16R5D/T7Nnbz3zHKQ6x6K6xbAPNe
   Tliun1yp5vLyIKJJIpOmFzzmVJ5hCyrrLY+kZzoEwZ0TwwzE5yfnLfRTl
   CQINPygpW+jUBYH9gXsoyLEBp4KesbNnEqLshL47QEZUNQROceWyKoCuk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347840168"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="347840168"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 15:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="729091507"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="729091507"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jul 2023 15:17:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 15:17:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 15:17:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 15:17:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 15:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLy5RLckrIUA61Tbl3cBmIZFfRNczlx241K0F8q6AwQbkJQ9iY8LwLVGKysR0McaUsDmAK8bJ8TdEZgga1rmvDrXk97spYaIE+gLU4zl+Ot+ogvTUG2Bt9JkjL+CiKJT4gGW3FgRAK0ozlDABo/8NsdN/uMYeQSDfQrP3/qbHQjhoc8RIw0L0YX1CR4zzwxdk4LayyCyd/wwKfkbwbpXbOuAoEsm8sbVQZw6U0NUP7mKGdFaidBhwR4w5pbMOzwVHmpeLdGXG9wumYK940iAKJyYQiLVZJCSmHBoBSXikK+CWIg1gHNk7flRbWDatAs7H+JYjOKseluOCrKCc1lcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRaQG8oA51d1U/OxRKCbJABhr3dX4Ptnngbq9LEtfzA=;
 b=Ep0POp4lHxXVwkw/3ZXAYoDp2RGTcRw5AMcSsW6D9qOvubda0+d3hjMZtYyVHRVnSxATQ2vhGtHVNi+yVmqNP537VbUJ43TfX+jTogjA3kOCy4BqRBb7Avp9A7d1SwYzO1u/cTcGoEmVHOxYeYbwIofzXhfczNeow/zAbA6hioau5XC6eBBfZj4YZb1tbBkeGZwDFHufsP/31plJz4dTXEEE9+ha3t4zHUGhU7453vSKwdN/anF7UCTNLluNy4xOafg6vPUc/o0i04XTlo569Md6OyMUEHie111JhRzH+9HnlcRZowhefVY04LX4snjuSulDX4BSDl3N03l+zDON1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 22:17:43 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 22:17:43 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kamalesh.babulal@oracle.com" <kamalesh.babulal@oracle.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc_cgroup: Fix the obsolete comment around 'struct
 misc_res'
Thread-Topic: [PATCH] misc_cgroup: Fix the obsolete comment around 'struct
 misc_res'
Thread-Index: AQHZviWkg+AZunQvpUW833CAAzrfJq/I7YeAgACPfwA=
Date:   Mon, 24 Jul 2023 22:17:43 +0000
Message-ID: <75579ac7ccf3c3b340f432b822d87eab716a51fc.camel@intel.com>
References: <20230724115425.1452383-1-kai.huang@intel.com>
         <7690e7b2-6e7f-6ff1-5249-72f497f82f7e@oracle.com>
In-Reply-To: <7690e7b2-6e7f-6ff1-5249-72f497f82f7e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4686:EE_
x-ms-office365-filtering-correlation-id: 2d44b912-b691-4141-0601-08db8c93cd5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ENr7Sieug5p/CGfvpVJc0ZpkH8PJEhMGhzTxe42KWouICUgWBKAGu2eQ9yWT+9Hq5oyfwNHuzRJTiduBCfFyaj3EYJ9VKW3BnTAYxvV+gOMoZt3tSRBtSSwd5KEdN1i7dy0EfSKK2w7hiWR9+rqULjECObgmvtPcH2zrLdrnsptbQYTkoTsfKdfYtVXv/r3F+ubgGPIza8mJPWeCt2YFt7bNQ2XrJQYaEqiUf1WvP91svtKlV3Y+zAPWKpisQSP8EZJupxeutDnp4zRS/Z2KD1Al3H8evkYcqs05FUv0zAaaLrVrcLwutfKJr4njRDvL64J8LXhQH0rXjC22hrdLEXitkxyUE0QOzsC+0+l8eA+swGp/6OL1fQ36YCb4uHMbkSPn34QXlhh6z0MTwOirVgIcU1RsyKS+PjkRBYh+BAc2mi0TVmWKfem1KHBVtzMahDUyASdDLi5sasgrbZ/VS4x0g9IEDe0biPzwZNg+yUudEAT9tDhAz7xmU9pjH7vRJ8JSoexdp7zEEEqqsyIl1/Gt9OM13PVLhkSscMxPAxx6uT38msKCP7KSo8PSCu1TUYK8AfL6B9fKtaC75pANU9dTtNTqERMlKdlScTN+26w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199021)(38100700002)(122000001)(53546011)(2616005)(83380400001)(36756003)(66476007)(8676002)(8936002)(5660300002)(110136005)(64756008)(54906003)(478600001)(66556008)(4326008)(66446008)(316002)(76116006)(66946007)(91956017)(41300700001)(966005)(6486002)(186003)(26005)(71200400001)(6506007)(2906002)(6512007)(4744005)(38070700005)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEtVSXRYRTlZZTFwcHg0cXFlTzVRU1RDL3VRYkNKL0w4RHJaRkdSR2dOUjRQ?=
 =?utf-8?B?RlVmRktRK1pkUG90M2x1eldvK3ZLdVNnNHdQZkJyQXVsNy9hcGs5OUdrME5j?=
 =?utf-8?B?K3hJczdoM3N2ZWN1NmxhTFJHZ2Eyd2UvbSt6aXVmRHdLNVVDSHR0TnZtbnJs?=
 =?utf-8?B?K2NmSGJWYmRlaHBIam9jV0JJYWJCUUlQWE51S2xwS0ExNTVtaWNhYzdPcW5n?=
 =?utf-8?B?eGt0VkIrL3QrWEpJS2pGRndmM1ZscDNhRCtQQnFCVXZKOStYNXB0SmNhRWRF?=
 =?utf-8?B?VUF3b3REVmhDNDJRMGc4ZjBVYi95YjVBV2hlQnNjOFo2NVVFQmxKVFJWdHV1?=
 =?utf-8?B?LzN4WmRLSWt2ZHlsZVNZMHoyNDJZSUZENlQ3cEwwVE9ka2NnZ0dzVUtvdDM2?=
 =?utf-8?B?TGZWY1V2dU1nVzlxdU5tMWFtZCtkWkt2cG9lV2JHZmErMXZaZ2pScGhHUUw2?=
 =?utf-8?B?R1J3Y2xmeGp2a3lrRFJ6dXdIZGpmd011cVFVYm9hcjY4QW9nR0hwdG5QSUxa?=
 =?utf-8?B?Y3lWT2xGcloxQ0JUaTE4N2hiNDVBQjJyaTFpYTBIMnFWNVgya2Y2M09YSm9T?=
 =?utf-8?B?VzljMXFFV2lnYVV5RXhZNG1HN2hNTFo1cVY1RjJTZU04U3VLbjloS2JBa240?=
 =?utf-8?B?M2JUTnFnZ0dxVys0UDFONytySmF6TWtZY3AxNmdOdm45Sno0UmRoLzhFcWFl?=
 =?utf-8?B?aVVmNEJCc0s4Q2Z3WTRvMlpCTy84TWNObVNrSUtXL1E1ZThvVk5ObzJoNHhR?=
 =?utf-8?B?dHl1MEJzWHcyQ3JnN01yejc5dnovUDVnVlh3UStHaGsrT3QwMzhjRkRQb3ll?=
 =?utf-8?B?b3dTb0Z3S25aR3Rjc3Myb1VCYlppTmNDcFgzKzhkdkx1QjRYOFM3MCtScmdJ?=
 =?utf-8?B?SFBEdWdRK3dJUEQ1ZmFGNlRXQXArNE9PZlkxS3I2MDZMb3JRV25KVXVFdnFv?=
 =?utf-8?B?S09GZXlMRVZuZ0dvVDg0ZGx2MzNhUHdWWEdDTk5MMEIwVHV6WjRVeWtvSm1l?=
 =?utf-8?B?M0FKVzYwOFd0TDlDUkhDRE16c3NRandkbkNuSVVaamJsSEZsNXpVd0ZGZnQz?=
 =?utf-8?B?SWlIb3VMSEx5K3RId3ZjQ0N6enptMC9YUEZhc1Y5aGNybkR0OURpUzdiOUFJ?=
 =?utf-8?B?WlBzUVpCZnhmZHlpNnlDZXBlOVJLbkt0aDVDVnFuLzljaC9wT01SSUxHckhE?=
 =?utf-8?B?VlBCdzBTUHBqa1ZuMTVFeUUzWjBJcTREZFRTRTlFRVIyeGpOczNXV0h4N09U?=
 =?utf-8?B?YnVGWElRYTVYNXZNSkF3N3ErQUxXLzNXSlE2QkRqZ1krOVdXSUF5dHJ5OGdz?=
 =?utf-8?B?M1dOZXFGYjBaOEVDU2hoRDV5WHI3czRXL254WlZmZVpXeHFqK2RxdXBOK0cy?=
 =?utf-8?B?bXNnTUxySGZidFJwM3EvQjA5S1hCRXNzejRnWk5tZjBaQUNaY0VTY3pjSjNS?=
 =?utf-8?B?RDY0WkZhUCtiMHJOVjhsbG5ZWllaZGdYSldIY1dNQTA2bTNuUDltdExoNzBq?=
 =?utf-8?B?M1d0ZFBqaTM5c1V6LzFsSUhoUzlCZGFsRXNQM2tBNXZnNFhpd29YM0lmdmI5?=
 =?utf-8?B?L0N1OGNhbTl2am44TTRQWmltY2d1M3NuMVhBc2Nma3lMNEplbnZXWWtnZHYz?=
 =?utf-8?B?YWdXWGd5ajNyUEJCczNpVkMwVFBzTE4rY21qKzViM1ZsalNFRFhpc2lLYWkv?=
 =?utf-8?B?Nk1BYk5GVkJabzJtTkptMmxCRjlmNVlRQzRlWlRzTTFhN29rY2ZFVjM0VXZ3?=
 =?utf-8?B?SG9vdHpEdm0xUm95N1NIdWluNEtUU0E4NkdvT3ZVcHlKOXJGckRSSm85VWgy?=
 =?utf-8?B?ZS9KQkRHSHo1ZkNqeS9RcWV0T0ZLd1drQ1RIUkl0d3g5TElKTG4xRXJXL0tW?=
 =?utf-8?B?dEE3cjlBbU5NK1FOV0VFZnkwaVJRWE1ndEhjenFSZ1hLRm4yK3ZQZkZieFlZ?=
 =?utf-8?B?TmJaQndTYWxlYmlQcjN2Z2Urb3E4d3owUzNaMkgxZFE2eWY0Z2l1T095UldZ?=
 =?utf-8?B?RmR3YjMyUnJRZjhRcElpakF5VGtlVmVVa2lZUzV0dCtSR1dvVFk1OUs3czMx?=
 =?utf-8?B?ck5kd2J0bExlYUJWY01QaGVNSjhXUE1OcTJUSkRkaVNpTG1KT0ZXUlZTdG1n?=
 =?utf-8?Q?qo6f84QUte/1HweEUZMt67dt4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57F7224580EB3D4390534A27EC8115C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d44b912-b691-4141-0601-08db8c93cd5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 22:17:43.6661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDmMQ9IMqNNZECKHMUJY7XW6gU8PRZIAAMRrzJIQ54VvjKTiqnSY4N1ODcnTrN/hSqgL4QojQvz97q2/mgH2xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDE5OjE0ICswNTMwLCBLYW1hbGVzaCBCYWJ1bGFsIHdyb3Rl
Og0KPiANCj4gT24gNy8yNC8yMyAxNzoyNCwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IFRoZSBjb21t
ZW50IG9mIHRoZSAnZmFpbGVkJyBtZW1iZXIgb2YgJ3N0cnVjdCBtaXNjX3JlcycgaXMgb2Jzb2xl
dGUNCj4gPiBzaW5jZSBjb21taXQgYjAzMzU3NTI4ZmQ5ICgibWlzY19jZ3JvdXA6IHJlbW92ZSBl
cnJvciBsb2cgdG8gYXZvaWQgbG9nDQo+ID4gZmxvb2QiKSwgd2hpY2ggcmVtb3ZlZCB0aGUgJ2Zh
aWxlZCcgbWVtYmVyIGZyb20gdGhlIHN0cnVjdHVyZS4gIFJlbW92ZQ0KPiA+IHRoZSBvYnNvbGV0
ZSBjb21tZW50Lg0KPiA+IA0KPiA+IEFsc28gYWRkIHRoZSBtaXNzaW5nIGNvbW1lbnQgZm9yIHRo
ZSAnZXZlbnRzJyBmaWVsZCwgd2hpY2ggc2hvdWxkIGNvbWUNCj4gPiB3aXRoIGNvbW1pdCBmMjc5
Mjk0YjMyOTMgKCJtaXNjX2Nncm91cDogaW50cm9kdWNlIG1pc2MuZXZlbnRzIHRvIGNvdW50DQo+
ID4gZmFpbHVyZXMiKSB3aGVyZSB0aGUgJ2V2ZW50cycgbWVtYmVyIHdhcyBhZGRlZC4NCj4gDQo+
IFRoaXMgaGFzIGJlZW4gZml4ZWQgYnk6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyMzA3MTgwOTA4MzQuMTgyOTE5MS0xLWthbWFsZXNoLmJhYnVsYWxAb3JhY2xlLmNvbS8NCj4g
DQo+ID4gDQoNCkFoIEkgbWlzc2VkIHRoaXMuICBUaGVuIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRj
aC4gIFRoYW5rcyENCg==
