Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2611E23FAD
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2019 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfETR5E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 May 2019 13:57:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34686 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbfETR5D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 May 2019 13:57:03 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4KHjAho026026;
        Mon, 20 May 2019 10:56:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ZiG/s3OPwoUxswb+C2dKoiuIlrtNc7Ss7KDaPAFqyZg=;
 b=rA4LGsS5aYKGac27pVplwvVYqfQ+bM3ff142NEYp7ETU4F1d5MbqOpMFGD7YfI7Qfuwp
 qDY5mC4qpbX8HQSSoyC9UIDEZxik8cCeD2AtglXP2wKX9V0PKbmfGMWeP0N/0Fw0v6+u
 m4IhoUFUsD+R03vxZ8ww0k5xQyIq3PbJtis= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2skvds1448-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 May 2019 10:56:52 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 May 2019 10:56:50 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 May 2019 10:56:50 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 May 2019 10:56:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiG/s3OPwoUxswb+C2dKoiuIlrtNc7Ss7KDaPAFqyZg=;
 b=GuMF0nCwIKAVEvMlixihJm3hjQALm+Qv4YVIo4UF5s19OLw6pegSyvK2OiNZacKCtId5btboBCDy2dRa49lCLEXDhogGqddghRN5Oc5NssHCC9QA02isUYbARR1yLf0ADxIKkTa35AEM8f9D0ggICxXAX3TFRNsnES0ScXbMejI=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 17:56:47 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 17:56:47 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman9394@gmail.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] mm: rework non-root kmem_cache lifecycle
 management
Thread-Topic: [PATCH v4 5/7] mm: rework non-root kmem_cache lifecycle
 management
Thread-Index: AQHVCrIlH017tiyY2Em3G+ZR7kFOEaZ0Im8AgAAy7wA=
Date:   Mon, 20 May 2019 17:56:46 +0000
Message-ID: <20190520175640.GA24204@tower.DHCP.thefacebook.com>
References: <20190514213940.2405198-1-guro@fb.com>
 <20190514213940.2405198-6-guro@fb.com>
 <CALvZod6Zb_kYHyG02jXBY9gvvUn_gOug7kq_hVa8vuCbXdPdjQ@mail.gmail.com>
 <5e3c4646-3e4f-414a-0eca-5249956d68a5@gmail.com>
In-Reply-To: <5e3c4646-3e4f-414a-0eca-5249956d68a5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0023.namprd20.prod.outlook.com
 (2603:10b6:301:15::33) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:21ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86eeca8c-8b5c-4fd0-8d57-08d6dd4c86a6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3029;
x-ms-traffictypediagnostic: BYAPR15MB3029:
x-microsoft-antispam-prvs: <BYAPR15MB30298A52EEC1FBCE7A5E67CBBE060@BYAPR15MB3029.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(136003)(346002)(189003)(199004)(5660300002)(1076003)(7416002)(4326008)(102836004)(53936002)(476003)(6436002)(11346002)(186003)(6486002)(6116002)(68736007)(486006)(54906003)(305945005)(6246003)(446003)(46003)(7736002)(99286004)(66946007)(73956011)(66476007)(66556008)(64756008)(66446008)(14454004)(86362001)(33656002)(81166006)(81156014)(8936002)(256004)(14444005)(76176011)(6916009)(52116002)(1411001)(2906002)(386003)(71190400001)(6506007)(316002)(229853002)(53546011)(9686003)(6512007)(25786009)(71200400001)(478600001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3029;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1139iuDNBkPi/ux1Wb2FAePfwVD47vAdfYwsGARMx5idUGlbr2Q7WhXPwVVQaoJiCjbwi84qOKN90gQ6nfsaQMIbI5tQ7vR2UwLQq0sBBnM4cAdegyR+fmccLDTMMmtovQ6cGA3+mby2IBdmGMujxCwth9QSEcqBVE2wrMhtGT4Q1QOpwFgZfreWbjyD+wMJ0eSWjBS9bzMLO+alF+TTO+YVMmPF31Ruu2wLZxP8Eb8tw2ow4Ra8MnorB1Cax9Do4c+V7TX2THQ37boWEEtleo65n2nH3nDDvaNEmPhAcaGs3/eretlozQ6MYt79lhv2A5jNTbNK3FCOEIcQOV5/ClFxtAw1UUITfrvGtsV4wNNcwL3onsgjIeFndf5Yp0CLBEsCIE4MPPJiWmprx8bE5+xp2S/zunr+xh0W7TjslfY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8521F75896B0D548B2274FB23420AC8E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 86eeca8c-8b5c-4fd0-8d57-08d6dd4c86a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 17:56:46.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3029
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200112
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 20, 2019 at 10:54:24AM -0400, Waiman Long wrote:
> On 5/14/19 8:06 PM, Shakeel Butt wrote:
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 4e5b4292a763..1ee967b4805e 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -45,6 +45,8 @@ static void slab_caches_to_rcu_destroy_workfn(struct =
work_struct *work);
> >  static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
> >                     slab_caches_to_rcu_destroy_workfn);
> >
> > +static void kmemcg_queue_cache_shutdown(struct percpu_ref *percpu_ref)=
;
> > +
>=20
> kmemcg_queue_cache_shutdown is only defined if CONFIG_MEMCG_KMEM is
> defined. If it is not defined, a compilation warning can be produced.
> Maybe putting the declaration inside a CONFIG_MEMCG_KMEM block:

Hi Waiman!

Yes, that makes total sense to me. Thank you for letting me know!
How about this one?

--

From 0fa19369adc240cc93281911a59713822a4f3e07 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Mon, 20 May 2019 10:52:07 -0700
Subject: [PATCH] mm: guard kmemcg_queue_cache_shutdown() with
 CONFIG_MEMCG_KMEM

Currently kmemcg_queue_cache_shutdown() is defined only
if CONFIG_MEMCG_KMEM is set, however the declaration is not guarded
with corresponding ifdefs. So a compilation warning might be produced.

Let's move the declaration to the section of slab_common.c, where all
kmemcg-specific stuff is defined.

Reported-by: Waiman Long <longman9394@gmail.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9d2a3d6245dc..e818609c8209 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -45,8 +45,6 @@ static void slab_caches_to_rcu_destroy_workfn(struct work=
_struct *work);
 static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
 		    slab_caches_to_rcu_destroy_workfn);
=20
-static void kmemcg_queue_cache_shutdown(struct percpu_ref *percpu_ref);
-
 /*
  * Set of flags that will prevent slab merging
  */
@@ -134,6 +132,8 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t=
 flags, size_t nr,
 LIST_HEAD(slab_root_caches);
 static DEFINE_SPINLOCK(memcg_kmem_wq_lock);
=20
+static void kmemcg_queue_cache_shutdown(struct percpu_ref *percpu_ref);
+
 void slab_init_memcg_params(struct kmem_cache *s)
 {
 	s->memcg_params.root_cache =3D NULL;
--=20
2.20.1
