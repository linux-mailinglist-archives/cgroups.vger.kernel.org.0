Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA10625839
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2019 21:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfEUTYR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 May 2019 15:24:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47484 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbfEUTYQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 May 2019 15:24:16 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LJJTem016274;
        Tue, 21 May 2019 12:23:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=a/vTltGmddZuymYENLe8F8jwZplMzsDLI+yPIM85JP8=;
 b=YNVpcMewDrFQS5NzwFYnxkFFXPj7nGKMuE+PR86olL5ggaFkvlpjzg5u+yLqcnOWhukc
 tbyOR1r796JwLfhc5TEM0F4mcbz+cEFtJUMHNrOMLDM71fI47kyX30El2UbqDMtOSwIq
 3y/a/I+HKGvTQIcBO1yk1RlDOBXq7Lon1ig= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2smmmsrqq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 May 2019 12:23:32 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 May 2019 12:23:31 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 21 May 2019 12:23:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/vTltGmddZuymYENLe8F8jwZplMzsDLI+yPIM85JP8=;
 b=eS8KNHCgQ7nYcFmbuRxCG7PZ7ofZw+N8a85W729ow9Aq0/BOa3/ILwmQsQSpFCCzXtJdKIbEDCKuDvlTD68Ttdkm9K1VLRblAcdsP8OSmLBHii0rUP7K8tCrcmQKJMpiLfYF081IeNB6SZ9jUuteNaeSfMojV3iyZLIRNETVEu0=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3398.namprd15.prod.outlook.com (20.179.59.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 19:23:28 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 19:23:28 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
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
Thread-Index: AQHVCrIlH017tiyY2Em3G+ZR7kFOEaZ188AAgAAMK4A=
Date:   Tue, 21 May 2019 19:23:28 +0000
Message-ID: <20190521192320.GA6658@tower.DHCP.thefacebook.com>
References: <20190514213940.2405198-1-guro@fb.com>
 <20190514213940.2405198-6-guro@fb.com>
 <CALvZod6Zb_kYHyG02jXBY9gvvUn_gOug7kq_hVa8vuCbXdPdjQ@mail.gmail.com>
 <7d06354d-4542-af42-d83d-2bc4639b56f2@redhat.com>
In-Reply-To: <7d06354d-4542-af42-d83d-2bc4639b56f2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0041.namprd12.prod.outlook.com
 (2603:10b6:301:2::27) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:c808]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4606f3dd-1933-469b-a2e4-08d6de21cd71
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3398;
x-ms-traffictypediagnostic: BYAPR15MB3398:
x-microsoft-antispam-prvs: <BYAPR15MB33980EB0574B1905E0E7EBC9BE070@BYAPR15MB3398.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(52314003)(189003)(199004)(53936002)(6486002)(9686003)(33656002)(6512007)(53546011)(6506007)(14454004)(6116002)(102836004)(6246003)(6436002)(76176011)(386003)(1076003)(476003)(486006)(5660300002)(99286004)(46003)(478600001)(186003)(446003)(66946007)(11346002)(66476007)(66446008)(66556008)(73956011)(52116002)(64756008)(8676002)(81166006)(81156014)(316002)(86362001)(8936002)(71200400001)(71190400001)(7416002)(305945005)(7736002)(256004)(54906003)(229853002)(68736007)(14444005)(6916009)(2906002)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3398;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6m+xbJtDHGZ+wFaim67knBUzFQQTeQTTwz8ky/S4yLMnbrHJpFftKMpSanlvLL5QypYt3cHlP+joNdi6tbaHdh75yyiEbLt5Yj+DNqdPULTcQ2lGqlJ2Qf6JnCxifusNxufXqKTyQZfg6GFyUn4xmwsXYY+rNtyymSvFE8FXgglQQK/HZZOizdVA9bcKLtrlFnTXB+ceUpoeJ1B+CJMhfTIDiT14N9OHMSpcA8qicVGVMBi+I6ip4AmevCzaDjSPR3qxnmD0RH+DpC2aB3Fe4p3jP9Ln/D+55G2UBI8n/F7ov3xvcjAaapJaFaChBSJE1qTbgGnUqvljZ/HLh90TwfMc58HLuBtmhlyAsW9uLQOFdjDtaUEcPJH80EUjXe/dF3mklAR7tDOJMOoPd3iu6YroDTjfX7R1IM3FkGG4x7U=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <546644CEB60182419ED14B9EE35DB82C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4606f3dd-1933-469b-a2e4-08d6de21cd71
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 19:23:28.5265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3398
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210119
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 21, 2019 at 02:39:50PM -0400, Waiman Long wrote:
> On 5/14/19 8:06 PM, Shakeel Butt wrote:
> >> @@ -2651,20 +2652,35 @@ struct kmem_cache *memcg_kmem_get_cache(struct=
 kmem_cache *cachep)
