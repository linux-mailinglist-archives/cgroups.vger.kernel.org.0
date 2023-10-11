Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496FE7C46B7
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 02:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbjJKAcK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 20:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344712AbjJKAcB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 20:32:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9BB7;
        Tue, 10 Oct 2023 17:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696984301; x=1728520301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i53T9Jp8FGKIUFp5G8vOBD/CyGo195lMMnuK2gDeIVI=;
  b=HYLEHUdVNuRlABPKxMp77RTdoOD+ZBvV+aM9m7s/QbmUKpbFvQn0hYI9
   Az2DSLELXpcJ5KG4ErnI0nXh1vLtgv3oOAbeukAKaFS85bmoLmTulg5zw
   /7vPyyW0NCCIex22OS6XpitviEWYJ386Fo6PMsKF9kyo1sKvbwkpXwTzB
   gdsveLNCMGFfaqxtaZsTSUCqGo4WKshZaD9lLQsbdDKeHs+v+m+dwCn4C
   A8p2F8jJs5QQqrvSfzsk2dHfuuEclaBGy+PKGeNkQEHVQBV5oK4Gfms2w
   7FpFpi7tt3b1yrozwn2rI8ucIl780KoEPstUv3LauZKPFsqEcKTbBEEvz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="384403743"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="384403743"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 17:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="757331752"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="757331752"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 17:31:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 17:31:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 17:31:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 17:31:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 17:31:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctgvXMuomoapDM4lKzKm7jhMcP7ol+4wHqdKpR8aGlvilJbA6AiiBwDoX7MqWa2/vN6LDudx+iEcJtnUDaLbVB1rErUkQ+VvWneeC3qfJSYhCYZAa/EAgrwgwHWlAqCsxayKlAdufjyOMR7zMgV5yetkgR44PxtoyrCArgHTFntux5oSJYC+SXVYHERa1di/DYr4UYp6LqmCPHlNPb9f91loSg7XENZb+ctLmq9GtfEu9TEHCdBJ9croIdyuBXilYkyn9DY5GJJbrJ2/pILaw26RmHlv5aTrlqFf88IfihUMenYrSP2M7dUkgLftP+QyXOdSYMGrsIdDCVtSbdj6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i53T9Jp8FGKIUFp5G8vOBD/CyGo195lMMnuK2gDeIVI=;
 b=B5mYf4T4CJ+45H7L6SEG4SwKphUmNAEmdBDbVpWW+0oZZqzX0kZv2Zi572f/9kH3pJECzIB8XZsToFd2ZYxUgCoKCKBB0oMygJxbW43WdHG709zySVVUgY1YsRrX/xFcO9VLFZA5WOYPEXhax59Bz8u+LHVdiMpSkSRu5K+1P6w1GKS0fYN2ghp324OYbLEfr5dIVbcIbdG5hGMnF+2YKELBN1nw8rgtp4wo4menP1+294DxYuWBJYwuIoM3GRc/5ccq5NVgwicw2XWImgm191DIeAclRsviVVYIeJM9JW8IJh7i8sGsX5a6KtWKC1mVfLYWae5+lKowMEzfR5Kq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY5PR11MB6305.namprd11.prod.outlook.com (2603:10b6:930:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 00:31:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Wed, 11 Oct 2023
 00:31:19 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Mehta, Sohil" <sohil.mehta@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        "Zhang, Bo" <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Topic: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim
 EPC
Thread-Index: AQHZ7csZABE+dkJZZkCdCB4gngYcNbBCOacAgAAWUQCAAAOmAIAABagAgAAJjYCAAPmHgIAAfI6A
Date:   Wed, 11 Oct 2023 00:31:19 +0000
Message-ID: <8593359034d9173be5efd9c055ea782e44fbcdad.camel@intel.com>
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
         <20230923030657.16148-13-haitao.huang@linux.intel.com>
         <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
         <op.2ckqmgs9wjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <fc6aa778ddbde9536cafe48b847cf6c45b640ea4.camel@intel.com>
         <op.2ckr5yetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
         <badbe0da60a2b35e8eace98714c6f7d4bcd6f202.camel@intel.com>
         <op.2cly3ffmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2cly3ffmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY5PR11MB6305:EE_
x-ms-office365-filtering-correlation-id: 6bcccb06-e0ee-41ae-37ef-08dbc9f16386
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ScXLRTjrRA/nkcM7mMTlmqmfBT/9m7vR/aw6FUGyUtg13/3A3zABxBXR+dY9eCVmJ4CvW8EMKOfwW/vobEX0BDb/PjNTyXmkkYqgnhOAjVXXaNm8bTnZMV7tY2GdfOc2CaZdiZU3IxFb1DrlUyjzY+8m2F1G92Ukjza1rh3zp8ZBQWXmrtmV5lrjcS7a1uBNa/pC0lJRwkLeai7iZUzoO2qk8J64uZgH9/c7/Go+gqo6nq/Bg9bGnJ4gZJXm3GpA4G9Rp1GKCQvZegUX9CMuMzbFChteJYzUStswGb0L+vguHF4agRO6SmL2dJfClziLnVac/7sVd7lqPvWc9yREG96tub/fb1X0biLEpHO+jvEaILicLMjdnLZLSlW3sheaIJSJMOfTTa/FkMeesRbMnfWN44MnKeOrjhF490QEXoFY1oVAjToXNh+aj+xkMWphAKUQNIvd5dKPbCC0FiBYYYJ92ANZYFFRksJFBgLanJH39OaFDjqjoI/SOxqkN4fF6h4YMxDxCIpDUwapsTJ8qcdBP5bOMdvcS4xNJlyQQtAYH8ViUfkVVejWrvh0B6oJKza5QMYF1qHGJ0+q9vvXg+vFysLuJe0PT1Wjgj+TFfht51sI4KvzljSnc22hDYYRBzuTLjxFy1BIZDfSfcUbPEd811RomduzVFa+WdI2tXw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(86362001)(36756003)(38070700005)(6506007)(6512007)(6486002)(4001150100001)(64756008)(478600001)(7416002)(2906002)(2616005)(66446008)(66946007)(66476007)(91956017)(66556008)(41300700001)(110136005)(5660300002)(966005)(71200400001)(76116006)(316002)(54906003)(26005)(4326008)(8676002)(8936002)(122000001)(82960400001)(38100700002)(921005)(87590200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnJONUFtcE1ZcnQ3Wm1SQVpTUzl4ZHk1amU2KzZmSytNNkVuNlB0eGVaVmdF?=
 =?utf-8?B?WFhxV2tTQVFYN3dwR1RWZGFtTEJXbXlSSWVQS0xRaXIxZzhTb0FOS3NtRFNy?=
 =?utf-8?B?OGI4ZnNjcDlhdnQrcmtZVDVwSnN4clJKaUdGWGYzSWdzMEQyaFRVelpXMDVV?=
 =?utf-8?B?UTFZMVg5M0UwTmxPbkVXYWt4MlRna1lLVUsrZ2Q1ekRpRnhQSEFXemJDSE84?=
 =?utf-8?B?NFo1ZjFVZWgxUnMvVWV1TWw5dzlsUW5ZZ1VJa21taHNQNFB0eDNMejM4K3lR?=
 =?utf-8?B?UG56RjNZekp0bnRVamJid21UYXpvTXZUaXZwbU91eXFKcy9PUE5ERDlIWXFI?=
 =?utf-8?B?cm4wYzdHaGtudGVaWHIxeEcyNEliemtSbndhV0ZFdGdlaFAreDlCRnI1Q0hT?=
 =?utf-8?B?ZXZaVFZaMVN5WlVvL3Z0T3V5a3lJL0YxdUV2M2ZHUEo2bEhDMFlVUURXV0sy?=
 =?utf-8?B?a2ZGZjI5c3I5bU80WnBRc3VIeGJRUUlIdEJyc3RzT0RyU1lJcUZKOUJCeDNy?=
 =?utf-8?B?R1h0YmloRVp0cmJBZW9UcmwvQ2FYTGZ2dVFhWENna1A0RW11cjFHcTQ0OFg0?=
 =?utf-8?B?eHpEV2IxWFdOWWtJc2dkd0JRcVhrUGk3MlA5TmdYcVNJMVZxd3hQdDV4NmYr?=
 =?utf-8?B?WnBqc2toZ1ltQTREV2d2bzVaZ1RvcVh6Ykh6Q0RDdytqVjBtb1RRa1NCNHJq?=
 =?utf-8?B?UndSWCtnbHZGdXp3RmtzZTl1a2d0RC9ObENyTTNFTURIc0hsbVJhL3QzUml1?=
 =?utf-8?B?aGVGNzFJUjJKVGFxb21YL0NXQWMrSlZOQTEzQkRMZHJ0VVhqcG04Y01hVlJS?=
 =?utf-8?B?VUN1dVpKcEZaY0plVnJiVUxoeTBGbG1SZHlyeDJ0ZVBxTWFBSHU3ekRsRjJV?=
 =?utf-8?B?R1lpRjdobHc4dnFMdExLVTF1UlZ1ZmJVYWtaWldOVTVOdGc0bGR2YmJMUUtQ?=
 =?utf-8?B?QkwzOWJ2VklGN212REpTR3lSNWhkeXBoMlNjTzQ5ZTBBVTMwQUdyK0lKSGcw?=
 =?utf-8?B?bUlMcTJVaGpycXZRZzd3aCtSeXdvdHlKQlNvQU5pMHh2c0ZjNEVWOW81RDcy?=
 =?utf-8?B?cTZ5WkFZT2YzOWR2RkdCNmtTZjAzNlpQQkcvbmxvSDhvYTRiTkFtc01Db2ZL?=
 =?utf-8?B?M3ZMMjBzTnVWS0pGV3RNNHRabjc3SDZFK2I0YkpVU0pMeGRoZExJVi9SaWJo?=
 =?utf-8?B?OU5sMmxmVWcyWWl2TU82aWtHdzQycDIyN2ZEVE5PZ2xWV2pqa0FHQUV2b3dK?=
 =?utf-8?B?b2lWWUtUckJXUkhxeEJhZWFJMXNXbnRiRXhJVzFLazMrTmZFRDVzWkc5WGtM?=
 =?utf-8?B?NTlrZTNVU3gzclZVZlg3OHJxcnE3MzNnWXJmaDVhZ1NtaFN1czA1SUI4eWNn?=
 =?utf-8?B?OE5hTTJjc0xFMVdvNkRJTnZMZU15Q2MvTUk4d24rNUl4TWpRSFBGL0VpL2tH?=
 =?utf-8?B?L3Axb203ZnpTdmxwWU9LcUNQczd3NCtaUXFnNm5TOENVUzhZQTJHUjd3bGJK?=
 =?utf-8?B?Y0RJMWw0REF1LzF4Yk5SOVdwMlg4TGI3ekZySlhBUzg3U3Jkb1BpMlJmVUR2?=
 =?utf-8?B?a1pTaXNKZXUwZ0xBbHg3a3ZjMTZrL2g1YU80aTFBZW5NcVh2dENmbDg1b2F0?=
 =?utf-8?B?Q0VpVkxDSUpUMmtLZXVaRVdPS0FudkplVGFVZGgwQzhScEU4QnRLN21qNzVV?=
 =?utf-8?B?MS9LeVZYcFR2cTNvYkRlUXlCRkkwRm91dHFINVV2QWVlNHNVcTA3T0grMXM3?=
 =?utf-8?B?a2doS2xVVFoveU0vNHV2eHJsdTdHVlFUeVBRK2h6Y0JseCtlQ2RNaWpoZjZt?=
 =?utf-8?B?a2ZwMzdpV2pvRkQ5UjdGY1NCazNZbmR6TzFubCtsVTlDZkFSOStGOTNGRlhC?=
 =?utf-8?B?OWxic0ExLzBNdFFNYkFxeW9JM0x1MVJ3T0dGZFlPaWZXeXRzcmFnMkF2WW50?=
 =?utf-8?B?SlpaZlcrS1U5ai9IWWhyYXN4R21WWFVHRmp4NUZGd0pRN0M3TzUwaGdzTTBi?=
 =?utf-8?B?Mzg0TGxYNEYvc0UyTU1zSS9Yekd4UkFjdnJnRHo5L3ZobzVwYlZieXN2eFhi?=
 =?utf-8?B?T2hDYTQxTUVFSXl5cHU3clpNK0VPWnNGaU9xZzQxT0ZCVlNOU3lXRDgyaHFR?=
 =?utf-8?B?WFl6VzEwT2JZRWV6alRZQ2YvWExySEtNKzBLaFp2YWk2WDBJSU9rMTRjQ3Nn?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08B2FC4A2C4F7845963984177197002A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcccb06-e0ee-41ae-37ef-08dbc9f16386
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 00:31:19.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sshFtkq7WqlNhTTtJesYxt101EfBYfZPvfN2rpsjLNACTPsd1dDxvDsIeGGb07uC7gkpRTrJevdiZxGTUZ/GXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6305
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

T24gVHVlLCAyMDIzLTEwLTEwIGF0IDEyOjA1IC0wNTAwLCBIYWl0YW8gSHVhbmcgd3JvdGU6DQo+
IE9uIE1vbiwgMDkgT2N0IDIwMjMgMjE6MTI6MjcgLTA1MDAsIEh1YW5nLCBLYWkgPGthaS5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IExh
dGVyIHRoZSBob3N0aW5nIHByb2Nlc3MgY291bGQgbWlncmF0ZWQvcmVhc3NpZ25lZCB0byBhbm90
aGVyICANCj4gPiA+IGNncm91cD8NCj4gPiA+ID4gPiBXaGF0IHRvIGRvIHdoZW4gdGhlIG5ldyBj
Z3JvdXAgaXMgT09NPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gWW91IGFkZHJlc3Nl
ZCBpbiB0aGUgZG9jdW1lbnRhdGlvbiwgbm8/DQo+ID4gPiA+IA0KPiA+ID4gPiArTWlncmF0aW9u
DQo+ID4gPiA+ICstLS0tLS0tLS0NCj4gPiA+ID4gKw0KPiA+ID4gPiArT25jZSBhbiBFUEMgcGFn
ZSBpcyBjaGFyZ2VkIHRvIGEgY2dyb3VwIChkdXJpbmcgYWxsb2NhdGlvbiksIGl0DQo+ID4gPiA+
ICtyZW1haW5zIGNoYXJnZWQgdG8gdGhlIG9yaWdpbmFsIGNncm91cCB1bnRpbCB0aGUgcGFnZSBp
cyByZWxlYXNlZA0KPiA+ID4gPiArb3IgcmVjbGFpbWVkLiAgTWlncmF0aW5nIGEgcHJvY2VzcyB0
byBhIGRpZmZlcmVudCBjZ3JvdXAgZG9lc24ndA0KPiA+ID4gPiArbW92ZSB0aGUgRVBDIGNoYXJn
ZXMgdGhhdCBpdCBpbmN1cnJlZCB3aGlsZSBpbiB0aGUgcHJldmlvdXMgY2dyb3VwDQo+ID4gPiA+
ICt0byBpdHMgbmV3IGNncm91cC4NCj4gPiA+IA0KPiA+ID4gU2hvdWxkIHdlIGtpbGwgdGhlIGVu
Y2xhdmUgdGhvdWdoIGJlY2F1c2Ugc29tZSBWQSBwYWdlcyBtYXkgYmUgaW4gdGhlICANCj4gPiA+
IG5ldw0KPiA+ID4gZ3JvdXA/DQo+ID4gPiANCj4gPiANCj4gPiBJIGd1ZXNzIGFjY2VwdGFibGU/
DQo+ID4gDQo+ID4gQW5kIGFueSBkaWZmZXJlbmNlIGlmIHlvdSBrZWVwIFZBL1NFQ1MgdG8gdW5y
ZWNsYWltYWJlIGxpc3Q/DQo+IA0KPiBUcmFja2luZyBWQS9TRUNTIGFsbG93cyBhbGwgY2dyb3Vw
cywgaW4gd2hpY2ggYW4gZW5jbGF2ZSBoYXMgYWxsb2NhdGlvbiwgIA0KPiB0byBpZGVudGlmeSB0
aGUgZW5jbGF2ZSBmb2xsb3dpbmcgdGhlIGJhY2sgcG9pbnRlciBhbmQga2lsbCBpdCBhcyBuZWVk
ZWQuDQo+IA0KPiA+IElmIHlvdSBtaWdyYXRlIG9uZQ0KPiA+IGVuY2xhdmUgdG8gYW5vdGhlciBj
Z3JvdXAsIHRoZSBvbGQgRVBDIHBhZ2VzIHN0YXkgaW4gdGhlIG9sZCBjZ3JvdXAgIA0KPiA+IHdo
aWxlIHRoZQ0KPiA+IG5ldyBvbmUgaXMgY2hhcmdlZCB0byB0aGUgbmV3IGdyb3VwIElJVUMuDQo+
ID4gDQo+ID4gSSBhbSBub3QgY2dyb3VwIGV4cGVydCwgYnV0IGJ5IHNlYXJjaGluZyBzb21lIG9s
ZCB0aHJlYWQgaXQgYXBwZWFycyB0aGlzICANCj4gPiBpc24ndCBhDQo+ID4gc3VwcG9ydGVkIG1v
ZGVsOg0KPiA+IA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvWUV5UjkxODFRZ3p0
K1BzOUBtdGouZHVja2Rucy5vcmcvDQo+ID4gDQo+IA0KPiBJSVVDIGl0J3MgYSBkaWZmZXJlbnQg
cHJvYmxlbSBoZXJlLiBJZiB3ZSBkb24ndCB0cmFjayB0aGUgYWxsb2NhdGVkIFZBcyBpbiAgDQo+
IHRoZSBuZXcgZ3JvdXAsIHRoZW4gdGhlIGVuY2xhdmUgdGhhdCBzcGFucyB0aGUgdHdvIGdyb3Vw
cyBjYW4ndCBiZSBraWxsZWQgIA0KPiBieSB0aGUgbmV3IGdyb3VwLiBJZiBzbywgc29tZSBlbmNs
YXZlIGNvdWxkIGp1c3QgaGlkZSBpbiBzb21lIHNtYWxsIGdyb3VwICANCj4gYW5kIG5ldmVyIGdl
dHMga2lsbGVkIGJ1dCBrZWVwcyBhbGxvY2F0aW5nIGluIGEgZGlmZmVyZW50IGdyb3VwPw0KPiAN
Cg0KSSBtZWFuIGZyb20gdGhlIGxpbmsgYWJvdmUgSUlVQyBtaWdyYXRpbmcgZW5jbGF2ZSBhbW9u
ZyBkaWZmZXJlbnQgY2dyb3VwcyBzaW1wbHkNCmlzbid0IGEgc3VwcG9ydGVkIG1vZGVsLCB0aHVz
IGFueSBiYWQgYmVoYXZpb3VyIGlzbid0IGEgYmlnIGNvbmNlcm4gaW4gdGVybXMgb2YNCmRlY2lz
aW9uIG1ha2luZy4NCg==
