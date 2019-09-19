Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B214B701E
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2019 02:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfISAee (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Sep 2019 20:34:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbfISAee (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Sep 2019 20:34:34 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8J0POc9023423;
        Wed, 18 Sep 2019 17:33:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8bmFql+0uWfaVAj85FoNxcTsS8oy59IWwTBQBlSj+HM=;
 b=KTZ0c4+04z/FHxRHDmNCSPaFKSlH2beaue1S4gUlXjGF4RLJqZc1OGj0sm/qhkaDRLcN
 +sySFSfFhWWw284XDmZZvhVDlzZ9LGjp7qnCD9gJ/ILYoj1muVqbGzWc9n1xh97uLmsX
 L17QUmAPI0FYkcZcU+cojLKQ4LVYZJhaDrQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v3vdu0nrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Sep 2019 17:33:30 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Sep 2019 17:33:29 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Sep 2019 17:33:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noDH5VWUbkCk+feSzi4wzH13lhD/7RyXOZg1APDLhzR+rTCr8VQ9zAL19H0eK6p9yefII7e0vPr5S+/JtKjZ1MMqCA0gsLVmtcSckW8QoPMev/xg1Wbeuoqi/BqzynVmEcFdCzYY9jlJ91h6UZnmL3KrZZIGgcQgT4FlqanYDjIY6e577GjUm8AcNL/yo0gflTkyWo5Tt6xEiMIF+RfN8xx5mpjB1mLZM7hcmguqsK8BYRluv6eV4WzKiJBO0aZPoA2/tg1GemSS2N0tWMqTKWnMb8i37Iy9whNiJc2oryG/0qi9RdkuVEbFN51PQ7BB2Qo2f1FXb85UQ6VS6tCdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bmFql+0uWfaVAj85FoNxcTsS8oy59IWwTBQBlSj+HM=;
 b=R7D4IR9xv1fp4kC52Cqh0uYwP0Zw3Jv/Dx/0VHcRwl3zGuseAANdYDtdq266bYgeN/qT3FV45Wq8D22LTYy/7eGwZ8Wm8fvu3UQsQijAD/5i+wOrzXTuEOkjqa06JLiPU/8iPISWI3+tScjw5yNGhHjIWChVR+BVl8Me2kbx10hzYGgws6hKSmwNTqklK2YTlidTa2mpbsVNS+rIDvw+EVlzQNn1xgdAEeRFUAVp1DaZ0e2J20wQpGqK+345CAe5kQ15qTzdklG4sCLX+8wMIP60MXzPP/dHU7n0R9zDcpQ3h5RXZq3xaw54fy7gZspqKNomy+ac1ERRZvdr0EefyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bmFql+0uWfaVAj85FoNxcTsS8oy59IWwTBQBlSj+HM=;
 b=OQ/XqlIOtcHp3MFE1mGDdmRzY5MO35VmbJV+Ekwul89lfy8oglJfKC4OGB5vSBDbFypxSMGOy4dlYGrKqW1kntol3xmHqAxC3pDfOy+f2vAy3EOPLdplrx9rHsA1yC8QcAue//lqOlwz47fxsAnQ+V1ON9XJePC9NIGccVs4dZ0=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2868.namprd15.prod.outlook.com (20.178.220.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Thu, 19 Sep 2019 00:33:28 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29%5]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 00:33:28 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Saeed Karimabadi (skarimab)" <skarimab@cisco.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: CGroup unused allocated slab objects will not get released
Thread-Topic: CGroup unused allocated slab objects will not get released
Thread-Index: AdVuYAXsyqrfLm5yRGqVq9iRkUoA5f//qfaAgACNFoCAAAyWAA==
Date:   Thu, 19 Sep 2019 00:33:28 +0000
Message-ID: <20190919003322.GA17570@castle.DHCP.thefacebook.com>
References: <BYAPR11MB2582482E28ACA901B35AF777CC8E0@BYAPR11MB2582.namprd11.prod.outlook.com>
 <20190918222315.GA16105@castle>
 <BYAPR11MB2582B2C3246BFAA8D2130A63CC8E0@BYAPR11MB2582.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB2582B2C3246BFAA8D2130A63CC8E0@BYAPR11MB2582.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::897f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8de07d00-b88e-4c5d-096f-08d73c98fd51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB2868;
x-ms-traffictypediagnostic: BN8PR15MB2868:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BN8PR15MB286827509A99D5D6BBBCC1C3BE890@BN8PR15MB2868.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(13464003)(199004)(189003)(476003)(11346002)(446003)(2906002)(7416002)(486006)(54906003)(6116002)(6916009)(33656002)(25786009)(14454004)(7736002)(478600001)(966005)(14444005)(256004)(86362001)(46003)(305945005)(52116002)(99286004)(1076003)(5660300002)(66476007)(6246003)(76176011)(386003)(53546011)(102836004)(6506007)(4326008)(6486002)(71190400001)(6512007)(9686003)(316002)(6306002)(8936002)(71200400001)(6436002)(66446008)(64756008)(8676002)(186003)(81166006)(66556008)(229853002)(66946007)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2868;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +NA6FbXU7CTivHFLVFgT0f4NPwDWRQ7aIaRei4/vvL4nJCib6BVFZ227E0Le9gmx4qq+qiM1Dthzv69cd2lBXaQkNR5CfLsAKvkfpCIwOIW5EnxhN7vFr5e4NRdYF2yRlATGuYngs6OAU6fWYtMuqkrHUwzL8RunJqUgsF6zFHAeDxUahUYkFAzHPXYnc/GB/pB6qGRBWn6hBzraxJr6BJgHdUBZBjbMEkvqaTHZcdQfjIV8tx76E0CPLqeRR/tL+VQAixKkrb4hi9EmW+Yvfi9E8Sae/VQE48c7z4h168V/mzzlaknt77zzbBDOHHOQqZhWhI4JDcHuavMtJi6R4E27n3DPQTHNF7mgyTS0CiruMn2ml4MiZEXV+XXhFkvjXkhBc6LQe/nM1wTqFvK6OIwtI3GP+Roi34UFF1bQSLs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E4A925352D391341855E87FEF780CA85@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de07d00-b88e-4c5d-096f-08d73c98fd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 00:33:28.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3qyw2AzHPLYBLGnvGcI4Mneb59icarVric7E+5oY9ZWjZ1Kt5Uv2D0eFKecNANB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2868
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_10:2019-09-18,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909190001
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Saeed!

On Wed, Sep 18, 2019 at 11:48:19PM +0000, Saeed Karimabadi (skarimab) wrote=
:
> Hi Roman,
>=20
> Thanks for your prompt reply and also sharing your patch.=20
> I did build kernel 5.3.0 with your patch and I can confirm your patch fix=
es the problem I was describing.=20
> I used Qemu for this test and the script ran 1000 tasks concurrently in 1=
00 different cgroups.
> I'm wondering if your could has gone through any long term regression tes=
t?

Thank you for testing it!
We've tested on different fb production workloads, and it was doing great.
There were significant memory savings and no noticeable cpu regression in
all tested environments.
If you've any tests you can run and share results, I'd appreciate it.

> Do you see any possible simple patch that can fix this excessive memory u=
sage in older kernel code like 4.x versions?

This patchset is definitely too heavy to backport to 4.x. As a workaround
you can disable the kernel memory accounting using a boot option, if it's
acceptable.

Thanks!

>=20
> Here are more detail information about the test results:
>=20
> *************************************************************************=
*****
> Your proposed patche back-ported to Kernel 5.3.0 :
>   https://github.com/rgushchin/linux/tree/new_slab.rfc.v5.3
> ------------- Before Running the script  -------------
> Slab:                      42756 kB
> SReclaimable:      25408 kB
> SUnreclaim:          17348 kB
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesp=
erslab> :=20
> 	            tunables <limit> <batchcount> <sharedfactor> : slabdata <act=
ive_slabs> <num_slabs> <sharedavail>
> task_struct          102    200   3200   10    8 : tunables    0    0    =
0 : slabdata     20     20      0
> ------------- After running the script -------------
> Slab:                      43736 kB
> SReclaimable:      25484 kB
> SUnreclaim:         18252 kB
> task_struct          149    220   3200   10    8 : tunables    0    0    =
0 : slabdata     22     22      0
>=20
> *************************************************************************=
*****
> Vanilla Kernel 5.3.0 :
> ------------- Before Running the script  -------------
> Slab:                      34704 kB
> SReclaimable:      19956 kB
> SUnreclaim:          14748 kB
> # name            <active_objs> <num_objs> <objsize> <objperslab> <pagesp=
erslab> :=20
>                            tunables <limit> <batchcount> <sharedfactor> :=
 slabdata <active_slabs> <num_slabs> <sharedavail>
> task_struct           99    130   3200   10    8 : tunables    0    0    =
0 : slabdata     13     13      0
> ------------- After running the script -------------
> Slab:                      59388 kB
> SReclaimable:      23580 kB
> SUnreclaim:          35808 kB
> task_struct         1174   1230   3200   10    8 : tunables    0    0    =
0 : slabdata    123    123      0
>=20
> Regards,
> Saeed
>=20
>=20
> -----Original Message-----
> From: Roman Gushchin <guro@fb.com>=20
> Sent: Wednesday, September 18, 2019 3:23 PM
> To: Saeed Karimabadi (skarimab) <skarimab@cisco.com>
> Cc: Christoph Lameter <cl@linux.com>; Pekka Enberg <penberg@kernel.org>; =
David Rientjes <rientjes@google.com>; Joonsoo Kim <iamjoonsoo.kim@lge.com>;=
 Andrew Morton <akpm@linux-foundation.org>; linux-mm@kvack.org; Tejun Heo <=
tj@kernel.org>; Li Zefan <lizefan@huawei.com>; Johannes Weiner <hannes@cmpx=
chg.org>; cgroups@vger.kernel.org; Michal Hocko <mhocko@kernel.org>; Vladim=
ir Davydov <vdavydov.dev@gmail.com>; xe-linux-external(mailer list) <xe-lin=
ux-external@cisco.com>
> Subject: Re: CGroup unused allocated slab objects will not get released
>=20
> On Wed, Sep 18, 2019 at 08:31:18PM +0000, Saeed Karimabadi (skarimab) wro=
te:
> > Hi =A0Kernel Maintainers,
> >=20
> > We are chasing an issue where slab allocator is not releasing task_stru=
ct slab objects allocated by cgroups=20
> > and we are wondering if this is a known issue or an expected behavior ?
> > If we stress test the system and spawn multiple tasks with different cg=
roups, number of active allocated=20
> > task_struct objects will increase but kernel will never release those m=
emory later on, even though if system=20
> > goes to the idle state with lower number of the running processes.
>=20
> Hi Saeed!
>=20
> I've recently proposed a new slab memory cgroup controller, which aims to=
 solve
> the problem you're describing: https://urldefense.proofpoint.com/v2/url?u=
=3Dhttps-3A__lwn.net_Articles_798605_&d=3DDwIFAw&c=3D5VD0RTtNlTh3ycd41b3MUw=
&r=3DjJYgtDM7QT-W-Fz_d29HYQ&m=3DfWQormdkeCMUp9VGpxmefgOpLEKeqxTz7u4jw51PDAQ=
&s=3Dg-9JRnTKBsVSQ7w6U_mpQ5hrjXcCKOXuYSIsTSCuTck&e=3D  . It also generally
> reduces the amount of memory used by slabs.
>=20
> I've been told that not all e-mails in the patchset reached lkml,
> so, please, find the original patchset here:
>   https://github.com/rgushchin/linux/tree/new_slab.rfc
> and it's backport to the 5.3 release here:
>   https://github.com/rgushchin/linux/tree/new_slab.rfc.v5.3
>=20
> If you can try it on your setup, I'd appreciate it a lot, and it also can
> help with merging it upstream soon.
>=20
> Thank you!
>=20
> Roman
