Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65861B6F57
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2019 00:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfIRWYZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Sep 2019 18:24:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23878 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727562AbfIRWYZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Sep 2019 18:24:25 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8IMAi56027355;
        Wed, 18 Sep 2019 15:23:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jorFgc9ZnWSadbbiIvozUV0N/52mi2w8mPxWWMYTL4Q=;
 b=hCWf2ey6JI6cuwasm99wmuSOJ8wlXm4OCFwvIowcnkj5ptSUfKzUVQGxNhiZyoIX89U+
 /o1efh9/LKt7TuH3gUIfRTeHoYv1HSaLuvej8CLr7uyhB9RtK8bozZtX+MVlzBH46ZtA
 J2vjrmVKN/bS60Yt5x+OP7/A2qeX3rkaAro= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2v3vdqg876-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 15:23:23 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 18 Sep 2019 15:23:22 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Sep 2019 15:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KStx6Jw1XV0+i5Ju2ViguwNCIzzUHHVwManapXNFk3dnwdeTTLVIa7lDFfZAu5dt2/aFWQW3rao/yuMrs4j1HdobAL2HGpnXmQhYx+MX1kmWNZJuYZ1SnZELn7luIPaajPlR5bUIaDjVgEJn5jD/NZqLVBnDYqLEFU5rjvfI9DV8pv5O7b+HLezRyZTrpotpM2u5wWOLjbzSXmId9vLx1qzqiFHLdgk0wRNKS1jqf75qIUeXOMq7EqAxQrMKDJBx6n8LARcmP4NxUbfeTre1zM6E9YH9TMH54+OMCR6FYkzz+EJrA0g1qi+/HpI5MnVa+Zk3ENJbLH1tyxKv67fdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jorFgc9ZnWSadbbiIvozUV0N/52mi2w8mPxWWMYTL4Q=;
 b=MXsUjrer/k4/ZCeOlEMW+jbzHWlUBLHLbD3DxG2OuSPvKXOyMvC8YMJYPeJWtUXh/+85At6r2RWMxo13rGKAHsv/85nGOFE5F6CmxJFAyMTxy8qzbcGdzY0Das8emMo+uOf/AYoBqD6lg621oXUUxj+NkPQTCL1m9I0u06Wb+IfYLDol7P9JKq2fnYOenlnvqk1cCe0rSIzcAmHGrWIIMk44DUTBvHUXw0KUqHbJVw38uCQ0pAJeNoYX+o7IsnC2F6dtlyx/mxPFrLMSAFUcToZadMadZoSZJZROVn9lv1BvmxysH067lNSiiOcSBNQyQqqCAXGCj1J9n9khU8MNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jorFgc9ZnWSadbbiIvozUV0N/52mi2w8mPxWWMYTL4Q=;
 b=ds87+fGUcy8mHA5RdyrBUUeg0tpmRt8IlxEopsLAKAQULr2tDl4844CzmvLies8yY6Dw7EDzYeVpZomg9gwHNvbRE6SU85I4vl3EuXOhtzyQTg+24LEiLCme8g77TKnhRH199sxmd9zJf+nsMwISOGKx46VMUc/2enRvvx0iMm4=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2833.namprd15.prod.outlook.com (20.178.218.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Wed, 18 Sep 2019 22:23:21 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::8174:3438:91db:ec29%5]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 22:23:21 +0000
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
Thread-Index: AdVuYAXsyqrfLm5yRGqVq9iRkUoA5QAD6QWA
Date:   Wed, 18 Sep 2019 22:23:21 +0000
Message-ID: <20190918222315.GA16105@castle>
References: <BYAPR11MB2582482E28ACA901B35AF777CC8E0@BYAPR11MB2582.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB2582482E28ACA901B35AF777CC8E0@BYAPR11MB2582.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:300:129::16) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::e152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1b0ab54-ff0f-4a77-1129-08d73c86cfec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR15MB2833;
x-ms-traffictypediagnostic: BN8PR15MB2833:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BN8PR15MB2833FA8AE794BB812ED875BEBE8E0@BN8PR15MB2833.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(136003)(366004)(39860400002)(346002)(396003)(199004)(189003)(99286004)(6116002)(86362001)(1076003)(305945005)(52116002)(7416002)(66556008)(33716001)(6486002)(4326008)(486006)(66476007)(7736002)(71200400001)(316002)(64756008)(66446008)(6306002)(8936002)(66946007)(71190400001)(186003)(46003)(6436002)(76176011)(6512007)(229853002)(9686003)(14454004)(478600001)(11346002)(476003)(25786009)(6916009)(54906003)(102836004)(5660300002)(446003)(6246003)(33656002)(81166006)(966005)(81156014)(8676002)(386003)(2906002)(256004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2833;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k/3FBimWZ3X//TxW2fG3fymyA8dUKFk6TlFmgZ40MMwmoQbSyW/xD4LtwUPt56THx4BrGzWsF7DFAvjypKUhXxQ3RNCGNVD6zd7J86XRghVhgIA2Rwxf1j/G7LaOIuYh6ekcl+ARZleCsKkg2uiNWv3KVA4rIZJgVjK4oBu3z9sbJNYZRXGRdYRQ7bjAiA/2rnVAk0yEgE8al9k5B1gRfo4hui9I7RTuD1IT2Zap+Cbnk2QrPnPp/nJ9ZX4w1wHp7b4WLBxQGWPYVymw/ppLoENxG4BSa5sPr1jfW9go+jSdqVEv9m7j3Azg2EvzZkahVBwMzqWWURvbAiSBoU6HvukUXah+XUtHT9kLU7+1oTkXSSJzZy35/migKigBQh22bqkESDRtRnW0YL60OtTVsf5xOxF+hN8nKCIvpj9gZcc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <FE66DBCC21C40A4E821DE15D66FA409E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b0ab54-ff0f-4a77-1129-08d73c86cfec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 22:23:21.0901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYRPMd1GD7wWcqRjVMhJYtHT48fe1P7ANmaPQTx279/tEyNPmdBPZtkcY9vEY9vq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2833
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_10:2019-09-18,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909180187
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 18, 2019 at 08:31:18PM +0000, Saeed Karimabadi (skarimab) wrote=
:
> Hi =A0Kernel Maintainers,
>=20
> We are chasing an issue where slab allocator is not releasing task_struct=
 slab objects allocated by cgroups=20
> and we are wondering if this is a known issue or an expected behavior ?
> If we stress test the system and spawn multiple tasks with different cgro=
ups, number of active allocated=20
> task_struct objects will increase but kernel will never release those mem=
ory later on, even though if system=20
> goes to the idle state with lower number of the running processes.

Hi Saeed!

I've recently proposed a new slab memory cgroup controller, which aims to s=
olve
the problem you're describing: https://lwn.net/Articles/798605/ . It also g=
enerally
reduces the amount of memory used by slabs.

I've been told that not all e-mails in the patchset reached lkml,
so, please, find the original patchset here:
  https://github.com/rgushchin/linux/tree/new_slab.rfc
and it's backport to the 5.3 release here:
  https://github.com/rgushchin/linux/tree/new_slab.rfc.v5.3

If you can try it on your setup, I'd appreciate it a lot, and it also can
help with merging it upstream soon.

Thank you!

Roman