> >>         struct mem_cgroup *memcg;
> >>         struct kmem_cache *memcg_cachep;
> >>         int kmemcg_id;
> >> +       struct memcg_cache_array *arr;
> >>
> >>         VM_BUG_ON(!is_root_cache(cachep));
> >>
> >>         if (memcg_kmem_bypass())
> >>                 return cachep;
> >>
> >> -       memcg =3D get_mem_cgroup_from_current();
> >> +       rcu_read_lock();
> >> +
> >> +       if (unlikely(current->active_memcg))
> >> +               memcg =3D current->active_memcg;
> >> +       else
> >> +               memcg =3D mem_cgroup_from_task(current);
> >> +
> >> +       if (!memcg || memcg =3D=3D root_mem_cgroup)
> >> +               goto out_unlock;
> >> +
> >>         kmemcg_id =3D READ_ONCE(memcg->kmemcg_id);
> >>         if (kmemcg_id < 0)
> >> -               goto out;
> >> +               goto out_unlock;
> >>
> >> -       memcg_cachep =3D cache_from_memcg_idx(cachep, kmemcg_id);
> >> -       if (likely(memcg_cachep))
> >> -               return memcg_cachep;
> >> +       arr =3D rcu_dereference(cachep->memcg_params.memcg_caches);
> >> +
> >> +       /*
> >> +        * Make sure we will access the up-to-date value. The code upd=
ating
> >> +        * memcg_caches issues a write barrier to match this (see
> >> +        * memcg_create_kmem_cache()).
> >> +        */
> >> +       memcg_cachep =3D READ_ONCE(arr->entries[kmemcg_id]);
> >>
> >>         /*
> >>          * If we are in a safe context (can wait, and not in interrupt
> >> @@ -2677,10 +2693,20 @@ struct kmem_cache *memcg_kmem_get_cache(struct=
 kmem_cache *cachep)
> >>          * memcg_create_kmem_cache, this means no further allocation
> >>          * could happen with the slab_mutex held. So it's better to
> >>          * defer everything.
> >> +        *
> >> +        * If the memcg is dying or memcg_cache is about to be release=
d,
> >> +        * don't bother creating new kmem_caches. Because memcg_cachep
> >> +        * is ZEROed as the fist step of kmem offlining, we don't need
> >> +        * percpu_ref_tryget() here. css_tryget_online() check in
> > *percpu_ref_tryget_live()
> >
> >> +        * memcg_schedule_kmem_cache_create() will prevent us from
> >> +        * creation of a new kmem_cache.
> >>          */
> >> -       memcg_schedule_kmem_cache_create(memcg, cachep);
> >> -out:
> >> -       css_put(&memcg->css);
> >> +       if (unlikely(!memcg_cachep))
> >> +               memcg_schedule_kmem_cache_create(memcg, cachep);
> >> +       else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt)=
)
> >> +               cachep =3D memcg_cachep;
> >> +out_unlock:
> >> +       rcu_read_lock();
>=20
> There is one more bug that causes the kernel to panic on bootup when I
> turned on debugging options.
>=20
> [=A0=A0 49.871437] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [=A0=A0 49.875452] WARNING: suspicious RCU usage
> [=A0=A0 49.879476] 5.2.0-rc1.bz1699202_memcg_test+ #2 Not tainted
> [=A0=A0 49.884967] -----------------------------
> [=A0=A0 49.888991] include/linux/rcupdate.h:268 Illegal context switch in
> RCU read-side critical section!
> [=A0=A0 49.897950]
> [=A0=A0 49.897950] other info that might help us debug this:
> [=A0=A0 49.897950]
> [=A0=A0 49.905958]
> [=A0=A0 49.905958] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [=A0=A0 49.912492] 3 locks held by systemd/1:
> [=A0=A0 49.916252]=A0 #0: 00000000633673c5 (&type->i_mutex_dir_key#5){.+.=
+},
> at: lookup_slow+0x42/0x70
> [=A0=A0 49.924788]=A0 #1: 0000000029fa8c75 (rcu_read_lock){....}, at:
> memcg_kmem_get_cache+0x12b/0x910
> [=A0=A0 49.933316]=A0 #2: 0000000029fa8c75 (rcu_read_lock){....}, at:
> memcg_kmem_get_cache+0x3da/0x910
>=20
> It should be "rcu_read_unlock();" at the end.

Oops. Good catch, thanks Waiman!

I'm somewhat surprised it didn't get up in my tests, neither any of test
bots caught it. Anyway, I'll fix it and send v5.

Does the rest of the patchset looks sane to you?

Thank you!

Roman
