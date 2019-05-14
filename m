Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7A1D01C
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 21:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfENTnp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 15:43:45 -0400
Received: from mail-eopbgr770048.outbound.protection.outlook.com ([40.107.77.48]:40935
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfENTnp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 14 May 2019 15:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zOR9zsbKDBKlfCcrjv9bsLGQZvb5cCshKyL/sCFwLE=;
 b=KHx8EZvaPotWBKvJKP/DJ4JkgAeyt7hBtM62izf5XwyFWdJJk9/dO/VPvABTqji6VpUfPJ+GE2YpFsmoSkeLWSg+dtiYkEXZ7XsyPtYSzcCvdGUkWehainwSWYzotViEm1VF6WktpiVxGNvKVxbqkQfJuOxVVTC32YuUreV5Krg=
Received: from BYAPR12MB3384.namprd12.prod.outlook.com (20.178.55.225) by
 BYAPR12MB3096.namprd12.prod.outlook.com (20.178.54.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 14 May 2019 19:43:37 +0000
Received: from BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513]) by BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513%6]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 19:43:37 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     Roman Gushchin <guro@fb.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/amdkfd: Check against device cgroup
Thread-Topic: [PATCH 4/4] drm/amdkfd: Check against device cgroup
Thread-Index: AQHVAC55koEwRnit7kyr2zcr6OGdM6Zp8LgAgAEGcACAACKqrQ==
Date:   Tue, 14 May 2019 19:43:37 +0000
Message-ID: <BYAPR12MB3384F5C0D850C9D6DE720B6C8C080@BYAPR12MB3384.namprd12.prod.outlook.com>
References: <20190501145904.27505-1-Harish.Kasiviswanathan@amd.com>
 <20190501145904.27505-5-Harish.Kasiviswanathan@amd.com>
 <20190514015832.GA14741@tower.DHCP.thefacebook.com>,<20190514173749.GA12629@tower.DHCP.thefacebook.com>
In-Reply-To: <20190514173749.GA12629@tower.DHCP.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harish.Kasiviswanathan@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aadeffd1-4e2a-4f24-b47b-08d6d8a4753c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB3096;
x-ms-traffictypediagnostic: BYAPR12MB3096:
x-microsoft-antispam-prvs: <BYAPR12MB30968A8A1EAB66576A45C3EE8C080@BYAPR12MB3096.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(66066001)(6916009)(73956011)(71190400001)(71200400001)(478600001)(2906002)(4326008)(102836004)(5660300002)(66556008)(25786009)(76116006)(6246003)(55016002)(186003)(64756008)(66446008)(256004)(14444005)(53936002)(26005)(54906003)(99286004)(7696005)(52536014)(66476007)(6116002)(3846002)(74316002)(9686003)(76176011)(229853002)(53546011)(6506007)(68736007)(91956017)(6436002)(476003)(7736002)(8936002)(86362001)(446003)(11346002)(305945005)(14454004)(66946007)(486006)(8676002)(72206003)(81166006)(81156014)(316002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3096;H:BYAPR12MB3384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TqyiUpc05gsS9TXM238QvHNLhn7lzd47VZWsOxjukkaUfo8Rg7EPoM0Dp2F4G4ALX1MqWLaOlVC0Mh23zV/RrMXRWG+HRFSPq4kSycbdyZZZFx5nOA69z7bcWDbLfMO8KxsATidJFn1fSPxGHZNprMQ534OwE1SI44H6VmmPyAN0tloIgrHqa/r/MTLwjLzkAVlIJax/p5Kd3vWUCkUJKHUf0uBGaSWEexXixYirifZA6fUOhn05FxHWffc3Dielv1AkVHBWkiHRK7iHWb3B6fYtxfmpFQz/Jxn2j31saT8qVOssxATAdlFV/Gg0hh831uZ54Am3dbBAvEbJ5b4yQsZN7tMMHnDxuEt67f29JQf2kN3huk5Xhy8j8H8pk6XunGvNycuUUORCHa4wxWSbVgRuI+4IsAfmGHHDm0fjRQM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadeffd1-4e2a-4f24-b47b-08d6d8a4753c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 19:43:37.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3096
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Roman,

Thanks for your feedback. I will rework and send new patch soon.

Best Regards,
Harish
=20




From: Roman Gushchin <guro@fb.com>
Sent: Tuesday, May 14, 2019 1:37 PM
To: Kasiviswanathan, Harish
Cc: cgroups@vger.kernel.org; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 4/4] drm/amdkfd: Check against device cgroup
=A0=20

[CAUTION: External Email]

On Tue, May 14, 2019 at 01:58:40AM +0000, Roman Gushchin wrote:
> On Wed, May 01, 2019 at 02:59:29PM +0000, Kasiviswanathan, Harish wrote:
> > Participate in device cgroup. All kfd devices are exposed via /dev/kfd.
> > So use /dev/dri/renderN node.
> >
> > Before exposing the device to a task check if it has permission to
> > access it. If the task (based on its cgroup) can access /dev/dri/render=
N
> > then expose the device via kfd node.
> >
> > If the task cannot access /dev/dri/renderN then process device data
> > (pdd) is not created. This will ensure that task cannot use the device.
> >
> > In sysfs topology, all device nodes are visible irrespective of the tas=
k
> > cgroup. The sysfs node directories are created at driver load time and
> > cannot be changed dynamically. However, access to information inside
> > nodes is controlled based on the task's cgroup permissions.
> >
> > Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> > Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> Hello, Harish!
>
> Cgroup/device controller part looks good to me.
> Please, feel free to use my acks for patches 3 and 4:
> Acked-by: Roman Gushchin <guro@fb.com>

Hello!

After the second look at the patchset I came to an understanding that
exporting cgroup_v1-only __devcgroup_check_permission() isn't the best idea=
.

Instead it would be better to export devcgroup_check_permission(), which
provides an universal interface for both cgroup v1 and v2 device controller=
s.
It=A0 require some refactorings, but should be not hard.

Does it makes sense to you? Can you, please, rework this part?

Thanks!
    =
