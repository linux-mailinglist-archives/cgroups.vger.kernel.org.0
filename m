Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7581BE94
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2019 22:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEMUWK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 May 2019 16:22:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbfEMUWK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 May 2019 16:22:10 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DKEdxS007933;
        Mon, 13 May 2019 13:21:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tsSq1++Ye+ueNW2uquEVLDQ0QUuST6HsPFGeUaz02Fg=;
 b=atNArPYwI7Qi502c3cGXbYPvLVXeNdJL+9LkN0rK40ahoP3DwgzLcYDXJBPX89rkSnJX
 w6GD8IIuhUjJx3u7QnxJYgwBfxMOrGvFharT7abTzC2dKOWHATqiTXHiDeeh0AQVS4NB
 j6+RI08hcEjh23kfDQNymk+JdnUuGVJYwTw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sfafbh84t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 May 2019 13:21:56 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 May 2019 13:21:55 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 May 2019 13:21:55 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 13 May 2019 13:21:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsSq1++Ye+ueNW2uquEVLDQ0QUuST6HsPFGeUaz02Fg=;
 b=e8kd77HTWO0U024kz84jEE4mhV9DedZ3159BoIWOcoQq+3LIxnmIPT2ZoJ8v+/ypQtlcd/COFOWMyhDs38MzgZe1HCkouEmcsvFS97P3Gpwwjbp876zz7w/OXnILT/oS1sPyDV0x9hE3gfcCiBv4hI1dc+VLHWy5j995WFdZrlU=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3015.namprd15.prod.outlook.com (20.178.238.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Mon, 13 May 2019 20:21:52 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 20:21:52 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Rik van Riel" <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        "Vladimir Davydov" <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] mm: reparent slab memory on cgroup removal
Thread-Topic: [PATCH v3 0/7] mm: reparent slab memory on cgroup removal
Thread-Index: AQHVBdzwAdhboUuRQEWJczJkLkr7hKZlFjyAgARxBoA=
Date:   Mon, 13 May 2019 20:21:52 +0000
Message-ID: <20190513202146.GA18451@tower.DHCP.thefacebook.com>
References: <20190508202458.550808-1-guro@fb.com>
 <CALvZod4WGVVq+UY_TZdKP_PHdifDrkYqPGgKYTeUB6DsxGAdVw@mail.gmail.com>
In-Reply-To: <CALvZod4WGVVq+UY_TZdKP_PHdifDrkYqPGgKYTeUB6DsxGAdVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:300:95::22) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:5d82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f7b2239-3fc2-48a1-b7d8-08d6d7e0a2dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3015;
x-ms-traffictypediagnostic: BYAPR15MB3015:
x-microsoft-antispam-prvs: <BYAPR15MB301506E92729E4E9352B66EABE0F0@BYAPR15MB3015.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(366004)(39860400002)(376002)(199004)(189003)(71200400001)(52116002)(71190400001)(7416002)(14454004)(478600001)(229853002)(8936002)(86362001)(76176011)(33656002)(186003)(8676002)(14444005)(256004)(54906003)(316002)(6916009)(81166006)(99286004)(53936002)(66446008)(66476007)(66946007)(81156014)(73956011)(66556008)(68736007)(64756008)(6436002)(2906002)(53546011)(4326008)(446003)(25786009)(6486002)(11346002)(486006)(6116002)(476003)(46003)(5660300002)(9686003)(386003)(6512007)(102836004)(1076003)(7736002)(6246003)(6506007)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3015;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CtIvx006y/b9ykJYPUxusqVQa78K4BKjLyMZMu8A4Vc9DoiGjTr+lECNc0gNYGs/zosWgYEI/2p/iSTF4xJczr+4f6OORiohDSXSQVxsO7yzNtgW+a+LB9H0xWj/g8sU3rEKwluaW2vdMvErWXuq2VzoX+dv1QvpTX0GF+oyPd062Yk9thsTjsSMTiUlme7YCkSbBGHmYxbARew7YQl5i9Ab0MVGfqVMzG4RIGW7pQogOduOho6qk2YlN/Gdy6o2tS/fulF1H1nfNdtfUo8JR2u63Ln/ST8z1zNXYFvY3rQtgiyCE42T3xGtto7wyj/P8jNGqjaKY7m/14aWXQfrmLsX/qdQLgeHB2j8Y0DZ9SZ5EjOsD8jYPcrFtrGlfl+63gbz1nx0QtqVaYAgwet4AahXoWDL2zglKO5/mdjmt/s=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <166DA22C09B836488E8671DA1192C6A8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7b2239-3fc2-48a1-b7d8-08d6d7e0a2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 20:21:52.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3015
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130136
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 10, 2019 at 05:32:15PM -0700, Shakeel Butt wrote:
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, May 8, 2019 at 1:30 PM
> To: Andrew Morton, Shakeel Butt
> Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
> <kernel-team@fb.com>, Johannes Weiner, Michal Hocko, Rik van Riel,
> Christoph Lameter, Vladimir Davydov, <cgroups@vger.kernel.org>, Roman
> Gushchin
>=20
> > # Why do we need this?
> >
> > We've noticed that the number of dying cgroups is steadily growing on m=
ost
> > of our hosts in production. The following investigation revealed an iss=
ue
> > in userspace memory reclaim code [1], accounting of kernel stacks [2],
> > and also the mainreason: slab objects.
> >
> > The underlying problem is quite simple: any page charged
> > to a cgroup holds a reference to it, so the cgroup can't be reclaimed u=
nless
> > all charged pages are gone. If a slab object is actively used by other =
cgroups,
> > it won't be reclaimed, and will prevent the origin cgroup from being re=
claimed.
> >
> > Slab objects, and first of all vfs cache, is shared between cgroups, wh=
ich are
> > using the same underlying fs, and what's even more important, it's shar=
ed
> > between multiple generations of the same workload. So if something is r=
unning
> > periodically every time in a new cgroup (like how systemd works), we do
> > accumulate multiple dying cgroups.
> >
> > Strictly speaking pagecache isn't different here, but there is a key di=
fference:
> > we disable protection and apply some extra pressure on LRUs of dying cg=
roups,
>=20
> How do you apply extra pressure on dying cgroups? cgroup-v2 does not
> have memory.force_empty.

I mean the following part of get_scan_count():
	/*
	 * If the cgroup's already been deleted, make sure to
	 * scrape out the remaining cache.
	 */
	if (!scan && !mem_cgroup_online(memcg))
		scan =3D min(lruvec_size, SWAP_CLUSTER_MAX);

It seems to work well, so that pagecache alone doesn't pin too many
dying cgroups. The price we're paying is some excessive IO here,
which can be avoided had we be able to recharge the pagecache.


Btw, thank you very much for looking into the patchset. I'll address
all comments and send v4 soon.

Thanks!

Roman
