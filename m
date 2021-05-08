Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7467F376FCD
	for <lists+cgroups@lfdr.de>; Sat,  8 May 2021 07:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhEHFrQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 8 May 2021 01:47:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:46291 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhEHFrP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 8 May 2021 01:47:15 -0400
IronPort-SDR: 4cFWoE6RKjxjOCa7HjfUutuA9ciYFfreJeJV6JhRLtShcly/B1xC7nl6aJVdStsn5M8s5VoBZD
 U5q2yy99NWPA==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="186322301"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="186322301"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 22:46:14 -0700
IronPort-SDR: gSxN5uXElMsj2qT+yR8CJ4BcwHoUOxd83fYjg+j23bIb2uqUXHiws+hkDqagEo06tt+SJUNHZs
 QWhqiXmqxGPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="390289653"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 07 May 2021 22:46:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 7 May 2021 22:46:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 7 May 2021 22:46:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 7 May 2021 22:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9lKDO2O9Ot1iksWU6k9V8RP5bpY7YX4Zml6h+btvax0tTfJRxi53Msht38aCjJDwhbevL1iL6t+W8fKn63LzDUJLZ5SVYvzTJvzg/S5FkEQCI1wf59MtljpKZoYjnxLpGrzZ2peADiNdPdm6rD8LukdP7q7wntYRPRLfROdSd3URjZ2JuwBR/H2wzHNDJhIyMezY6HOFJweM8t6Gp5IWhWoIC/voIt8hxsjnFKrPM+VV6UuRdtEpKlFYuOIEeUf5/MFbcRUmajUHMXo9McI2m8JvRmPHmEGc2CBKVIMIEQUCFGKPJtecMNW6upEGXeSLag5a6NDWw9miwST/WCBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QifxiqKM68aD+Y4zhQAHqfPHngOrU7xs8nSqzNmvdjk=;
 b=BIbrcw+4F1bvOUfuXmfCIvn92IBiLa6TeBngjx5SsvKqQ7u64xT4Ck6CJ8K61nxD8jYdwGmmKak0p46HdNnKdjIhethPg2ySCRirK5UzV3CV/lypwqnMCxlO3+UAF/84XVipEntHaAVFTItzu/9jPIbIRQWP9TTVRyiLB98UuBWLrdLirV7QjWHaqHnWDjz4nI5bZJuBi+CzrcV5iDHB36SHTHpeB7GP04uxT0g82PFz+l2De0K2j6gZFPaIf9OtfHKhpknKnJPljpPV+L7Gq6PBXAAp74gLAMt6QHscvS+BmeWhXdJXNnjRxBXBpmoqhXtTMBmk6bnaJQkqnUDfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QifxiqKM68aD+Y4zhQAHqfPHngOrU7xs8nSqzNmvdjk=;
 b=zMlZqR5yg1Z2aN2Va6OSrmGUVJggjdgzdD8HCMMSwO7CFO0XHtqq109N5y2rgOc0/XIzvnbe4Mr+PRqCxVXwab6AHnuIdIhjbEMNAaUshDkKjBEaL3J1U+ZZU5tpOyRQk6pL8uqVbxVURgGRbdalQbQWCNqOBRUSyyM5DCEniwU=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1935.namprd11.prod.outlook.com (2603:10b6:300:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 05:46:09 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.030; Sat, 8 May 2021
 05:46:09 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgAEiVwCADrrawA==
Date:   Sat, 8 May 2021 05:46:09 +0000
Message-ID: <MWHPR11MB18861BF1CEA9AEA0B8CB2B0C8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com> <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210428204606.GX1370958@nvidia.com>
In-Reply-To: <20210428204606.GX1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04fb36bc-af60-4673-e5cd-08d911e494e7
x-ms-traffictypediagnostic: MWHPR11MB1935:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB19352275E4B23ADD601143BF8C569@MWHPR11MB1935.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oqac7lqgG0g0apDgAsNyM5IkIAoLB/fhAPSsHHSk/MSXSDE2OTVLg8ogpGdytWVEKZs0Zqgyu/bU08lEnKU4NTjKiyn6JbJLWpdqFFtrIwfT1ZowNIi0nCnWWMJP5o/7YwGclnMgEufWvcbBxDGtsGPsi67/D5L6zGggx9oP3x3Pn+alrSuilB+plWXIJhPSUEagZ0epwPbaDWJWIdya7yONgSVnYWTKqz7HCzVpTcKI7pFYXFfeL1mP0tZxOqtjolbakCZzW+s0ygxCK+xGI+rOLiv5oX4MgbPWMfk0bPh78/vRmbhvpm8aORr0jvDWaCXao1azuVsFR6uq+u6jMLRWp+6SndUYw2hpsIimlDFmNlS+FtmTv/XNQpRB9AyYPoZjCinZhmLYaixmoOoxZDtFbmkeokv9XNAfS6Mzk3JU8vmrbFAY3KL4IT17lDWMZrr7ankQGcdKOeAiCCJP4uxR2KXMKMVtNSz9FgQ/3vSOyG04VsaHvoce6yMxuBHRd02y7HX5Ysjte3rvtlrQeyY1jijT3nCOSmb8asWYpgewkhl2ijQTXBqcIRF6z1XMXLyYwIIESdGpZRPralSDeCfIvQLE3aCj4C3vmoogSM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(8676002)(7696005)(6916009)(6506007)(9686003)(66476007)(64756008)(71200400001)(66946007)(76116006)(66556008)(5660300002)(55016002)(4326008)(2906002)(8936002)(86362001)(7416002)(186003)(478600001)(33656002)(38100700002)(26005)(122000001)(54906003)(66446008)(316002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NUpYbnc0UHkyMlhNbmxmVkpwVURpL0VoN3pMN0FjejhjYnFCTEJ0cEd5ejVR?=
 =?utf-8?B?TndsbnFlN1MzdlJ0UUlpUll4cGQxcXhIbzFmMjZuRm5aWDA0UnNSZWxkSUdR?=
 =?utf-8?B?cWkrVFgyKzF0SzNVcGNmT0NvWHl2bTN0K3VLdVRidTRxVGRsV1puK2ZKeTYy?=
 =?utf-8?B?MWVkVE55VTIrZ01KV1NZdSt1RzZFVU1oZjdxcnkwOVh1ZGVxOERDVmkvOHhW?=
 =?utf-8?B?Y3VqYWE1YzBkd3F4WFRpak1MOHkxL0pHUlFGSDFZTHV0blpLZUhKUjBTOVQv?=
 =?utf-8?B?TFNGa3h6eHc2aW9Tb3g1MTVFMkQwU2djNGY4eHlMeXJreWRTc0EycXN3MWdF?=
 =?utf-8?B?WWtRaFc3VzUyVHIrWkpRdU9weXF5aEZ3eldBQUF0WFBmSTI3aWlDS0htOThR?=
 =?utf-8?B?SFhyOWRwMkFobDQrSTkzYkQxaXlyMWZIRW1DbEJOcHYwYmdIUGhadzd1d0Fo?=
 =?utf-8?B?aTZZaUw4S0tvdm1mNGtWR3lIY2hZUCttREZ2RTd5enpoRU1WMGo3MGk0ak1Q?=
 =?utf-8?B?cE0rZVk1S1V4QWpCcXYxSHFJNVBITlVGcVB2L3hqNEk2L2d3aWtkWTZLYlNK?=
 =?utf-8?B?enBXSnJwdUxRQ1Fta1Y1VllLaEdRaUdjeXRsZmxnaXJQVlFwdzRza044anlv?=
 =?utf-8?B?dGtFTEtoZGRLVnYyOVVaZEJ2cXJxSE9tL0Uva2xUSkRlZDFuRzkyK1ZvNzVL?=
 =?utf-8?B?MDVBSndFcmlvU0krMDMzY1hWM2xNT2Y5K1ZvVy9YbEdnZlFEWXIvK1Y4Zzhn?=
 =?utf-8?B?TGFmUGlreWQyZGlTempScVI4U2ZNSnRqTUlTZHduMm5wQTNNSUZSMGhjMWhu?=
 =?utf-8?B?a0IraUV5a2ZTN3JadG5OTUgvakVRNEQ5bnRZck9vY2RKa0JqNzFGRW1lcGpQ?=
 =?utf-8?B?NERUdGx3bXE0VnRBbzh6cTFyM3o4N2hEVUx1OVVkdWtMNEhwQmNVckhiV0Nr?=
 =?utf-8?B?N0ducFhzb3pnaDY2RVdXWDFFWklER0lvQThxV085N3hJS2RiZDV0bFAzWU10?=
 =?utf-8?B?ZWQxL0xlV3B2R0hyTE95NnViZWRNcG9tRzl1TVBCbUNVT0FwdjU2Y3orWmxw?=
 =?utf-8?B?aU15bis0Vk5Sb2VGZXhjVC9xT0lNNFBtL2w0ZEY5Y1RCL05HcTFHOFljeEdV?=
 =?utf-8?B?TjVQMDVIQ3gvSFZ5ekU2eStITDM0aDNWZXFkNC9oZGtBT0JoTlovNnFWcEla?=
 =?utf-8?B?TlpIc3BuM0E3L3BJRVNQd1NVNjdNVkFmN3ZZN0tYdDBOZ0Q4a2ZNNUFlUFhr?=
 =?utf-8?B?VTlNby9nbnVSeDExYXhNOHd2cU92M1VzUnpDalNNeWgwdk1KSU5HTnBuSGk1?=
 =?utf-8?B?aWxiTFRKYUMreTd6SnJicytHdVlwY05CYlNEVWhnVGRMV0dSNDk0eFlINDNh?=
 =?utf-8?B?S0pwNnFjZWw3YWMyVVlzR2czRDBxRjJBNHJqUkw0dHlsSDJybjE5am5mWWtQ?=
 =?utf-8?B?dXNPL1JoN3pVMlRFYWp5V3htajUzd2pZRkc5czBteUZ6NUpzNk9MWTF0dEZG?=
 =?utf-8?B?Y3lqQjVoUmdsaUM4ZTNNRzVCdzNhMVlmUHFjSHRQbnBJMHZBdHlkckc4dm14?=
 =?utf-8?B?T1dBWnE3T2xBdHV4eDFEc0xBR0lTamdxTmlONlZ5QjMrQnFFSjRIYms3T0pt?=
 =?utf-8?B?OXZ5NktRR3Q1d1ppbnJ6T2xoOGluQ2gyTHdycmsveUpnWC81WTA5OUl4aTRK?=
 =?utf-8?B?ektLcmRnVWR1UjcvSXB2Q2tlbGhDN1ZySlkvcW1HYnRlb1IxL2ZDYkpMa2dw?=
 =?utf-8?Q?xTVa/PX/sy/l9peDFE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fb36bc-af60-4673-e5cd-08d911e494e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 05:46:09.6837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEEsZJIo0fI5e2LwB26M/BIcV8Ty9zxvVQTNqiC2o20JmqJMtMDMbQxPjAeDYoMycv4RjVlDAPdgub3h/crbFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1935
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgQXByaWwgMjksIDIwMjEgNDo0NiBBTQ0KPiANCj4gPiA+IEkgdGhpbmsgdGhlIG5hbWUgSU9B
U0lEIGlzIGZpbmUgZm9yIHRoZSB1QVBJLCB0aGUga2VybmVsIHZlcnNpb24gY2FuDQo+ID4gPiBi
ZSBjYWxsZWQgaW9hc2lkX2lkIG9yIHNvbWV0aGluZy4NCj4gPg0KPiA+IGlvYXNpZCBpcyBhbHJl
YWR5IGFuIGlkIGFuZCB0aGVuIGlvYXNpZF9pZCBqdXN0IGFkZHMgY29uZnVzaW9uLiBBbm90aGVy
DQo+ID4gcG9pbnQgaXMgdGhhdCBpb2FzaWQgaXMgY3VycmVudGx5IHVzZWQgdG8gcmVwcmVzZW50
IGJvdGggUENJIFBBU0lEIGFuZA0KPiA+IEFSTSBzdWJzdHJlYW0gSUQgaW4gdGhlIGtlcm5lbC4g
SXQgaW1wbGllcyB0aGF0IGlmIHdlIHdhbnQgdG8gc2VwYXJhdGUNCj4gPiBpb2FzaWQgYW5kIHBh
c2lkIGluIHRoZSB1QVBJIHRoZSAncGFzaWQnIGFsc28gbmVlZHMgdG8gYmUgcmVwbGFjZWQgd2l0
aA0KPiA+IGFub3RoZXIgZ2VuZXJhbCB0ZXJtIHVzYWJsZSBmb3Igc3Vic3RyZWFtIElELiBBcmUg
d2UgbWFraW5nIHRoZQ0KPiA+IHRlcm1zIHRvbyBjb25mdXNpbmcgaGVyZT8NCj4gDQo+IFRoaXMg
aXMgd2h5IEkgYWxzbyBhbSBub3Qgc28gc3VyZSBhYm91dCBleHBvc2luZyB0aGUgUEFTSUQgaW4g
dGhlIEFQSQ0KPiBiZWNhdXNlIGl0IGlzIHVsdGltYXRlbHkgYSBIVyBzcGVjaWZpYyBpdGVtLg0K
PiANCj4gQXMgSSBzYWlkIHRvIERhdmlkLCBvbmUgYXZlbnVlIGlzIHRvIGhhdmUgc29tZSBnZW5l
cmljIHVBUEkgdGhhdCBpcw0KPiB2ZXJ5IGdlbmVyYWwgYW5kIGtlZXAgYWxsIHRoaXMgZGVlcGx5
IGRldGFpbGVkIHN0dWZmLCB0aGF0IHJlYWxseSBvbmx5DQo+IG1hdHRlcnMgZm9yIHFlbXUsIGFz
IHBhcnQgb2YgYSBtb3JlIEhXIHNwZWNpZmljIHZJT01NVSBkcml2ZXINCj4gaW50ZXJmYWNlLg0K
PiANCg0KT0ssIHNvIHRoZSBnZW5lcmFsIHVBUEkgd2lsbCBub3QgZXhwb3NlIGh3X2lkIGFuZCBq
dXN0IHByb3ZpZGUgZXZlcnl0aGluZw0KZ2VuZXJpYyBmb3IgbWFuYWdpbmcgSS9PIHBhZ2UgdGFi
bGUgKG1hcC91bm1hcCwgbmVzdGluZywgZXRjLikgdGhyb3VnaCANCklPQVNJRCBhbmQgdGhlbiBz
cGVjaWZpYyB1QVBJIGlzIHByb3ZpZGVkIHRvIGhhbmRsZSBwbGF0Zm9ybSBzcGVjaWZpYw0KcmVx
dWlyZW1lbnRzIChod19pZCwgaW92YSB3aW5kb3dzLCBldGMuKQ0KDQpUaGFua3MNCktldmluDQo=
