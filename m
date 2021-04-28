Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FAB36D23D
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 08:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhD1Gfb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 02:35:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:43272 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231578AbhD1Gfa (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 02:35:30 -0400
IronPort-SDR: hKN1IENbWucNqvX1X3yLvkwYSiLTdWxM+HatkkcG3NvUqnEJZgZecO0kT8+KlET0y338oD2Itf
 QVCwAYWBPuiA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="260623952"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="260623952"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 23:34:46 -0700
IronPort-SDR: Fr5Z1IfebDDS1gPnMXW1jb+K79lubQ6JfM+tPBj6al9Y3ps7RrZGn4m5huhrNKNNliysQDKFJ1
 P/rEu+FQKJiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="430151869"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2021 23:34:45 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 27 Apr 2021 23:34:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 27 Apr 2021 23:34:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 27 Apr 2021 23:34:45 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 27 Apr 2021 23:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lu1R/fjZ7ghh5TYMme5cLXZA/dDfwlBcEa/sgc+ziUfXl6jQeSsp0nQPcgajgzr5fylm7pLXO0+g1aEoYZcbDRlj7HinNf4ODCpida8Z651yqsqKnK4fjc/LmLDsU7zxQFMaOle7nBDkmyVyAEFIJd7TFmnxECrj2Vi9iFEO/h1uoXmoAcNq+wJ/HbJH0GR6QQn0s2fH7ejKENE2c9ilqDBkzRpUCZjXrtP61Mf169inR3ftg5KyfGRQdu+G4KJeGJ2zIbUSlDilewFHOMCHsvh7vzUkHw37H3QoIOZ3lg5x2GWxIKdaTvJfjBSfm0/lOyyfvmIdGKjztDUzUvW/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBmlOgYKpt6mzInnOFV3Ug24vTSV2ufG0p04k/d6R0c=;
 b=G6g4f1QXpOUVCMjn4tgCTblzxMmaQLIFTO+dF9is4rUrGf6DacRT5t++FEnxrILScsejC/xZyirVKTasv4pxMiagzDZdq+zNkAheS1KNRUqH6YQNDpx4gHMCGQ11GJSMnL8+FEdJaANSywVzIbXqKuzpLUfFWYLkbJsLkY4mvdcgaScafCvIB9u3KeC7r73zrFT/gLqzfNcA3gG+1LcAfkk+ZQJpp5hiUmDjpiquzLrDXM21xlr+/6eRNVMxtlPU46KF8qxdW1Gt9oQBbkCmq9qv5XV5gwKe8my+dDZyAn6AkfVoA960LLAZ1/emhLNxJ8LVniPYdqq8CxM42/cqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBmlOgYKpt6mzInnOFV3Ug24vTSV2ufG0p04k/d6R0c=;
 b=ykVe4FoRA1totKvu5Nq+veVaLmjeiPSFb8cEj1VI1FYkEE94yQ2I6+euNipuMbvg54cPBOtjmDvcK+kLd6+kPt1lu8GQKxIMbvN6b2wJGv+0N2FW2mjjABmhEBDEnLGoWtW34KzbDSbdNF8Z3hABfUdRJA6LzHFD+NJiRG/mZBg=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1664.namprd11.prod.outlook.com (2603:10b6:301:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 06:34:12 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 06:34:12 +0000
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
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7w
Date:   Wed, 28 Apr 2021 06:34:11 +0000
Message-ID: <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421162307.GM1370958@nvidia.com>
 <20210421105451.56d3670a@redhat.com> <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com> <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
In-Reply-To: <20210426123817.GQ1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc8d3d17-8fcd-4161-22f0-08d90a0fa2d6
x-ms-traffictypediagnostic: MWHPR11MB1664:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1664A5B7F5C09F4FC63165B98C409@MWHPR11MB1664.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R8J+R3Hp3atlpEIFmqYhApCbbsQ1hDat14ovNjtx3HkXWtH3pzoW4rPsGRGzuTPT5ZYQcoj8EB3W/J7nVCUrkVZaRDJ6fi8CMCtlGiMmldIreDTwXdSG6Rieub3/0gN5oqq7SmB6g0j30nL1ANdKiHJzvBImhu1WgSy/X7h5s1F4TKKt+kGqGxPTplsCRkPx3TW2iVTmThBTk+QBc0/Xxci1wxVCF/USGiJHFWIg4kSVwMHYcyXpaB40jQ4WY5v9sk0VdGdc+UexYo44Lqn42v0YSMYcC1lr3/LSTjZlEKoKHP4BbnzaobJ5u3c7XzWunbroKdZXzKFz1EdWFCI5/RKup2rfok9CSLcZfntnjsAYtiPIGZm67R3lbVp3F/p9FjOvpc582fuyL0hUiIoYIaUsdwhltUv6D6yore28FoIZv4nS+gQCnAU4Kri++pH83FTs5MkCdbca9hG/XvtC5TmdmyxCHidsHBtwDI4syONPWb0mjorHYHFyQz6cdEAzCdTEVF5f/o8NcejYKDDg0gf5uj2LdUe/QPisdU9QWehUsT1KujCnhHgIm6tmV8rvIqcQYAisztnH19a2VHBiibizTSKxzU+6M8NNUDJD/YU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(7696005)(38100700002)(71200400001)(478600001)(186003)(66446008)(66556008)(9686003)(66476007)(76116006)(6506007)(122000001)(83380400001)(55016002)(66946007)(33656002)(52536014)(8676002)(4326008)(86362001)(26005)(5660300002)(316002)(8936002)(2906002)(54906003)(64756008)(7416002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?djBoeGZwUWpVSytuK0tBTkpIOHlQZzhFdGVNMEZPa1lDaGhFOXByeGREWjls?=
 =?utf-8?B?YjByd1VSaFk0THRHaWxoSU1WRE53clc4TGoxSVQxZ2QvY2VHRTdNUytEV1ox?=
 =?utf-8?B?ZlZpZTB5R2ZScm9COHAwRGhvTEJ4dXFyL0RlVklMbWNhVEwwUGhSRDk3RTl4?=
 =?utf-8?B?T09lbVJDZ0tuQkhUeW5XL1UzZnZUclRnendJMXZwYk9ibmFWOVhQZFh6Rk90?=
 =?utf-8?B?bXZvZ2E4WEhrQU5STlNwMDFna2lSaU9KZmlhWXJSZWl0OWpsYTNTTkU4VVRR?=
 =?utf-8?B?YXNxTkprOVJQWVlzbjcvQngrem5MRmduZlVoWi9TZ21HK3k4c2dsWXNTMlds?=
 =?utf-8?B?ZEdoVmk0UnIvem5Ba0MwNUVvTkhySnVtMkxSYmpmVDF0dkZxcGY1UDdickY0?=
 =?utf-8?B?Y3EvN3NQTnp1by8wTjBsTzcyaFdsK2gxTjlUeGVndWlCOGgxS2JIZmNxejlo?=
 =?utf-8?B?dEJydktPNmk0OW9NbnRUV2R3MG04VDEzK1VIZWhrdldUVmhwUC92eVdraEli?=
 =?utf-8?B?OHZPeGRmWVQwWkFJNnp1WUVPQ3JkMzFEa1dUSmlwZXNCMksvME5URmxOZzlK?=
 =?utf-8?B?bk1INmhPemtNbHowTldWUXUreGFDdEtaV0tuQ1FzRmVrb2FwMnZEVDZYMUxa?=
 =?utf-8?B?Y29IcVdCRDNha1BnaHZ2eGkyQnpHS2l3c1lWVW1vcEIyNmM0U3JxeTMyQ0FD?=
 =?utf-8?B?UThSMHBERVlJS3B1STdMWW11K1hEVzZDZVJwUHZrdmlyOEgvNGc3NmV2MTFi?=
 =?utf-8?B?MDk1TmFWanphVVNpUTlPYklhWVN3ZzN6RjZZR3lSUy9NVWJWdnkxblZrNm43?=
 =?utf-8?B?R2JNd2hsMGMwM3RyR0hocjd2SENSS1hXZi95TDNGNCttaUhLWldxVmVQNU9p?=
 =?utf-8?B?bTBjOVlVMTVFNU9kTDZiS1RtSEt4ejJZZ1NleVNiK2JEV0hiZ1RNRVZBb2c1?=
 =?utf-8?B?TTZObERIaDJ3OWg0RkIrSE1SY0pESVJqV1VUZ0JwcmVqZW54UHpUeU9IdU9w?=
 =?utf-8?B?Zy9ySXl5R0tBdkwvTEh2Q2RtZGdMbEdLZFEvV2FwT3JsZkhlVHlkTDFsdTJ3?=
 =?utf-8?B?c0R1WnZYK3BGejZEUVVWaVRLWVlzSjQwbGs0WmRQMUdJc1VtalRUMi92bHFu?=
 =?utf-8?B?ZVU1azFCcG82NEJiSG4xZytjNTNpemIvZWs1RExDZmN1L2Ewb2k1M1Flcll4?=
 =?utf-8?B?K3FLbXpvNlRWcWNaK1JNQTZNT1R5MVlnd3g3cnlkS2I2UnRCQk5sNWtZMThS?=
 =?utf-8?B?bXg4UnN1a0pyTHJDb3cvWlptQTVlOW1rUDBYVTlscFI4SzdEQVl2TFRaK3FL?=
 =?utf-8?B?YWV1c0VnY1d3bEdLcDZNR3pIc21nVTRYc1JJQXc2Y2RRZW5nMEQ3SExyOG5a?=
 =?utf-8?B?ZkZIVFdieHExSTFNeWtDNEo4QVpBRGZFK3VOeFlULzZLTUgxalUremcxUjYz?=
 =?utf-8?B?a2dZcUVuWGtGVEY1KzhQZHZIa09tQ2h6b3g3QUE0cjVWMlMzdVFBaTlhWHNJ?=
 =?utf-8?B?c0RYckVYbXlhT2hyeUZKeHFGdXcvZ0YvY2JZazBCVnZaVDBiK08vdHBQTGxx?=
 =?utf-8?B?eXdBMUt3WlhOWU1vWU1YeGtFRzI3QnR2TkJURW95ZnVtd2Y0TVVIL3lEUVI0?=
 =?utf-8?B?d2ZnclhEaHg2dlNDa0pNUGtocWdlUm1MMU05UWJnVzM1NmhTOW1INXlGWStG?=
 =?utf-8?B?VTFwRFJZR1pVbkpMTHE0QzFQUWUxQkx4dEl2VVF6aTJWcFlCSHhWVnhHSnNH?=
 =?utf-8?Q?SYonk9AiCvR2trWsDszuzx5o/e82aeOVG1Xu5/i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8d3d17-8fcd-4161-22f0-08d90a0fa2d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 06:34:12.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHHph2tq0F2s7CroBJL92A9xpsp+1yi5NIbUuFE/dRvv+5VLQ/L9g74CwYTILlU3ekQLUcKrddE3lATGDdyDug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1664
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBNb25kYXks
IEFwcmlsIDI2LCAyMDIxIDg6MzggUE0NCj4gDQpbLi4uXQ0KPiA+IFdhbnQgdG8gaGVhciB5b3Vy
IG9waW5pb24gZm9yIG9uZSBvcGVuIGhlcmUuIFRoZXJlIGlzIG5vIGRvdWJ0IHRoYXQNCj4gPiBh
biBpb2FzaWQgcmVwcmVzZW50cyBhIEhXIHBhZ2UgdGFibGUgd2hlbiB0aGUgdGFibGUgaXMgY29u
c3RydWN0ZWQgYnkNCj4gPiB1c2Vyc3BhY2UgYW5kIHRoZW4gbGlua2VkIHRvIHRoZSBJT01NVSB0
aHJvdWdoIHRoZSBiaW5kL3VuYmluZA0KPiA+IEFQSS4gQnV0IEknbSBub3QgdmVyeSBzdXJlIGFi
b3V0IHdoZXRoZXIgYW4gaW9hc2lkIHNob3VsZCByZXByZXNlbnQNCj4gPiB0aGUgZXhhY3QgcGd0
YWJsZSBvciB0aGUgbWFwcGluZyBtZXRhZGF0YSB3aGVuIHRoZSB1bmRlcmx5aW5nDQo+ID4gcGd0
YWJsZSBpcyBpbmRpcmVjdGx5IGNvbnN0cnVjdGVkIHRocm91Z2ggbWFwL3VubWFwIEFQSS4gVkZJ
TyBkb2VzDQo+ID4gdGhlIGxhdHRlciB3YXksIHdoaWNoIGlzIHdoeSBpdCBhbGxvd3MgbXVsdGlw
bGUgaW5jb21wYXRpYmxlIGRvbWFpbnMNCj4gPiBpbiBhIHNpbmdsZSBjb250YWluZXIgd2hpY2gg
YWxsIHNoYXJlIHRoZSBzYW1lIG1hcHBpbmcgbWV0YWRhdGEuDQo+IA0KPiBJIHRoaW5rIFZGSU8n
cyBtYXAvdW5tYXAgaXMgd2F5IHRvbyBjb21wbGV4IGFuZCB3ZSBrbm93IGl0IGhhcyBiYWQNCj4g
cGVyZm9ybWFuY2UgcHJvYmxlbXMuDQoNCkNhbiB5b3Ugb3IgQWxleCBlbGFib3JhdGUgd2hlcmUg
dGhlIGNvbXBsZXhpdHkgYW5kIHBlcmZvcm1hbmNlIHByb2JsZW0NCmxvY2F0ZSBpbiBWRklPIG1h
cC91bWFwPyBXZSdkIGxpa2UgdG8gdW5kZXJzdGFuZCBtb3JlIGRldGFpbCBhbmQgc2VlIGhvdyAN
CnRvIGF2b2lkIGl0IGluIHRoZSBuZXcgaW50ZXJmYWNlLg0KDQo+IA0KPiBJZiAvZGV2L2lvYXNp
ZCBpcyBzaW5nbGUgSFcgcGFnZSB0YWJsZSBvbmx5IHRoZW4gSSB3b3VsZCBmb2N1cyBvbiB0aGF0
DQo+IGltcGxlbWVudGF0aW9uIGFuZCBsZWF2ZSBpdCB0byB1c2Vyc3BhY2UgdG8gc3BhbiBkaWZm
ZXJlbnQNCj4gL2Rldi9pb2FzaWRzIGlmIG5lZWRlZC4NCj4gDQo+ID4gT0ssIG5vdyBJIHNlZSB3
aGVyZSB0aGUgZGlzY29ubmVjdGlvbiBjb21lcyBmcm9tLiBJbiBteSBjb250ZXh0IGlvYXNpZA0K
PiA+IGlzIHRoZSBpZGVudGlmaWVyIHRoYXQgaXMgYWN0dWFsbHkgdXNlZCBpbiB0aGUgd2lyZSwg
YnV0IHNlZW1zIHlvdSB0cmVhdCBpdCBhcw0KPiA+IGEgc3ctZGVmaW5lZCBuYW1lc3BhY2UgcHVy
ZWx5IGZvciByZXByZXNlbnRpbmcgcGFnZSB0YWJsZXMuIFdlIHNob3VsZA0KPiA+IGNsZWFyIHRo
aXMgY29uY2VwdCBmaXJzdCBiZWZvcmUgZnVydGhlciBkaXNjdXNzaW5nIG90aGVyIGRldGFpbHMu
IPCfmIoNCj4gDQo+IFRoZXJlIGlzIG5vIGdlbmVyYWwgSFcgcmVxdWlyZW1lbnQgdGhhdCBldmVy
eSBJTyBwYWdlIHRhYmxlIGJlDQo+IHJlZmVycmVkIHRvIGJ5IHRoZSBzYW1lIFBBU0lEIGFuZCB0
aGlzIEFQSSB3b3VsZCBoYXZlIHRvIHN1cHBvcnQNCg0KWWVzLCBidXQgd2hhdCBpcyB0aGUgdmFs
dWUgb2YgYWxsb3dpbmcgbXVsdGlwbGUgUEFTSURzIHJlZmVycmluZyB0byB0aGUNCnRoZSBzYW1l
IEkvTyBwYWdlIHRhYmxlIChleGNlcHQgdGhlIG5lc3RpbmcgcGd0YWJsZSBjYXNlKT8gRG9lc24n
dCBpdCANCmxlYWQgdG8gcG9vciBpb3RsYiBlZmZpY2llbmN5IGlzc3VlIHNpbWlsYXIgdG8gbXVs
dGlwbGUgaW9tbXUgZG9tYWlucyANCnJlZmVycmluZyB0byB0aGUgc2FtZSBwYWdlIHRhYmxlPw0K
DQo+IG5vbi1QQVNJRCBJTyBwYWdlIHRhYmxlcyBhcyB3ZWxsLiBTbyBJJ2Qga2VlcCB0aGUgdHdv
IHRoaW5ncw0KPiBzZXBhcmF0ZWQgaW4gdGhlIHVBUEkgLSBldmVuIHRob3VnaCB0aGUga2VybmVs
IHRvZGF5IGhhcyBhIGdsb2JhbA0KPiBQQVNJRCBwb29sLg0KDQpmb3Igbm9uLVBBU0lEIHVzYWdl
cyB0aGUgYWxsb2NhdGVkIFBBU0lEIHdpbGwgYmUgd2FzdGVkIGlmIHdlIGRvbid0DQpzZXBhcmF0
ZSBpb2FzaWQgZnJvbSBwYXNpZC4gQnV0IGl0IG1heSBiZSB3b3J0aHdoaWxlIGdpdmVuIDFtIGF2
YWlsYWJsZSANCnBhc2lkcyBhbmQgdGhlIHNpbXBsaWZpY2F0aW9uIGluIHRoZSB1QVBJIHdoaWNo
IG9ubHkgbmVlZHMgdG8gY2FyZSBhYm91dCANCm9uZSBpZCBzcGFjZSB0aGVuLg0KDQo+IA0KPiA+
IFRoZW4gZm9sbG93aW5nIHlvdXIgcHJvcG9zYWwsIGRvZXMgaXQgbWVhbiB0aGF0IHdlIG5lZWQg
YW5vdGhlcg0KPiA+IGludGVyZmFjZSBmb3IgYWxsb2NhdGluZyBQQVNJRD8gYW5kIHNpbmNlIGlv
YXNpZCBtZWFucyBkaWZmZXJlbnQNCj4gPiB0aGluZyBpbiB1QVBJIGFuZCBpbi1rZXJuZWwgQVBJ
LCBwb3NzaWJseSBhIG5ldyBuYW1lIGlzIHJlcXVpcmVkIHRvDQo+ID4gYXZvaWQgY29uZnVzaW9u
Pw0KPiANCj4gSSB3b3VsZCBzdWdnZXN0IGhhdmUgdHdvIHdheXMgdG8gY29udHJvbCB0aGUgUEFT
SUQNCj4gDQo+ICAxKSBPdmVyIC9kZXYvaW9hc2lkIGFsbG9jYXRlIGEgUEFTSUQgZm9yIGFuIElP
QVNJRC4gQWxsIGZ1dHVyZSBQQVNJRA0KPiAgICAgYmFzZWQgdXNhZ2VzIG9mIHRoZSBJT0FTSUQg
d2lsbCB1c2UgdGhhdCBnbG9iYWwgUEFTSUQNCj4gDQo+ICAyKSBPdmVyIHRoZSBkZXZpY2UgRkQs
IHdoZW4gdGhlIElPQVNJRCBpcyBib3VuZCByZXR1cm4gdGhlIFBBU0lEIHRoYXQNCj4gICAgIHdh
cyBzZWxlY3RlZC4gSWYgdGhlIElPQVNJRCBkb2VzIG5vdCBoYXZlIGEgZ2xvYmFsIFBBU0lEIHRo
ZW4gdGhlDQo+ICAgICBrZXJuZWwgaXMgZnJlZSB0byBtYWtlIHNvbWV0aGluZyB1cC4gSW4gdGhp
cyBtb2RlIGEgc2luZ2xlIElPQVNJRA0KPiAgICAgY2FuIGhhdmUgbXVsdGlwbGUgUEFTSURzLg0K
PiANCj4gU2ltcGxlIHRoaW5ncyBsaWtlIERQREsgY2FuIHVzZSAjMiBhbmQgcG90ZW50aWFsbHkg
aGF2ZSBiZXR0ZXIgUEFTSUQNCj4gbGltaXRzLiBoeXBlcnZpc29ycyB3aWxsIG1vc3QgbGlrZWx5
IGhhdmUgdG8gdXNlICMxLCBidXQgaXQgZGVwZW5kcyBvbg0KPiBob3cgdGhlaXIgdklPTU1VIGlu
dGVyZmFjZSB3b3Jrcy4NCg0KQ2FuIHlvdSBlbGFib3JhdGUgd2h5IERQREsgd2FudHMgdG8gdXNl
ICMyIGkuZS4gbm90IHVzaW5nIGEgZ2xvYmFsDQpQQVNJRD8NCg0KPiANCj4gSSB0aGluayB0aGUg
bmFtZSBJT0FTSUQgaXMgZmluZSBmb3IgdGhlIHVBUEksIHRoZSBrZXJuZWwgdmVyc2lvbiBjYW4N
Cj4gYmUgY2FsbGVkIGlvYXNpZF9pZCBvciBzb21ldGhpbmcuDQoNCmlvYXNpZCBpcyBhbHJlYWR5
IGFuIGlkIGFuZCB0aGVuIGlvYXNpZF9pZCBqdXN0IGFkZHMgY29uZnVzaW9uLiBBbm90aGVyDQpw
b2ludCBpcyB0aGF0IGlvYXNpZCBpcyBjdXJyZW50bHkgdXNlZCB0byByZXByZXNlbnQgYm90aCBQ
Q0kgUEFTSUQgYW5kDQpBUk0gc3Vic3RyZWFtIElEIGluIHRoZSBrZXJuZWwuIEl0IGltcGxpZXMg
dGhhdCBpZiB3ZSB3YW50IHRvIHNlcGFyYXRlDQppb2FzaWQgYW5kIHBhc2lkIGluIHRoZSB1QVBJ
IHRoZSAncGFzaWQnIGFsc28gbmVlZHMgdG8gYmUgcmVwbGFjZWQgd2l0aA0KYW5vdGhlciBnZW5l
cmFsIHRlcm0gdXNhYmxlIGZvciBzdWJzdHJlYW0gSUQuIEFyZSB3ZSBtYWtpbmcgdGhlDQp0ZXJt
cyB0b28gY29uZnVzaW5nIGhlcmU/IA0KDQo+IA0KPiAoYWxzbyBsb29raW5nIGF0IGlvYXNpZC5j
LCB3aHkgZG8gd2UgbmVlZCBzdWNoIGEgdGhpbiBhbmQgb2RkIHdyYXBwZXINCj4gYXJvdW5kIHhh
cnJheT8pDQo+IA0KDQpJJ2xsIGxlYXZlIGl0IHRvIEplYW4gYW5kIEphY29iLg0KDQpUaGFua3MN
CktldmluDQo=
