Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9E7BF765
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjJJJcb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjJJJc0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 05:32:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232ABA4;
        Tue, 10 Oct 2023 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696930344; x=1728466344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q7oQEgctWJKFldFZVdvNvnUaHwcNd+FqTe6I91jURaQ=;
  b=C6TSYnuMBz/BTH0I9tkeNHNWU6eK5ZSJ+zcnp0S3TJ79BrNPZWZMKuKS
   6y8mgm6h4zIQ88Mn5vBROfSyLNBJpJZnH5SNs28poL7T4dD99r0rR47h7
   /vkmCtCFmsBJaAC0Vx42nZXWuCJ1UOxCC1ej10aabcSojXITFls0ZyfaX
   djHaGU58ZHdHHUzMTQDPxdIDMy1sTyxLdoHU0P/55pcuCyAELiuHI2dCc
   e72P/4bqOkN4XYRMBQy7PTb3YK9B9jUd8x3S1p8D3NL5r71rfPfmYyzrW
   mCj6/Wft4EL1N4uMnpseXlIQkuoo1bz6DqLN0vzC8gtXTimDDBPQXp95P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="448544970"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="448544970"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 02:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="753332573"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="753332573"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 02:32:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 02:32:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 02:32:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 02:32:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 02:32:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi7C6Hkc2z9sx3RLnrAXSCusxmesA7yDpmfXd+/Y/f/LKq3BxuEBKj+1kQFE/tYmViC+Xf/orRqMdJG3K+kM2Gv17rNNCexJFYdJayxsmsXFk32mc/4klW9ZescPAbJudpgjVvzw2hhMaVGdvzQYFPD0C3gtsdKip7LNgrXkPyAOf+mOp0XH9dqer9kgBl3M/5UHNa5WlPjjbuVB3AqW6QtdvLNsMIMECuUOW2UuH3CnGuSHxpttoP05RIMkfwUgvhPY0nX4iPfYqI9vcQyBl4GJMKB3z6XwPr4zqAk9yh8J9RsygV3GW9HN9cDUoZzOIwtLcQdUKIwk/2CCUyigYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7oQEgctWJKFldFZVdvNvnUaHwcNd+FqTe6I91jURaQ=;
 b=HDGaG9RoI8x+c0sfYEv2OYOJwBtBGxE5idOjXusmkC9AhH6Qzr3nWRB69GyRCbMpORVMPS+f7SC42qpn3OernLe3McTc+j6tvjrTPx5rBMKhC91N2hd6w3J+S89sfxSEQgn4s+0ijy4YF8maAS7ZPxhTU4N1Wccgcnxn4vnYYB00mxCVJQghDCKCY6DZFc1uz84o7xP/7gQbuq0iPBDFc0Q8ELkdt/osvZfK5QPRH21deQUyY+dLPjHNHsBFla4IjP/puHUToT/Tb49b/etuYx2fUs+x837I/szGdQN5857bYa5xErUm/ygTw6kTQiF7HB+XVQEzMC0eDtKJF/GxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB7872.namprd11.prod.outlook.com (2603:10b6:208:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:32:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 09:32:19 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
Thread-Topic: [PATCH v5 16/18] x86/sgx: Limit process EPC usage with misc
 cgroup controller
Thread-Index: AQHZ7csxMWGpeN5dZUG6Wyp0ITB+SrBC3bOA
Date:   Tue, 10 Oct 2023 09:32:19 +0000
Message-ID: <3b7740e33d7806b6ab9b58205d830daa6e3b669e.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-17-haitao.huang@linux.intel.com>
In-Reply-To: <20230923030657.16148-17-haitao.huang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB7872:EE_
x-ms-office365-filtering-correlation-id: 1a339d2e-e978-4fd9-5776-08dbc973cce3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+1FhpC+KZNMDShJOyIlOSTngG5QLQEY1AL+udHPzJNu0sE+b4N7kX+7OxJ6VWl6sVOyCZh2+7ff1FgFSXcHFY+LCM3WjJ/jTLxw8gGd+4nit2qbj9onxqsz1zfba6tx66fwF1huaiTUHHn6a489SUaxt9uvEhz98cgtkaxM7lY/O5chCQOFCJjDeXTASBWewIGhuXbvFh6W6XxITFkY7PaIPCKuoK8ckeVh18+dQDmiibso2c43+mVDADRFYstyzpWCBpbyxqblLQtPCUUWJ2+v/YtATk6lpZga+QrLAVWsMEZrR0Gos0V+zgbRGJXfFbVo6qPAlA04UxzApUymxa5GD/geWc9t3bCF3PKw/Q8BnkoHw3gdseZAz4HuJZSymoGbNuU0jNSk2FE5loeaZg+wVMjbUKg7LKTM0JyWWiZGE4Y/xu5vw8MQcfhon3EQ9KUppnoN0hNdD5uBS3oD5xPOadyRS3SGmxLeHm2IiLntuNoePNNXdQXEYdPpzXUXvHeA6Z3MSvo3VdXD0FGSPyM1vaM6GW7pd9K+d1CQPWF642bW5ZTwwN8jy0jOOWcyncDZvdLJhJWaeA7VrzKDfK10iKlsymJvbNNjGXEFCFE5tSjMdvFA1kSjrjDhzZd8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(6506007)(2616005)(478600001)(6486002)(71200400001)(26005)(83380400001)(7416002)(2906002)(5660300002)(66476007)(91956017)(110136005)(76116006)(66446008)(54906003)(64756008)(66946007)(66556008)(316002)(8676002)(8936002)(4326008)(41300700001)(82960400001)(921005)(122000001)(36756003)(38070700005)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azNtWkRFbHJSbmZLUU9KcWlsVkVrQ0Qzd1pIaHBJRVc5Y2RtTW5GNld3TjZ1?=
 =?utf-8?B?RDFaUVprOGg5VktQZTNiSGw3NlRuRzJqVGpBaU5EQTRoa2l0WWIzSFFTRGtE?=
 =?utf-8?B?aFVKSFlhRGFwVGx3SlpsNHFCak9mNStKS3VHZC9JaG8zZGpNd0htcTRpVnJp?=
 =?utf-8?B?WHNnK2c2OE1tNUtlLy9LSTJsZVJYRFRFVjVubXg5d0ZRQUNRWisvMEt2dEN4?=
 =?utf-8?B?Ukhuekt0eGRiWGVCQml6OTJjbWZUMzNwNk9WSkp6YjFzWmc5WG00NFpaSEV2?=
 =?utf-8?B?VWkvc3VoNkZtMkZqM2RZYnBBbEpJbkFyNVBuTW8xd3Jkemdsb0lVVFNxMlJw?=
 =?utf-8?B?ckJrQnZxR1R3TnJseTBHWlMxSTlSYlp4RlRneU1tdm1WRzIrQVArRlZ5NXRh?=
 =?utf-8?B?UXBjRmxMcTgzdERHZWdyNVNBSGIzMzJBZFhLV0lDd3FuWnBYUS9lMlVtdDNj?=
 =?utf-8?B?dDlDUWU3SytyaDU2ZjZ0aVRMcFNJU3E4cE1FaXFtZWlQTmVCZTFWQmcvTkta?=
 =?utf-8?B?OEFUR2lORkJGN1R3MXpKYkRGb0dxZ3l1V2JzRlZTbkRIazNucGkrOTVOZERk?=
 =?utf-8?B?NGpmZjhoVEl2dHByR3lBK3RKY09uM016Tjcvd1FIREZiMGNWNXZSNTVDNG03?=
 =?utf-8?B?bExKMGwxeWorRUh4dWlQVXZXaFJXQU9aL1AyVkdGNDhPOFdScldQNEMvejBX?=
 =?utf-8?B?eXpYNkV2OUlVNytjK1ZmOFVMUEk2aXNraExiTnE2N01KTU5BWGo0Tm9GU3Qw?=
 =?utf-8?B?ZERGS0x0cVdocEVzNmdVRWpSMW41NktYU0poLzI1Z1VRRC9WaS9uS0FQU3Zu?=
 =?utf-8?B?L3psQWFPckV2VkxqekhYcWhXRzNlek1ZSUVTSkN1SiszMTB5bm9KbFdwVnhP?=
 =?utf-8?B?cVlSTUpYRnAzdW81UlJXVWVvaVN0K2JOdXNmdjd5b1hFTzhnUnVxMWthbDdm?=
 =?utf-8?B?Ni93TVVVWlpHdTFxSEFFTW40WnJTL05EQktWYnBEK29aZms4WXJqa0VFVmdr?=
 =?utf-8?B?cFJ2TDU5RURvWVdTVWpFYW04bFdBMmlBZWdyS1c0UHZlMHFaS1c5Y0dxVm45?=
 =?utf-8?B?bFJNZkVCT3JBL0RDbE5TdGY4ZXZYVjlUY0dBT2pCSHMvaExCTnkwMEo2NG1F?=
 =?utf-8?B?bTZSSVc4N2dZWEpBMkpJeHR3WnNkeGxNT0QrRHdNQjNJZG15YWM0QUkwQjBH?=
 =?utf-8?B?c2lhVnBQR3NJWHMxODZXN3VnQjI4d0hkYkZCTGJjSmxlMDFHOE14NWxkaXAz?=
 =?utf-8?B?NXJrQXV4akpZN2xYbzRvYWE0MktEc1pkaEs0ZFlIeWdhcS9jRnRzMXdUOHpB?=
 =?utf-8?B?dkdDNTczMG5UeGpFVVI4cTNCQW1lM09kUkQ4VTVuTXltODFLU0MzSGU1VW9v?=
 =?utf-8?B?SGZQVmt1Uzl1K1QyS2J2dXovenRSZEt5NmM3Mkh5YWxCTUJ2T3VqdzlMRSsz?=
 =?utf-8?B?MnQ5cEl3N1lpaldLak5DTVFiTU1PazNFZmJXdHMycUFNQklqQnJZdGtwSzB5?=
 =?utf-8?B?d1BXWGYrL2x1ZkxEcXhJNmM5aFI1ajJkR2JGODZzbnNtSWhqeGhFWHlJN2lJ?=
 =?utf-8?B?KzJaVFk3VGFxd3ZTOG0zN1hUcWdSOU8yRkRyeGRWeWFvUG14R2RLVVNQOEEy?=
 =?utf-8?B?MGw2TEhvQlhqb1VzTFRibWorak1KeGVZazgvRCtKczBjS1p5SHliNmlCc2tU?=
 =?utf-8?B?cEtWMy9pWm5yY1ozOG1kMFhSZVhIT0tiUkh5MlFlWERXQ2tXUXV4ZXFlM0hz?=
 =?utf-8?B?Tk5qQVRQTjM2RmxhanlkcjVudWdBVVAwSkRJd3NpSEQ3OEd1dExsY0thNVpY?=
 =?utf-8?B?SmFoZ3c2bXZHWUZodm96SXkyS2lvWWsvUUsrSU5LbE8xT0d6ei9qWFdZVGw4?=
 =?utf-8?B?MmFGbXVQVzFpWjJnVXQ4d2xYWXY3Kys0SVFTOElVOVphbEJsYkpIdXczdEVR?=
 =?utf-8?B?MVpUOHFnZUg4MmY0Q0VCZldHOFc2Z0ZoZXZoT1ljL2orNndQZWxXT1V6WDJE?=
 =?utf-8?B?dXBqdTM4ZDVXaDlPd01za1RnVkMwM2JzNW1GVHl4YTF6VzlLU21ycitvWTFj?=
 =?utf-8?B?UmZKQ09XQjVpTkZMTGk5ejZHK1ppQ3c3T3hsK2J5OEE4SjNzeXNkcGRTWW9u?=
 =?utf-8?B?R3dxSStVNmpBNWN2ZUtzMy9hRENMM2NidWs5TWhFKzFTMlUyc0xPRkNha0N5?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FD8A30BEDB0384B834485CD328DD990@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a339d2e-e978-4fd9-5776-08dbc973cce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 09:32:19.8482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtk12RnjjJ200JnUT7hAzNnYNsUgt4BU39mFTbhJLgCL5G3bLYbOmeB2o/JH2VUt6JUBVv5gP6KLgVQtU/m13w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IEZyb206IEtyaXN0ZW4gQ2FybHNvbiBBY2NhcmRpIDxrcmlzdGVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gDQo+IEltcGxlbWVudCBzdXBwb3J0IGZvciBjZ3JvdXAgY29udHJvbCBvZiBTR1ggRW5jbGF2
ZSBQYWdlIENhY2hlIChFUEMpDQo+IG1lbW9yeSB1c2luZyB0aGUgbWlzYyBjZ3JvdXAgY29udHJv
bGxlci4gRVBDIG1lbW9yeSBpcyBpbmRlcGVuZGVudA0KPiBmcm9tIG5vcm1hbCBzeXN0ZW0gbWVt
b3J5LCBlLmcuIG11c3QgYmUgcmVzZXJ2ZWQgYXQgYm9vdCBmcm9tIFJBTSBhbmQNCj4gY2Fubm90
IGJlIGNvbnZlcnRlZCBiZXR3ZWVuIEVQQyBhbmQgbm9ybWFsIG1lbW9yeSB3aGlsZSB0aGUgc3lz
dGVtIGlzDQo+IHJ1bm5pbmcuIEVQQyBpcyBtYW5hZ2VkIGJ5IHRoZSBTR1ggc3Vic3lzdGVtIGFu
ZCBpcyBub3QgYWNjb3VudGVkIGJ5DQo+IHRoZSBtZW1vcnkgY29udHJvbGxlci4NCj4gDQo+IE11
Y2ggbGlrZSBub3JtYWwgc3lzdGVtIG1lbW9yeSwgRVBDIG1lbW9yeSBjYW4gYmUgb3ZlcmNvbW1p
dHRlZCB2aWENCj4gdmlydHVhbCBtZW1vcnkgdGVjaG5pcXVlcyBhbmQgcGFnZXMgY2FuIGJlIHN3
YXBwZWQgb3V0IG9mIHRoZSBFUEMgdG8NCj4gdGhlaXIgYmFja2luZyBzdG9yZSAobm9ybWFsIHN5
c3RlbSBtZW1vcnksIGUuZy4gc2htZW0pLiAgVGhlIFNHWCBFUEMNCj4gc3Vic3lzdGVtIGlzIGFu
YWxvZ291cyB0byB0aGUgbWVtb3J5IHN1YnN5c3RlbSBhbmQgdGhlIFNHWCBFUEMgY29udHJvbGxl
cg0KPiBpcyBpbiB0dXJuIGFuYWxvZ291cyB0byB0aGUgbWVtb3J5IGNvbnRyb2xsZXI7IGl0IGlt
cGxlbWVudHMgbGltaXQgYW5kDQo+IHByb3RlY3Rpb24gbW9kZWxzIGZvciBFUEMgbWVtb3J5Lg0K
PiANCj4gVGhlIG1pc2MgY29udHJvbGxlciBwcm92aWRlcyBhIG1lY2hhbmlzbSB0byBzZXQgYSBo
YXJkIGxpbWl0IG9mIEVQQw0KPiB1c2FnZSB2aWEgdGhlICJzZ3hfZXBjIiByZXNvdXJjZSBpbiAi
bWlzYy5tYXgiLiBUaGUgdG90YWwgRVBDIG1lbW9yeQ0KPiBhdmFpbGFibGUgb24gdGhlIHN5c3Rl
bSBpcyByZXBvcnRlZCB2aWEgdGhlICJzZ3hfZXBjIiByZXNvdXJjZSBpbg0KPiAibWlzYy5jYXBh
Y2l0eSIuDQo+IA0KPiBUaGlzIHBhdGNoIHdhcyBtb2RpZmllZCBmcm9tIGl0cyBvcmlnaW5hbCB2
ZXJzaW9uIHRvIHVzZSB0aGUgbWlzYyBjZ3JvdXANCj4gY29udHJvbGxlciBpbnN0ZWFkIG9mIGEg
Y3VzdG9tIGNvbnRyb2xsZXIuDQo+IA0KPiANCg0KWy4uLl0NCg0KPiANCj4gNykgT3RoZXIgbWlu
b3IgcmVmYWN0b3Jpbmc6DQo+IC0gUmVtb3ZlIHVudXNlZCBwYXJhbXMgaW4gZXBjX2Nncm91cCBB
UElzDQo+IC0gY2VudHJhbGl6ZSB1bmNoYXJnZSBpbnRvIHNneF9mcmVlX2VwY19wYWdlKCkNCj4g
LS0tDQo+ICBhcmNoL3g4Ni9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgfCAgMTMgKw0KPiAg
YXJjaC94ODYva2VybmVsL2NwdS9zZ3gvTWFrZWZpbGUgICAgIHwgICAxICsNCj4gIGFyY2gveDg2
L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuYyB8IDQxNSArKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VwY19jZ3JvdXAuaCB8ICA1OSArKysr
DQo+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NneC9tYWluLmMgICAgICAgfCAgNjggKysrKy0NCj4g
IGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L3NneC5oICAgICAgICB8ICAxNyArLQ0KPiAgNiBmaWxl
cyBjaGFuZ2VkLCA1NTYgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZXBjX2Nncm91cC5jDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZXBjX2Nncm91cC5oDQoNCkFz
IG1lbnRpb25lZCBiZWZvcmUsIHRoaXMgcGF0Y2ggaXMgcHJldHR5IGxhcmdlIHRodXMgaXQncyBo
YXJkIHRvIHJldmlldy4gIEkNCnRoaW5rIHdlIHNob3VsZCB0cnkgdG8gc3BsaXQgaW50byBzbWFs
bGVyIHBhdGNoZXMgc28gdGhhdCB0aGV5IGNhbiBiZQ0KcmV2aWV3YWJsZS4NCg0KSSBjYW5ub3Qg
cmVjYWxsIGhvdyBtYW55IHRpbWVzIHRoYXQgSSd2ZSBkb25lIHNjcm9sbCB1cC9kb3duIGp1c3Qg
dG8gZmluZCBzb21lDQpmdW5jdGlvbi4NCg0KQW55IGlkZWEgdG8gZnVydGhlciBzcGxpdCB0aGlz
IHBhdGNoPw0KDQpBbHNvLCBJIGFtIHRoaW5raW5nIF9wZXJoYXBzXyB0aGUgd2F5IG9mIG9yZ2Fu
aXppbmcgdGhlIHBhdGNoZXMgb2YgdGhpcyBwYXRjaHNldA0KY2FuIGJlIGltcHJvdmVkLiAgSSBo
YWQgYW4gaW1wcmVzc2lvbiB0aGF0IHRoaXMgcGF0Y2hzZXQgaXMgb3JnYW5pemVkIGluIHRoaXMN
CndheTogwqANCg0KMSkgVGhlcmUgYXJlIG1hbnkgc21hbGwgcGF0Y2hlcyB0byBhZGp1c3QgdGhl
IGVsZW1lbnRhbCBjb2RlIHBpZWNlcyB0byBzdWl0IEVQQw0KY2dyb3VwIHN1cHBvcnQsIGJ1dCBt
YW55IG9mIHRoZW0gZG9uJ3QgaGF2ZSBlbm91Z2ggZGVzaWduIGluZm9ybWF0aW9uIHRvDQpqdXN0
aWZ5LCBidXQgb25seSBzYXlzICJFUEMgY2dyb3VwIHdpbGwgdXNlIGxhdGVyIiBldGMuDQoNCjIp
IEFuZCB0aGVuIHRoZSBFUEMgY2dyb3VwIGlzIGltcGxlbWVudGVkIGluIG9uZSBsYXJnZSBwYXRj
aCBhdCB0aGUgZW5kLg0KDQpCb3RoIDEpIGFuZCAyKSBhcmUgaGFyZCB0byByZXZpZXcuICBJIG5l
ZWQgdG8gZG8gYSBsb3Qgb2YgYmFjayBhbmQgZm9ydGggdG8NCnJldmlldyB0aGlzIHNlcmllcy4N
Cg0KSSBhbSBub3QgZmluZ2VyIHBvaW50aW5nIGF0IGFueXRoaW5nIGJlY2F1c2UgaXQncyBub3Qg
ZWFzeSBhdCBhbGwsIGJ1dCBqdXN0IHdhbnQNCnRvIGV4cGxvcmUgb3B0aW9ucyB0aGF0IG1heSBt
YWtlIHRoaXMgc2VyaWVzIGVhc2llciB0byByZXZpZXcuDQoNCkZvciBpbnN0YW5jZSwgd2lsbCBi
ZWxvdyBtYWtlIG1vcmUgc2Vuc2U6DQoNCkluc3RlYWQgb2YgaW1wbGVtZW50aW5nIEVQQyBjZ3Jv
dXAgaW4gb25lIGJpZyBwYXRjaCwgd2UgaW50cm9kdWNlIGtleQ0Kc3RydWN0dXJlcywgZWxlbWVu
dGFsIGhlbHBlcnMgaW4gc2VwYXJhdGUgcGF0Y2goZXMpIGF0IGVhcmx5IHBvc2l0aW9uIHNvIHRo
YXQNCml0J3MgZWFzeSB0byByZXZpZXcgc29tZSBiYXNpYyBsb2dpYy9jb252ZXJzaW9uLg0KDQpB
bmQgdGhlbiB3ZSBtYXkgbW92ZSBzb21lIGtleSBsb2dpYyBvZiBoYW5kbGluZyBFUEMgY2dyb3Vw
LCBlLmcuLCByZWNsYWltIGxvZ2ljLA0KdG8gZWFybHkgcGF0Y2hlcyB3aGVuIHdlIGFkanVzdCB0
aGUgZWxlbWVudGFsIGNvZGUgcGllY2VzIGZvciBFUEMgY2dyb3VwLg0KDQpQZXJoYXBzIGl0J3Mg
d29ydGggdG8gdHJ5LCBidXQganVzdCBteSAyY2VudHMuDQo=
