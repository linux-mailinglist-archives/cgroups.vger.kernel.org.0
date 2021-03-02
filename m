Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCFC32B219
	for <lists+cgroups@lfdr.de>; Wed,  3 Mar 2021 04:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbhCCAwY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Mar 2021 19:52:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:28939 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350926AbhCBM7K (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 2 Mar 2021 07:59:10 -0500
IronPort-SDR: 2KAnGWwxIVgbWy+nW196jdfLDqLY6llN2489nJs5/U40C9/YlK4WcmLfTdlUymUxZmMtpakV1L
 7GtbFYZYkelA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="174434441"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="174434441"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 04:58:10 -0800
IronPort-SDR: aOyLQOs8PqzZNmM4QLuBHkfOufrNwnFdmRSPX6RR02p2hQSmVAoRPQIzrUSO9H2zQLhL2Cv6Pt
 YPFarVhybB+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406695825"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2021 04:58:09 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Mar 2021 04:58:09 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Mar 2021 04:58:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 2 Mar 2021 04:58:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 2 Mar 2021 04:58:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKyb94Y2vgU0vkTRYOp8H498fvRbMYvSEJ9WMOOAjCWRTAmm4jPSku2t8xzBQrWiVZ/8ey++88RlRLcznk3fAXJgiC9WJY1NALkJGqK7JRG5h7Ep03LqJ8f3AWbhqXGpsqiMCE72ncQIEcCnXCdrYpBtY6POkxGpuUTzRyj/rYbQaIMDowVPnhz4wuzVt8RKNsEmzypFFon/bhaIb5cCSWE+TIibahLbPolyrQw8KaeBXkpAsT0HNk3PM8/exI9WJFgg1Ych9shGQIpiCfWSEhW6fFhZORSFOTt4axjGqDgWI0kKIAZlve8jnRXSULkJuOddjeLrzSXQG1WefzT7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EABkFu3+j2V5WDiRXC0f/ppojwIHN02YS+GxyGKV6cA=;
 b=Ue4xGDbZbE5KIBsf+orOmBRwNAj8ewCxvl0ciJnyP60FPU4gAct9DcY4lcIXz63Ba633AaiTfuYODzSuzkifpGlhG5YlW3OvsqG5K9UHJIyYX+oLC27Kr0bSQus2ZHbkGP1N66bsWxHUth3TeNPon8vPHC28C/nH5L5HphVxJePkPfGSDiYRJzw+2rqzffIs3lSe6TM+yBsP7G929tWiyb7cxbt5PWsRYfvdEURUnuH/RqQZw9RXPjJRjR6DkEYUG1DjeohCeDWjV7KKQ9WkG+MpwI1jgpy6/H/SIOxHk6B/w67qt0PiibpdZWsPw+shOg5/7/2Ql9vKaVeTHOTfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EABkFu3+j2V5WDiRXC0f/ppojwIHN02YS+GxyGKV6cA=;
 b=g4PqHbpWP7IXc99b0R9W0Z1WhQHIi2+YAUkgcVUkGtCFzKClYU3fxEUCHYpSw24P1EGD338fqVmBQZW9gUpMoYZCPc+PwQ87ERBUUUsAy5dZjug0917o9Fi2xl/fpEL/OZ7Z72jLjTgDR2h1aQpoWuJdmfVKZdYnOnbTuwoJomQ=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN8PR11MB3601.namprd11.prod.outlook.com (2603:10b6:408:84::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 12:58:06 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3912.017; Tue, 2 Mar 2021
 12:58:05 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 00/18] IOASID extensions for guest SVA
Thread-Topic: [PATCH V4 00/18] IOASID extensions for guest SVA
Thread-Index: AQHXDZuqHEV3IilLX0uOrgGtapPnEKpwq4EQ
Date:   Tue, 2 Mar 2021 12:58:05 +0000
Message-ID: <BN6PR11MB406867D75E42A34F8C2555E5C3999@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d344a3b6-3f87-4487-a6c7-08d8dd7ad227
x-ms-traffictypediagnostic: BN8PR11MB3601:
x-ms-exchange-minimumurldomainage: github.com#4893
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR11MB3601DF935CE15B8834C4F18FC3999@BN8PR11MB3601.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKdSGsMQKoz7MbihRXE5gg+aipHLNTDzzKMHZPf76v9YNGNxLai1s0ggxIQE2snCBNrXDor+G2+DNv0cnRcAo4TAnYAkxorYsDEmRbQubjUYDDVtinHfOQC9fBznPXf9wMFsTDTB1wvfTePMlJymJoVicZosf1nDJNtTP+PQLtBScbeevEeiBENmXEOo7wOYe3rZEEYbLIXPjFNSHIyd1QG3fP9pp+aE9KNnMMX2TRTr4BZhLum2M8oZZo7KmUgWZlvBPFsI/FfcZSmzICuUIN2bIZHDKTtXhFaT7n+qmI7OrtdHm8dVPw65eiTx4bxDSvPAMZuMuMD4yYOAr5k19LYNNu7MNKp8QBQ5l8LJ5PZ3+TcdfdnDi/6xuMTO+hNADY9Tx02UrkOWr4lrEyR0GdOePbgh+XerDb0nm84lbNh4D6DwwMxVHbTxPOFR3jQmUfImg35lLypN9MCDaNkKcsRzOiQtRCH4mZ+5imG5Z5PxH9nyp+0qeJQ+jQ1TlulMqgTNU21o6KEI6Bo4JkCV0PUvlIjXHlsr9C0vATbdi48KNKTW1CUmFGWqc6sPjjDvBphk6Tu8JqmHv9rbstebNwh8Y06ZF1BLT4WthgUh5xjKU7KtVGT7rYlLnhclF40j8JtxRZmGRdKKtV82RzDl+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4068.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(7696005)(83380400001)(921005)(8936002)(5660300002)(86362001)(66946007)(6506007)(66446008)(66476007)(66556008)(64756008)(52536014)(33656002)(966005)(110136005)(186003)(71200400001)(26005)(4326008)(316002)(478600001)(54906003)(2906002)(8676002)(76116006)(9686003)(55016002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YVMrWVAzd3ZpNC9QRGtQOXdSVHJKTmlHWHoxV25uZnB1aExrVFJmM0JEUm8r?=
 =?utf-8?B?ZDlUUmJ0dWM1QmVtVnJXSWR5SjJ4MlhIRDBZNkwyQVY3K1ZlbHhRazcxWEYr?=
 =?utf-8?B?TWR5UlBCcWthR1hUOStiKzNaL0tuSUV5THhIbTdDK3J1TkdvcEF1dTJmSXQ2?=
 =?utf-8?B?R2hPRHk1NUwySWZxMXY2WXVQbDhNQWpkWTYwQUE0YW4ycEVqd3VtTkZqSXhn?=
 =?utf-8?B?VXF4N1oyVnYzdkpWRVJkU2FZaVg3S1pKMUczRG9YVEwwd3BUaWp4THpJQldz?=
 =?utf-8?B?SzEwVU5VZlM3c3UrWUxJWkdsU0RvazdZNUh1a1hUdWJrWjMwbWQxTnp0eTZ2?=
 =?utf-8?B?NW03dDhSWlRYdFRxWmVOQTd1Z1F1ZU9ZVi93eGs3alpQYk1CWFkzRW4ySmtX?=
 =?utf-8?B?V0lDZHR6dk03elZpNVJSalZJOXhyS09KcXNNTm9hN3ZKcll0VTkwVjQ5VzA2?=
 =?utf-8?B?c1JKOHAwSS8yMU8rSVFVd1RMVXVRWDMzTVpSUHFUSEE3bTNYZHBtbWF5c0wr?=
 =?utf-8?B?OEdJZ0hjblJwMm5OWExuMFR3enR2YVg3WExMRGhWWjFSQzNyNjRpZHpxMXFF?=
 =?utf-8?B?by9UNUpyMnk1MEhqUDEzTGtPbTc0QXBXTVpYRzV2VDljamVFaDFLWUZmcExT?=
 =?utf-8?B?MWk5a21uZFVhUEs4WmI3V1hMUWNSK1l5R1ROQm1qbkdxZ1RmNktmQU1WYnJk?=
 =?utf-8?B?N2JTTTJlUDFPMUJsRmg5QVB4dHZLYXFJT2gxbVdIWm9EWGVHS2RBWExEZmRZ?=
 =?utf-8?B?YUc2WTZ4UWxzV1lDVEFBSTZMdFdWajZIODJSblZ0QWRrRFQwREd0ZnFFMmpv?=
 =?utf-8?B?WXpJcnA1cnptbWp2VjZkV2cwREJDSlZSNUg5ZkZ0NjdxZllvUTBoSlRNVWNU?=
 =?utf-8?B?OGpQdzhTUTVqWTh6VnlMMTVLNi8rTW0yY2lJSEVWenNQZjVhZTdXWWtySHEx?=
 =?utf-8?B?Zm13c1RMMGV5RktaUWV2OXpoVTZUeVI1SWlCUkpGNFFNaFNYYlZlc0l0a0Zx?=
 =?utf-8?B?ZUlmNndPN2w0ekxhR1crOUlQUU9uVUNwRkVJdFdGWW0rL1NqRUFlQXAzRG1W?=
 =?utf-8?B?aFY2b3FHb2NvTU02L0xmckF6djYxQzRaSnBwOHRielFuMTNyZHcvZzZuTXlm?=
 =?utf-8?B?Vm1tRFFVS2RhWEhKSGFyVVhJVXVoVWlmeTJ4ZVo1OTJqT3RoQjZ6NEVKcDF2?=
 =?utf-8?B?TEI1NDJid3lCT1g5OTBDd0hWTklvV1d2TWEvQXd4eUdvRlhoellPbVllU3NG?=
 =?utf-8?B?VUZHM0RVZnkxUExNZDJCZSs4TjZPREFWemFweG1CMzBHRGxKNW12Q0pVeGYv?=
 =?utf-8?B?RmZsdVBRK3lEd0g1SmcyZzJhYndsVVdTMlNWaDUyOXZId1JpZU4rQXlCdXhF?=
 =?utf-8?B?azRlU2h4ZVFBcVM3TFpYOEZmWEZqbmVRaFUzQ2JIeVg0cU95REpuUStGYks3?=
 =?utf-8?B?bDRJWmxHTURvVGRtQ1lXWUdoVGs1S2ZMcmNjN3hXaU11R2ErSGdsVkk2VTFq?=
 =?utf-8?B?TkV0aHJoSElkYUVhSVk4bkdIdG1ITzlSTm5UREhNQy9xbHdaOFQvWnc3RjVB?=
 =?utf-8?B?WXZGaU0wb3Q3OXhicTc1RHdkeFMrYjZVdHp1MzM4eHFpS3FLVDhLeFQ0enl6?=
 =?utf-8?B?bFEyYTVqK05CU0ozZjJ6bFV4SEJ0dEU5Uk92djVoejJJM3NLWm1xUDhNRnht?=
 =?utf-8?B?SU5BSUZXd3hFSW13RzJVY0xaSm1ObWFkdjBKaUw1SmQremxBanpLbXNDRmh1?=
 =?utf-8?Q?CABq0uhFpCGkjkWaVtWMqoEJnGpxglK5yUQ5LES?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d344a3b6-3f87-4487-a6c7-08d8dd7ad227
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 12:58:05.2618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adoWFvKmuOJj0RuJomUAedQTP61RJsqlS7KjFhGDv02gFYe255Wp4CSz6G9+lPvPagk47419M6HGfnIsRhzxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3601
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

PiBGcm9tOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBTdW5kYXksIEZlYnJ1YXJ5IDI4LCAyMDIxIDY6MDEgQU0NCj4NCj4gSS9PIEFkZHJlc3MgU3Bh
Y2UgSUQgKElPQVNJRCkgY29yZSBjb2RlIHdhcyBpbnRyb2R1Y2VkIGluIHY1LjUgYXMgYSBnZW5l
cmljDQo+IGtlcm5lbCBhbGxvY2F0b3Igc2VydmljZSBmb3IgYm90aCBQQ0llIFByb2Nlc3MgQWRk
cmVzcyBTcGFjZSBJRCAoUEFTSUQpIGFuZA0KPiBBUk0gU01NVSdzIFN1YnN0cmVhbSBJRC4gSU9B
U0lEcyBhcmUgdXNlZCB0byBhc3NvY2lhdGUgRE1BIHJlcXVlc3RzDQo+IHdpdGgNCj4gdmlydHVh
bCBhZGRyZXNzIHNwYWNlcywgaW5jbHVkaW5nIGJvdGggaG9zdCBhbmQgZ3Vlc3QuDQo+IA0KPiBJ
biBhZGRpdGlvbiB0byBwcm92aWRpbmcgYmFzaWMgSUQgYWxsb2NhdGlvbiwgaW9hc2lkX3NldCB3
YXMgZGVmaW5lZCBhcyBhDQo+IHRva2VuIHRoYXQgaXMgc2hhcmVkIGJ5IGEgZ3JvdXAgb2YgSU9B
U0lEcy4gVGhpcyBzZXQgdG9rZW4gY2FuIGJlIHVzZWQNCj4gZm9yIHBlcm1pc3Npb24gY2hlY2tp
bmcsIGJ1dCBsYWNrIHNvbWUgZmVhdHVyZXMgdG8gYWRkcmVzcyB0aGUgZm9sbG93aW5nDQo+IG5l
ZWRzIGJ5IGd1ZXN0IFNoYXJlZCBWaXJ0dWFsIEFkZHJlc3MgKFNWQSkuDQo+IC0gTWFuYWdlIElP
QVNJRHMgYnkgZ3JvdXAsIGdyb3VwIG93bmVyc2hpcCwgcXVvdGEsIGV0Yy4NCj4gLSBTdGF0ZSBz
eW5jaHJvbml6YXRpb24gYW1vbmcgSU9BU0lEIHVzZXJzIChlLmcuIElPTU1VIGRyaXZlciwgS1ZN
LA0KPiBkZXZpY2UNCj4gZHJpdmVycykNCj4gLSBOb24taWRlbnRpdHkgZ3Vlc3QtaG9zdCBJT0FT
SUQgbWFwcGluZw0KPiAtIExpZmVjeWNsZSBtYW5hZ2VtZW50DQo+IA0KPiBUaGlzIHBhdGNoc2V0
IGludHJvZHVjZXMgdGhlIGZvbGxvd2luZyBleHRlbnNpb25zIGFzIHNvbHV0aW9ucyB0byB0aGUN
Cj4gcHJvYmxlbXMgYWJvdmUuDQo+IC0gUmVkZWZpbmUgYW5kIGV4dGVuZCBJT0FTSUQgc2V0IHN1
Y2ggdGhhdCBJT0FTSURzIGNhbiBiZSBtYW5hZ2VkIGJ5DQo+IGdyb3Vwcy9wb29scy4NCj4gLSBB
ZGQgbm90aWZpY2F0aW9ucyBmb3IgSU9BU0lEIHN0YXRlIHN5bmNocm9uaXphdGlvbg0KPiAtIEV4
dGVuZCByZWZlcmVuY2UgY291bnRpbmcgZm9yIGxpZmUgY3ljbGUgYWxpZ25tZW50IGFtb25nIG11
bHRpcGxlIHVzZXJzDQo+IC0gU3VwcG9ydCBpb2FzaWRfc2V0IHByaXZhdGUgSURzLCB3aGljaCBj
YW4gYmUgdXNlZCBhcyBndWVzdCBJT0FTSURzDQo+IC0gQWRkIGEgbmV3IGNncm91cCBjb250cm9s
bGVyIGZvciByZXNvdXJjZSBkaXN0cmlidXRpb24NCj4gDQo+IFBsZWFzZSByZWZlciB0byBEb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL2Nncm91cC12MS9pb2FzaWRzLnJzdCBhbmQNCj4gRG9jdW1l
bnRhdGlvbi9kcml2ZXItYXBpL2lvYXNpZC5yc3QgaW4gdGhlIGVuY2xvc2VkIHBhdGNoZXMgZm9y
IG1vcmUNCj4gZGV0YWlscy4NCj4gDQo+IEJhc2VkIG9uIGRpc2N1c3Npb25zIG9uIExLTUxbMV0s
IGEgZGlyZWN0aW9uIGNoYW5nZSB3YXMgbWFkZSBpbiB2NCBzdWNoDQo+IHRoYXQNCj4gdGhlIHVz
ZXIgaW50ZXJmYWNlcyBmb3IgSU9BU0lEIGFsbG9jYXRpb24gYXJlIGV4dHJhY3RlZCBmcm9tIFZG
SU8NCj4gc3Vic3lzdGVtLiBUaGUgcHJvcG9zZWQgSU9BU0lEIHN1YnN5c3RlbSBub3cgY29uc2lz
dHMgb2YgdGhyZWUNCj4gY29tcG9uZW50czoNCj4gMS4gSU9BU0lEIGNvcmVbMDEtMTRdOiBwcm92
aWRlcyBBUElzIGZvciBhbGxvY2F0aW9uLCBwb29sIG1hbmFnZW1lbnQsDQo+ICAgbm90aWZpY2F0
aW9ucywgYW5kIHJlZmNvdW50aW5nLg0KPiAyLiBJT0FTSUQgY2dyb3VwIGNvbnRyb2xsZXJbUkZD
IDE1LTE3XTogbWFuYWdlIHJlc291cmNlIGRpc3RyaWJ1dGlvblsyXS4NCj4gMy4gSU9BU0lEIHVz
ZXJbUkZDIDE4XTogIHByb3ZpZGVzIHVzZXIgYWxsb2NhdGlvbiBpbnRlcmZhY2UgdmlhIC9kZXYv
aW9hc2lkDQo+IA0KPiBUaGlzIHBhdGNoc2V0IG9ubHkgaW5jbHVkZWQgVlQtZCBkcml2ZXIgYXMg
dXNlcnMgb2Ygc29tZSBvZiB0aGUgbmV3IEFQSXMuDQo+IFZGSU8gYW5kIEtWTSBwYXRjaGVzIGFy
ZSBjb21pbmcgdXAgdG8gZnVsbHkgdXRpbGl6ZSB0aGUgQVBJcyBpbnRyb2R1Y2VkDQo+IGhlcmUu
DQo+DQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8xNTk5NzM0NzMz
LTY0MzEtMS1naXQtc2VuZC1lbWFpbC0NCj4geWkubC5saXVAaW50ZWwuY29tLw0KPiBbMl0gTm90
ZSB0aGF0IGlvYXNpZCBxdW90YSBtYW5hZ2VtZW50IGNvZGUgY2FuIGJlIHJlbW92ZWQgb25jZSB0
aGUNCj4gSU9BU0lEcw0KPiBjZ3JvdXAgaXMgcmF0aWZpZWQuDQo+IA0KPiBZb3UgY2FuIGZpbmQg
dGhpcyBzZXJpZXMsIFZGSU8sIEtWTSwgYW5kIElPQVNJRCB1c2VyIGF0Og0KPiBodHRwczovL2dp
dGh1Yi5jb20vamFjb2JwYW4vbGludXguZ2l0IGlvYXNpZF92NA0KPiAoVkZJTyBhbmQgS1ZNIHBh
dGNoZXMgd2lsbCBiZSBhdmFpbGFibGUgYXQgdGhpcyBicmFuY2ggd2hlbiBwdWJsaXNoZWQuKQ0K
DQpWRklPIGFuZCBRRU1VIHNlcmllcyBhcmUgbGlzdGVkIGJlbG93Og0KDQpWRklPOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIxMDMwMjIwMzU0NS40MzY2MjMtMS15aS5s
LmxpdUBpbnRlbC5jb20vDQpRRU1VOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVs
LzIwMjEwMzAyMjAzODI3LjQzNzY0NS0xLXlpLmwubGl1QGludGVsLmNvbS9ULyN0DQoNClJlZ2Fy
ZHMsDQpZaSBMaXUNCg0K
