Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D980D21ED6
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 22:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfEQUEt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 16:04:49 -0400
Received: from mail-eopbgr760073.outbound.protection.outlook.com ([40.107.76.73]:33846
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726948AbfEQUEs (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 17 May 2019 16:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuVQW9oawJ3DcRKQ4ezfVTZlaiYMBgc0rbzps9A2mw0=;
 b=JnKb7zfhRFtKJIiqywpI7a7kZnJ33Kz8Gg1OrSBLimI6bsZkdSq0c9ZEMj8HVzWM2cO31CxiAQlJAIvsyP/XQRVHLQgSfJMKaOMOHdipALl/WgKzgw+5QTHR69/uNSofMbtha9IKW/PSJVC8Wjy15BrmOTG7SZEJXxTogvoia6Q=
Received: from BYAPR12MB3384.namprd12.prod.outlook.com (20.178.55.225) by
 BYAPR12MB3239.namprd12.prod.outlook.com (20.179.93.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Fri, 17 May 2019 20:04:42 +0000
Received: from BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513]) by BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513%6]) with mapi id 15.20.1878.024; Fri, 17 May 2019
 20:04:42 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     Tejun Heo <tj@kernel.org>, "guro@fb.com" <guro@fb.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/4] AMDKFD (AMD GPU compute) support for device
 cgroup.
Thread-Topic: [PATCH v2 0/4] AMDKFD (AMD GPU compute) support for device
 cgroup.
Thread-Index: AQHVDMuol86WSWX8+kyraEU0ra1TfKZvh26AgAAznRE=
Date:   Fri, 17 May 2019 20:04:42 +0000
Message-ID: <BYAPR12MB3384A590739D7E18B736CB368C0B0@BYAPR12MB3384.namprd12.prod.outlook.com>
References: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>,<20190517164937.GF374014@devbig004.ftw2.facebook.com>
In-Reply-To: <20190517164937.GF374014@devbig004.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harish.Kasiviswanathan@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 356d80ec-20f5-43c6-0e6b-08d6db02e68d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB3239;
x-ms-traffictypediagnostic: BYAPR12MB3239:
x-microsoft-antispam-prvs: <BYAPR12MB32397F2AB8F8B049E7B790E48C0B0@BYAPR12MB3239.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(2906002)(256004)(229853002)(305945005)(68736007)(6246003)(64756008)(8936002)(66476007)(76176011)(73956011)(76116006)(66946007)(66446008)(66556008)(7736002)(25786009)(81166006)(81156014)(8676002)(53936002)(2501003)(4326008)(99286004)(5660300002)(14454004)(66066001)(110136005)(11346002)(6436002)(71200400001)(186003)(71190400001)(54906003)(446003)(55016002)(476003)(9686003)(486006)(26005)(33656002)(74316002)(53546011)(6506007)(6116002)(72206003)(3846002)(7696005)(316002)(102836004)(478600001)(52536014)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3239;H:BYAPR12MB3384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tGcjXtz7Wmj8A7ci4oKbArfjV/ZU+7hAJPpD39W6nveb0DhrWoBG7hBP7utFUt3YTwHvzpX/UNkxK0bLf5dHcPQvCHEzos/XOqHzY7Tf6CS0hiTZs64DRc6KYUC6qTZQ03L1tN+KnPPD+SDaBUhpdn42VygnvgEG8+FoAdCEQC8iDeQacckK/orDpZ9xs+MHZGc4FO8KKomuLphWyKk10a+OWuhiE2eR8eDq5a9A39jVGdk3PKvjXF1WzL75V21Cp7xfcrd643gRl5IG8oUtq+ES7Lg6YUQfR4lJp3xIz1Vej/1m9vMR5PQ800hFTkJcWt2k1DcL0qXi6bt5eKckdAsj8ckznu+xERvGMVATS8VGaxJCKGWYHZEA0NpQJlkHZL//Mon5Z9TaNcbnpsUt4W+OckJw4y5BuV5SGiuY96w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356d80ec-20f5-43c6-0e6b-08d6db02e68d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 20:04:42.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3239
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

Thanks for comments. I can definitely add more documentation but just need =
a bit of clarification on this.

1). Documentation for user on how to use device cgroup for amdkfd device. I=
 have some more information on this in patch 4.=20
or
2) The reason devcgroup_check_permission() needs to be exported
or
3) something else totally that I missed.

Best Regards,
Harish


From: Tejun Heo <htejun@gmail.com> on behalf of Tejun Heo <tj@kernel.org>
Sent: Friday, May 17, 2019 12:49 PM
To: Kasiviswanathan, Harish
Cc: cgroups@vger.kernel.org; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 0/4] AMDKFD (AMD GPU compute) support for device cgr=
oup.
=A0=20

[CAUTION: External Email]

On Fri, May 17, 2019 at 04:14:52PM +0000, Kasiviswanathan, Harish wrote:
> amdkfd (part of amdgpu) driver supports the AMD GPU compute stack.
> amdkfd exposes only a single device /dev/kfd even if multiple AMD GPU
> (compute) devices exist in a system. However, amdgpu drvier exposes a
> separate render device file /dev/dri/renderDN for each device. To partici=
pate
> in device cgroup amdkfd driver will rely on these redner device files.
>
> v2: Exporting devcgroup_check_permission() instead of
> __devcgroup_check_permission() as per review comments.

Looks fine to me but given how non-obvious it is, some documentation
would be great.

Thanks.

--
tejun
    =
