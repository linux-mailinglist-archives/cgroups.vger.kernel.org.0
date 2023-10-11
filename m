Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70C7C46DF
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 02:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbjJKAvb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 20:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbjJKAva (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 20:51:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666BB9B;
        Tue, 10 Oct 2023 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696985488; x=1728521488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tGh/Gh7edZssZ5KceGjiAHE5boVkxjeTkaN5LP/AAgM=;
  b=Ebbkt8WayzrXR9KiW2pGHcTbiguIkGA+gyg5CaSyzJXfWCtDT39Kjyql
   TfiP9xsym9GDS4HTnXK7SjApG8fB0kaczhRJ0DJu/BP6cL6uDaIfVZcbY
   GiuWE0iIQPyXNq4euCzuW8bL+b0ghIpqoW2bKBiNC4mtwRt9hxa57YB3d
   LY/8Kx+q0rN1ne/C93RnUyOu3czLth6zs6z3o7Fb0WHg7VV4iaWXCOh30
   WhmcI8+NIjmNzkebKQ9QlZbmnwR0dVdeFcvqwpAlg4X9ns64wao3siBVX
   3pm5DoMydKc6glQAB8ZELJKze+qMkr+6YxQSDyJA0i5Wux52zy7p02CjT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415595125"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415595125"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 17:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="844359425"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="844359425"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 17:51:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 17:51:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 17:51:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 17:51:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 17:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWo3Ea+QDuMzzG8pjB3oavkQ2lTE6hudAW9s3S+5LxNgxQy9ripjSN6wAZ7St0Py68zWfihZn5hgNEyKSt9IQZLfwE1KVFCqIyFiOYCZI22chTh/4RyRN6S/ntK+ckCMoyayRusdRZFPyYvVvj8EvND7ORGOKu0wtNNYaFTJorJbQfEqkn7X7ZUkcuN6vyjVj66FgxWPxeNN3m3hcqDfeDQHB2KRq5tx2yCiJjsGm4R3RXiGOyqLcWr76+6mE6WpS9ivDXXC4hV4euAVMnXjAOmuCNAMa2egq4wEtUGTFEH3tzPwjAqcjNjXQ6AhYN3+K5UWi0j3XhKk1puXTY9jGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGh/Gh7edZssZ5KceGjiAHE5boVkxjeTkaN5LP/AAgM=;
 b=ASOtWxfRVELI2scGffKUuC9GPLCuAn3kMFhP1otd6lrTVnUguCNG4rOQPHTGLFqK2hiysbOi5SgSm8daIUshWZgkADFiYgGaki2yFy6FiwB2uwnzoYpRwMQBalOB96xse+YA+GQwLVS3UbUcYtqt8/6y9ABkLd68ZOAL2MFzwnehumKLLYYqVQj6URj29zLtODYV+y/+t7oPI2+fhJrgpGw9rotjHUavv61yCfKJryzd7j1hfFh5JBnihHOCOMLV+7Ch0NFqKM+aw8HbvMLTX2VIgvUsYy1QV/MBc7tPb305jWREYktUiXb6wmDHs5Vyek4zNSjMtuCLSluj+eCrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 00:51:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Wed, 11 Oct 2023
 00:51:18 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>
CC:     "Zhang, Bo" <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Topic: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAKoQCAAAepgIAADEaAgAD/w4CAAIaBAA==
Date:   Wed, 11 Oct 2023 00:51:17 +0000
Message-ID: <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <ZSSZaFrxvCvR1SOy@google.com>
         <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
         <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
         <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5277:EE_
x-ms-office365-filtering-correlation-id: 2724a013-edb9-406b-85df-08dbc9f42d95
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jRisGuJLPlIPOTankig73F3E+0NVYsfjXgmSRQ71O8IT6YBu9mvXUJ9z9SNlFUWKOFWzrpxAAoSdRjkTj0jfEguPM5eGeCyv6DQ0oH+ivw+4dDeZW/FvJtriyO3ZEBPD9llOET2p5wvhiUaF17qfAKYw1Ir4SXT/eWHb0cSo7222Pn1A/tB+z5RMmhVnCj5Lzsqn4Aa0EWDajni7WUd86LC3R/A76ZUjs3iidRQmsf7DW+/YGH0zfsf7l/5+hxl85PtyH9rUYDCaIUpxTyTEdAAcHEzl0N2BfW3ukenTJNYZa735df9sI6wd5hSxIuZpnqG9EaQTjUHSZvzIxQT//2/zQTZ2ucS9oHkzhTwI3iwLLJB5zGRg9ccqZugmgYyMy6BdAiEY5qtUz9oHDOGOzBGqAPENs+KtEu96KrbluBhtClLNgsnm4dHJeHdzKoa+E/V4f6FhDotB+HFTqGVNN4RfcpC1HiMNGaDJhnrCL8RS4wOTB+s25frJ005mcKKjfaoa1jJ8yMnkKRFFzrXWaQ8ceq9upca7JB0m6N4yxyoDxM6qCkNg6Eef947iEEKuYuA9c2UkJHStb1sR0Vp6J2Wxr2JCYXv7VXknrtTFwS4uao2mdc2b/mPFs+72nL/o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(86362001)(36756003)(7416002)(2906002)(2616005)(26005)(82960400001)(38070700005)(4001150100001)(71200400001)(122000001)(4326008)(6512007)(6506007)(8676002)(8936002)(5660300002)(41300700001)(38100700002)(6486002)(478600001)(54906003)(64756008)(66946007)(76116006)(66446008)(66556008)(110136005)(91956017)(66476007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek5jei96V2pRdG1IWDB1OStQZG94eWs5QkpHZWF1eGlrNzVMSWRRak9rbnNu?=
 =?utf-8?B?aWozYzFDS2JlR3BCUUh5NEw0VWdIckliaERxYTl6L2M0VjAva0p6MXdsb0pW?=
 =?utf-8?B?Wms4WUNVVGRoTDlrUWhITFdXZHZxenQwT3NmUHplMFF4WmtRbk52MzlxOE1Z?=
 =?utf-8?B?WExIYklyZkFHQXdxU0w4VWNZZWNuVjUvZEFGZE5mRXRqdUFoc0pOTnNzdTdN?=
 =?utf-8?B?TTdHb00zanVieXI0QnFkRjZRK2F2clVlK0c0NXNId0ZjOUhkeWFxdE03WHJK?=
 =?utf-8?B?c2VEUTBpVkZDVmNvMFB6ZUIvZHRxemJDZTBWcE1aK0lEaUd5a04rV1pKbVRN?=
 =?utf-8?B?SW9nUTM0WVdTOHFRRC9jRW9GMVREdUQxaG1ZVGNwWkJwaTAyYjNFRHdtcXAw?=
 =?utf-8?B?ZExOU25mNWUySk1RY3JXeVpFMW5NUW9KTkczbkVPNzBMVjZTQ0dYU2hyVnpw?=
 =?utf-8?B?Mm96Q1RUMU5wWExkcElBTHRkSURqNG01OTI4THUzVnBzUWQ3Qjk0WjhYWHI3?=
 =?utf-8?B?RTlXUkJlUnNjVXIxMFhWclZSRXVZelZ3dk9HeCtVVHBOcmNnem9BMDBLbzJB?=
 =?utf-8?B?eWxwT1U1K1BFTlhuQjMxOU1STFJmVVlnYlNxUStGbXVkRGh4bzFuK3FLUTVY?=
 =?utf-8?B?MTRSZmtrQ0RUVHora1crVHlRS0tPZVQvUW9MbEZwMC9sMFlJbGNRSXRxVGFK?=
 =?utf-8?B?S3JNeDR6UGttK085cjZNc29VakE2dW1qVURaUlI3ME9HU00rcEs4cEZaTHlk?=
 =?utf-8?B?eWdaellBTU4yaGdVbUZYc1hyRzB2bjRwRzV1cDhPd1JxcjZSLzFlL2l1Ymhq?=
 =?utf-8?B?MkE2N1p1TFc3RUpxK3pyd1FZNXJLWEYvVnpTSW13VDRtVG9oMUVSOWhOS29q?=
 =?utf-8?B?Y3l6dUpNTEJtMCtleEg1ZDJieFZ6aE9laUFoZ1l3K0NSTExjdDEzSkQzMlNz?=
 =?utf-8?B?cTZ6L3ZvVVRxZ1FDdFp3dXRaYTJwbTV6M2E3NVF6OHZkRE03TC9DYStrYXc4?=
 =?utf-8?B?WjUwWFVhdWdYYVZsYWlkSUdMTUltN3I3eXg0RGVBc09qZHJDUXhrWUFsejBE?=
 =?utf-8?B?bGhUVmxKK2pJTDJPd0Focm5SVEx3R2NoL0p3SHV2eU5NYnpSbEJYMWN5Y3JK?=
 =?utf-8?B?ZjhPM2dEcmcxbzZhNW0wZERUT3ZrSGl6djdFVFh6bjVCYmdDQ3FJRGZxb2VB?=
 =?utf-8?B?WjcrRFN4ZW1rL2RRWU9aR0tuUlpMSDI0UUxrVFp6SWdjRCtSWHN0NklzNWxi?=
 =?utf-8?B?STd5RTFDSVRzOHJmQXdYVVVFeHV3OU9GdXVIdnJBYXRoeEFQZmcxVWR3WXd0?=
 =?utf-8?B?c1BienRndnlucHNKcFc1U3NRUEF6akY1b05uVTJOZTY3Z0lvSUg5cnozcGN1?=
 =?utf-8?B?QUViZGxqc1VpOEVBRkpSRTZlNXpETzBhVElucEZ2K0NsYVRzWEJQVm4wcEUw?=
 =?utf-8?B?UTdsQm9yRFFFaTlLZG0yYlVEaC80bHJFdlRCLzZlU00xRTVsOTRnZU1iT0xF?=
 =?utf-8?B?QjRSQ3dPd0dkYVRwb1lGQlpnN3FQdElLQ3FsektQSkV1cjNHUlRjcnlTZDBa?=
 =?utf-8?B?UEd1M1FRTlNtNWcwTWowb3EyYmhkd0g4clU4OHJGVFdkV1JSTGRoSkFWRlZL?=
 =?utf-8?B?THA3dnNQbmFnQXFzYmpLOXVoYXoxSlorTFBnam8wNlJVSUg1N25tU094NVZt?=
 =?utf-8?B?REt4ZDRKOG8veHlQRFNJU1psSHQzKzRlQkZSZ3BTZnNXOUx5dyt0dFNwUWZk?=
 =?utf-8?B?WTd2WGRGRjQ2bW1uTURhdUNMMzFkeGFLV05iUE01c21ZenFnbExOU2NJamxl?=
 =?utf-8?B?cC9Kb0VySUorZ1YwWGRaWDFkRDlRV0VVLzVyQk44SGtCbUdzdFpwTVY2alBj?=
 =?utf-8?B?YWo1NEQzL3RqOGpUTWdLazc1WVhzdSswYndJaEYwaFZUa3VhTVVZVEdRWWQz?=
 =?utf-8?B?MVFkcjZvKzZKMEZLRjZySVdlYUU1NUdYSUlOejEzRnVRRnVUSlVtRDE3S1BY?=
 =?utf-8?B?ZVpZTDNXNEdIMXBQMTV4anVXbnIwUzBHTm1uZncvclFjYVBHVEd6Z0tJdWc4?=
 =?utf-8?B?OG1ZUnl1ckUxWHRwbFhRSkxBOXVwcXNMUm9RVUVsZFBuTEY5S2RWMzVmOVQy?=
 =?utf-8?B?MWNsTS9iWlN5OW5KZ2pNcE5GQjdiS1M2Um5Ud1BaNVNjWjRpYnZ0RXdJOGFZ?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7A39D4CA9AE3443814861CAA18EC15E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2724a013-edb9-406b-85df-08dbc9f42d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 00:51:17.6831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTAE12Lm/g9YpuMM0l7kwojAL63Fmpc1wXwzR6LR/aaxSyy5ziqD9EtGiqgdQGrDVzb7+ZW5HCXb55OyA3Go9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTEwIGF0IDExOjQ5IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIE1vbiwgMDkgT2N0IDIwMjMgMjA6MzQ6MjkgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiBUdWUsIDIwMjMtMTAtMTAgYXQgMDA6NTAg
KzAwMDAsIEh1YW5nLCBLYWkgd3JvdGU6DQo+ID4gPiBPbiBNb24sIDIwMjMtMTAtMDkgYXQgMTc6
MjMgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgT2N0
IDA5LCAyMDIzLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiA+ID4gT24gRnJpLCAyMDIzLTA5LTIy
IGF0IDIwOjA2IC0wNzAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiArLyoqDQo+
ID4gPiA+ID4gPiArICogc2d4X2VwY19vb20oKSAtIGludm9rZSBFUEMgb3V0LW9mLW1lbW9yeSBo
YW5kbGluZyBvbiB0YXJnZXQgIA0KPiA+ID4gTFJVDQo+ID4gPiA+ID4gPiArICogQGxydToJTFJV
IHRoYXQgaXMgbG93DQo+ID4gPiA+ID4gPiArICoNCj4gPiA+ID4gPiA+ICsgKiBSZXR1cm46CSV0
cnVlIGlmIGEgdmljdGltIHdhcyBmb3VuZCBhbmQga2lja2VkLg0KPiA+ID4gPiA+ID4gKyAqLw0K
PiA+ID4gPiA+ID4gK2Jvb2wgc2d4X2VwY19vb20oc3RydWN0IHNneF9lcGNfbHJ1X2xpc3RzICps
cnUpDQo+ID4gPiA+ID4gPiArew0KPiA+ID4gPiA+ID4gKwlzdHJ1Y3Qgc2d4X2VwY19wYWdlICp2
aWN0aW07DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArCXNwaW5fbG9jaygmbHJ1LT5sb2Nr
KTsNCj4gPiA+ID4gPiA+ICsJdmljdGltID0gc2d4X29vbV9nZXRfdmljdGltKGxydSk7DQo+ID4g
PiA+ID4gPiArCXNwaW5fdW5sb2NrKCZscnUtPmxvY2spOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4g
PiA+ID4gKwlpZiAoIXZpY3RpbSkNCj4gPiA+ID4gPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJaWYgKHZpY3RpbS0+ZmxhZ3MgJiBTR1hfRVBDX09XTkVS
X1BBR0UpDQo+ID4gPiA+ID4gPiArCQlyZXR1cm4gc2d4X29vbV9lbmNsX3BhZ2UodmljdGltLT5l
bmNsX3BhZ2UpOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKwlpZiAodmljdGltLT5mbGFn
cyAmIFNHWF9FUENfT1dORVJfRU5DTCkNCj4gPiA+ID4gPiA+ICsJCXJldHVybiBzZ3hfb29tX2Vu
Y2wodmljdGltLT5lbmNsKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIGhhdGUgdG8gYnJpbmcg
dGhpcyB1cCwgYXQgbGVhc3QgYXQgdGhpcyBzdGFnZSwgYnV0IEkgYW0gd29uZGVyaW5nICANCj4g
PiA+IHdoeSB3ZSBuZWVkDQo+ID4gPiA+ID4gdG8gcHV0IFZBIGFuZCBTRUNTIHBhZ2VzIHRvIHRo
ZSB1bnJlY2xhaW1hYmxlIGxpc3QsIGJ1dCBjYW5ub3Qga2VlcCAgDQo+ID4gPiBhbg0KPiA+ID4g
PiA+ICJlbmNsYXZlX2xpc3QiIGluc3RlYWQ/DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgbW90aXZh
dGlvbiBmb3IgdHJhY2tpbmcgRVBDIHBhZ2VzIGluc3RlYWQgb2YgZW5jbGF2ZXMgd2FzIHNvIHRo
YXQgIA0KPiA+ID4gdGhlIEVQQw0KPiA+ID4gPiBPT00ta2lsbGVyIGNvdWxkICJraWxsIiBWTXMg
YXMgd2VsbCBhcyBob3N0LW93bmVkIGVuY2xhdmVzLiA+DQo+ID4gPiANCj4gPiA+IEFoIHRoaXMg
c2VlbXMgYSBmYWlyIGFyZ3VtZW50LiA6LSkNCj4gPiA+IA0KPiA+ID4gPiBUaGUgdmlydHVhbCBF
UEMgY29kZQ0KPiA+ID4gPiBkaWRuJ3QgYWN0dWFsbHkga2lsbCB0aGUgVk0gcHJvY2VzcywgaXQg
aW5zdGVhZCBqdXN0IGZyZWVkIGFsbCBvZiB0aGUgIA0KPiA+ID4gRVBDIHBhZ2VzDQo+ID4gPiA+
IGFuZCBhYnVzZWQgdGhlIFNHWCBhcmNoaXRlY3R1cmUgdG8gZWZmZWN0aXZlbHkgbWFrZSB0aGUg
Z3Vlc3QgIA0KPiA+ID4gcmVjcmVhdGUgYWxsIGl0cw0KPiA+ID4gPiBlbmNsYXZlcyAoSUlSQywg
UUVNVSBkb2VzIHRoZSBzYW1lIHRoaW5nIHRvICJzdXBwb3J0IiBsaXZlIG1pZ3JhdGlvbikuDQo+
ID4gPiANCj4gPiA+IEl0IHJldHVybnMgU0lHQlVTLiAgU0dYIFZNIGxpdmUgbWlncmF0aW9uIGFs
c28gcmVxdWlyZXMgZW5vdWdoIEVQQyAgDQo+ID4gPiBiZWluZyBhYmxlIHRvDQo+ID4gPiBiZSBh
bGxvY2F0ZWQgb24gdGhlIGRlc3RpbmF0aW9uIG1hY2hpbmUgdG8gd29yayBBRkFJQ1QuDQo+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+IExvb2tzIGxpa2UgeSdhbGwgcHVudGVkIG9uIHRoYXQgd2l0
aDoNCj4gPiA+ID4gDQo+ID4gPiA+ICAgVGhlIEVQQyBwYWdlcyBhbGxvY2F0ZWQgZm9yIEtWTSBn
dWVzdHMgYnkgdGhlIHZpcnR1YWwgRVBDIGRyaXZlciAgDQo+ID4gPiBhcmUgbm90DQo+ID4gPiA+
ICAgcmVjbGFpbWFibGUgYnkgdGhlIGhvc3Qga2VybmVsIFs1XS4gVGhlcmVmb3JlIHRoZXkgYXJl
IG5vdCB0cmFja2VkICANCj4gPiA+IGJ5IGFueQ0KPiA+ID4gPiAgIExSVSBsaXN0cyBmb3IgcmVj
bGFpbWluZyBwdXJwb3NlcyBpbiB0aGlzIGltcGxlbWVudGF0aW9uLCBidXQgdGhleSAgDQo+ID4g
PiBhcmUNCj4gPiA+ID4gICBjaGFyZ2VkIHRvd2FyZCB0aGUgY2dyb3VwIG9mIHRoZSB1c2VyIHBy
b2Nlc3NzIChlLmcuLCBRRU1VKSAgDQo+ID4gPiBsYXVuY2hpbmcgdGhlDQo+ID4gPiA+ICAgZ3Vl
c3QuICBBbmQgd2hlbiB0aGUgY2dyb3VwIEVQQyB1c2FnZSByZWFjaGVzIGl0cyBsaW1pdCwgdGhl
ICANCj4gPiA+IHZpcnR1YWwgRVBDDQo+ID4gPiA+ICAgZHJpdmVyIHdpbGwgc3RvcCBhbGxvY2F0
aW5nIG1vcmUgRVBDIGZvciB0aGUgVk0sIGFuZCByZXR1cm4gU0lHQlVTICANCj4gPiA+IHRvIHRo
ZQ0KPiA+ID4gPiAgIHVzZXIgcHJvY2VzcyB3aGljaCB3b3VsZCBhYm9ydCB0aGUgVk0gbGF1bmNo
Lg0KPiA+ID4gPiANCj4gPiA+ID4gd2hpY2ggSU1PIGlzIGEgaGFjaywgdW5sZXNzIHJldHVybmlu
ZyBTSUdCVVMgaXMgYWN0dWFsbHkgZW5mb3JjZWQgIA0KPiA+ID4gc29tZWhvdy4gPg0KPiA+ID4g
DQo+ID4gPiAiZW5mb3JjZWQiIGRvIHlvdSBtZWFuPw0KPiA+ID4gDQo+ID4gPiBDdXJyZW50bHkg
dGhlIHNneF92ZXBjX2ZhdWx0KCkgcmV0dXJucyBWTV9GQVVMVF9TSUdCVVMgd2hlbiBpdCBjYW5u
b3QgIA0KPiA+ID4gYWxsb2NhdGUNCj4gPiA+IEVQQyBwYWdlLiAgQW5kIHdoZW4gdGhpcyBoYXBw
ZW5zLCBLVk0gcmV0dXJucyBLVk1fUEZOX0VSUl9GQVVMVCBpbiAgDQo+ID4gPiBodmFfdG9fcGZu
KCksDQo+ID4gPiB3aGljaCBldmVudHVhbGx5IHJlc3VsdHMgaW4gS1ZNIHJldHVybmluZyAtRUZB
VUxUIHRvIHVzZXJzcGFjZSBpbiAgDQo+ID4gPiB2Y3B1X3J1bigpLg0KPiA+ID4gQW5kIFFlbXUg
dGhlbiBraWxscyB0aGUgVk0gd2l0aCBzb21lIG5vbnNlbnNlIG1lc3NhZ2U6DQo+ID4gPiANCj4g
PiA+ICAgICAgICAgZXJyb3I6IGt2bSBydW4gZmFpbGVkIEJhZCBhZGRyZXNzDQo+ID4gPiAgICAg
ICAgIDxkdW1wIGd1ZXN0IHJlZ2lzdGVycyBub25zZW5zZT4NCj4gPiA+IA0KPiA+ID4gPiBSZWx5
aW5nDQo+ID4gPiA+IG9uIHVzZXJzcGFjZSB0byBiZSBraW5kIGVub3VnaCB0byBraWxsIGl0cyBW
TXMga2luZGEgZGVmZWF0cyB0aGUgIA0KPiA+ID4gcHVycG9zZSBvZiBjZ3JvdXANCj4gPiA+ID4g
ZW5mb3JjZW1lbnQuICBFLmcuIGlmIHRoZSBoYXJkIGxpbWl0IGZvciBhIEVQQyBjZ3JvdXAgaXMg
bG93ZXJlZCwgIA0KPiA+ID4gdXNlcnNwYWNlIHJ1bm5pbmcNCj4gPiA+ID4gZW5jYWx2ZXMgaW4g
YSBWTSBjb3VsZCBjb250aW51ZSBvbiBhbmQgcmVmdXNlIHRvIGdpdmUgdXAgaXRzIEVQQywgYW5k
ICANCj4gPiA+IHRodXMgcnVuIGFib3ZlDQo+ID4gPiA+IGl0cyBsaW1pdCBpbiBwZXJwZXR1aXR5
Lg0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGNhbiBzZWUgdXNlcnNwYWNlIHdhbnRpbmcg
dG8gZXhwbGljaXRseSB0ZXJtaW5hdGUgdGhlIFZNIGluc3RlYWQgb2YgIA0KPiA+ID4gInNpbGVu
dGx5Ig0KPiA+ID4gPiB0aGUgVk0ncyBlbmNsYXZlcywgYnV0IHRoYXQgc2VlbXMgbGlrZSBpdCBz
aG91bGQgYmUgYSBrbm9iIGluIHRoZSAgDQo+ID4gPiB2aXJ0dWFsIEVQQw0KPiA+ID4gPiBjb2Rl
Lg0KPiA+IA0KPiA+IEkgZ3Vlc3MgSSBzbGlnaHRseSBtaXN1bmRlcnN0b29kIHlvdXIgd29yZHMu
DQo+ID4gDQo+ID4gWW91IG1lYW4gd2Ugd2FudCB0byBraWxsIFZNIHdoZW4gdGhlIGxpbWl0IGlz
IHNldCB0byBiZSBsb3dlciB0aGFuICANCj4gPiB2aXJ0dWFsIEVQQw0KPiA+IHNpemUuDQo+ID4g
DQo+ID4gVGhpcyBwYXRjaCBhZGRzIFNHWF9FTkNMX05PX01FTU9SWS4gIEkgZ3Vlc3Mgd2UgY2Fu
IHVzZSBpdCBmb3IgdmlydHVhbCAgDQo+ID4gRVBDIHRvbz8NCj4gPiANCj4gDQo+IFRoYXQgZmxh
ZyBpcyBzZXQgZm9yIGVuY2xhdmVzLCBkbyB5b3UgbWVhbiB3ZSBzZXQgc2ltaWxhciBmbGFnIGlu
IHZlcGMgIA0KPiBzdHJ1Y3Q/DQo+IA0KPiA+IEluIHRoZSBzZ3hfdmVwY19mYXVsdCgpLCB3ZSBj
aGVjayB0aGlzIGZsYWcgYXQgZWFybHkgdGltZSBhbmQgcmV0dXJuICANCj4gPiBTSUdCVVMgaWYN
Cj4gPiBpdCBpcyBzZXQuDQo+ID4gDQo+ID4gQnV0IHRoaXMgYWxzbyByZXF1aXJlcyBrZWVwaW5n
IHZpcnR1YWwgRVBDIHBhZ2VzIGluIHNvbWUgbGlzdCwgYW5kICANCj4gPiBoYW5kbGVzIHRoZW0N
Cj4gPiBpbiBzZ3hfZXBjX29vbSgpIHRvby4NCj4gPiANCj4gPiBBbmQgZm9yIHZpcnR1YWwgRVBD
IHBhZ2VzLCBJIGd1ZXNzIHRoZSAieW91bmciIGxvZ2ljIGNhbiBiZSBhcHBsaWVkIHRodXMNCj4g
PiBwcm9iYWJseSBpdCdzIGJldHRlciB0byBrZWVwIHRoZSBhY3R1YWwgdmlydHVhbCBFUEMgcGFn
ZXMgdG8gYSAgDQo+ID4gKHNlcGFyYXRlPykgbGlzdA0KPiA+IGluc3RlYWQgb2Yga2VlcGluZyB0
aGUgdmlydHVhbCBFUEMgaW5zdGFuY2UuDQo+ID4gDQo+ID4gCXN0cnVjdCBzZ3hfZXBjX2xydSB7
DQo+ID4gCQlzdHJ1Y3QgbGlzdF9oZWFkIHJlY2xhaW1hYmxlOw0KPiA+IAkJc3RydWN0IHNneF9l
bmNsICplbmNsYXZlczsNCj4gPiAJCXN0cnVjdCBsaXN0X2hlYWQgdmVwY19wYWdlczsNCj4gPiAJ
fQ0KPiA+IA0KPiA+IE9yIHN0aWxsIHRyYWNraW5nIFZBL1NFQ1MgYW5kIHZpcnR1YWwgRVBDIHBh
Z2VzIGluIGEgc2luZ2xlICANCj4gPiB1bnJlY2xpYW1hYmxlIGxpc3Q/DQo+ID4gDQo+IA0KPiBP
bmUgTFJVIHNob3VsZCBiZSBPSyBhcyB3ZSBvbmx5IG5lZWQgcmVsYXRpdmUgb3JkZXIgaW4gd2hp
Y2ggdGhleSBhcmUgIA0KPiBsb2FkZWQ/DQoNCkl0J3Mgb25lIHdheSB0byBkbywgYnV0IG5vdCB0
aGUgb25seSB3YXkuDQoNClRoZSBkaXNhZHZhbnRhZ2Ugb2YgdXNpbmcgb25lIHVucmVjbGFpbWFi
bGUgbGlzdCBpcywgZm9yIFZBL1NFQ1MgcGFnZXMgeW91IGRvbid0DQpoYXZlIHRoZSBjb25jZXB0
IG9mICJ5b3VuZy9hZ2UiLiAgVGhlIG9ubHkgcHVycG9zZSBvZiBnZXR0aW5nIHRoZSBwYWdlIGlz
IHRvIGdldA0KdGhlIG93bmVyIGVuY2xhdmUgYW5kIGtpbGwgaXQuDQoNCk9uIHRoZSBvdGhlciBo
YW5kLCBmb3IgdmlydHVhbCBFUEMgcGFnZXMgd2UgZG8gaGF2ZSBjb25jZXB0IG9mICJ5b3VuZy9h
Z2UiLA0KYWx0aG91Z2ggSSB0aGluayBpdCdzIGFjY2VwdGFibGUgd2UgZG9uJ3QgaW1wbGVtZW50
IHRoaXMgaW4gdGhlIGZpcnN0IHZlcnNpb24gb2YNCkVQQyBjZ3JvdXAgc3VwcG9ydC4NCg0KRnJv
bSB0aGlzIHBvaW50LCBwZXJoYXBzIGl0J3MgYmV0dGVyIHRvICBtYWludGFpbiBWQS9TRUNTIChv
ciBlbmNsYXZlcykNCnNlcGFyYXRlbHkgZnJvbSB2aXJ0dWFsIEVQQyBwYWdlcy4gIEJ1dCBpdCBp
cyBub3QgbWFuZGF0b3J5Lg0KDQpBbm90aGVyIHBybyBvZiBtYWludGFpbmluZyB0aGVtIHNlcGFy
YXRlbHkgaXMgeW91IGRvbid0IG5lZWQgdGhlc2UgZmxhZ3MgdG8NCmRpc3Rpbmd1aXNoIHRoZW0g
ZnJvbSB0aGUgc2luZ2xlIGxpc3Q6IFNHWF9FUENfT1dORVJfe0VOQ0x8UEFHRXxWRVBDfSwgd2hp
Y2ggSQ0KZGlzbGlrZS4NCg0KKGJ0dywgZXZlbiB5b3UgdHJhY2sgVkEvU0VDUyBwYWdlcyBpbiB1
bnJlY2xhaW1hYmxlIGxpc3QsIGdpdmVuIHRoZXkgYm90aCBoYXZlDQonZW5jbGF2ZScgYXMgdGhl
IG93bmVyLCAgZG8geW91IHN0aWxsIG5lZWQgU0dYX0VQQ19PV05FUl9FTkNMIGFuZA0KU0dYX0VQ
Q19PV05FUl9QQUdFID8pDQoNClRoYXQgYmVpbmcgc2FpZCwgcGVyc29uYWxseSBJJ2Qgc2xpZ2h0
bHkgcHJlZmVyIHRvIGtlZXAgdGhlbSBpbiBzZXBhcmF0ZSBsaXN0cw0KYnV0IEkgY2FuIHNlZSBp
dCBhbHNvIGRlcGVuZHMgb24gaG93IHlvdSB3YW50IHRvIGltcGxlbWVudCB0aGUgYWxnb3JpdGht
IG9mDQpzZWxlY3RpbmcgYSB2aWN0aW0uICBTbyBJIGFtIG5vdCBnb2luZyB0byBpbnNpc3QgZm9y
IG5vdyBidXQgd2lsbCBsZWF2ZSB0byB5b3UNCnRvIGRlY2lkZS4NCg0KSnVzdCByZW1lbWJlciB0
byBnaXZlIGp1c3RpZmljYXRpb24gb2YgY2hvb3Npbmcgc28uDQoNClsuLi5dDQoNCj4gSXQgYWxz
byBtZWFucyB1c2VyICANCj4gc3BhY2UgbmVlZHMgdG8gaW5qZWN0L3Bhc3MgdGhlIFNJR0JVUyB0
byBndWVzdCAoSSdtIG5vdCByZWFsbHkgZmFtaWxpYXIgIA0KPiB3aXRoIHRoaXMgcGFydCwgb3Ig
bWF5YmUgaXQncyBhbHJlYWR5IHRoZXJlPykuIEBzZWFuIGlzIHRoYXQgd2hhdCB5b3UgIA0KPiBt
ZWFuPyBTb3JyeSBJJ3ZlIGJlZW4gc2xvdyBvbiB1bmRlcnN0YW5kaW5nIHRoaXMuDQoNCkkgZG9u
J3QgdGhpbmsgd2UgbmVlZCB0byBkbyB0aGlzIGZvciBub3cuICBLaWxsaW5nIHRoZSBWTSBpcyBh
biBhY2NlcHRhYmxlIHN0YXJ0DQp0byBtZS4gIEp1c3QgbWFrZSBzdXJlIHdlIGNhbiBraWxsIHNv
bWUgVk0uDQoNCg==
