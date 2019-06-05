Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9479E362BC
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 19:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFERdb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 13:33:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53096 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbfFERda (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 13:33:30 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x55HXDjD020842;
        Wed, 5 Jun 2019 10:33:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NQd/ZrI7OHysa9+zywBc0NoPVivbuTiA3s8wT2Jxq4Y=;
 b=kto5V4C/V0elVdD6dHMAsm4VhDwt1TTtQhq/8JrkNr241iFgZXjd3ETWvpyrON+dCvOK
 MJOsoQNi32z3FiPzEK9Fb2kZMPtcVNw76Iqsq62yCdxms0uMPhyNfdgjB8J0LUpiZBBx
 pcHPF65WKmJoKx05ersvDvWp0Ak3Hi/etZA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sxeckgwwe-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 Jun 2019 10:33:17 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Jun 2019 10:33:02 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Jun 2019 10:33:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQd/ZrI7OHysa9+zywBc0NoPVivbuTiA3s8wT2Jxq4Y=;
 b=trQfGH8YOa4LmX/6mzBHPf+6imT05ZbzrLQ2ldxSP+NEK/17MfHSZ8Kv9Mc7Lo8NzUmd2Qhz+ESIclMPUGXp3qqj2UNyExZyCvNb5zfoOhd4OPW/5CMzczVU9DETQFoS+0YVssjlYeW0O8uCzrMlIhJivWu1caRRTv19aEZ63fg=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3446.namprd15.prod.outlook.com (20.179.59.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Wed, 5 Jun 2019 17:33:00 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 17:33:00 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Greg Thelen <gthelen@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH v4 0/7] mm: reparent slab memory on cgroup removal
Thread-Topic: [PATCH v4 0/7] mm: reparent slab memory on cgroup removal
Thread-Index: AQHVCp5GUxFizIu5r06SwCXM6qQb7qaMzloAgACl1QA=
Date:   Wed, 5 Jun 2019 17:33:00 +0000
Message-ID: <20190605173256.GB10098@tower.DHCP.thefacebook.com>
References: <20190514213940.2405198-1-guro@fb.com>
 <xr93ef48v5ub.fsf@gthelen.svl.corp.google.com>
In-Reply-To: <xr93ef48v5ub.fsf@gthelen.svl.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:300:115::30) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:a19a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1ff0bcd-3d27-4853-ef35-08d6e9dbdad9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB3446;
x-ms-traffictypediagnostic: BYAPR15MB3446:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB34465D5762F9393F14C4EF7BBE160@BYAPR15MB3446.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(396003)(376002)(189003)(199004)(81156014)(81166006)(66946007)(256004)(8676002)(66446008)(73956011)(86362001)(53936002)(66476007)(68736007)(6436002)(52116002)(64756008)(478600001)(186003)(14444005)(229853002)(25786009)(966005)(8936002)(6116002)(46003)(76176011)(33656002)(102836004)(6506007)(99286004)(386003)(11346002)(446003)(54906003)(66556008)(486006)(6246003)(6916009)(4326008)(1076003)(6486002)(476003)(5660300002)(2906002)(316002)(6512007)(71190400001)(14454004)(7416002)(6306002)(305945005)(7736002)(71200400001)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3446;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MpgG27Y6kdDTPSAJt5vL3fnkZRp0HUPz1+RSu9SsDAqZSqgsIHK7nkyY1DgdAB3FGgma3tqAe07QytjlaV3zm0fr2IRlmqJPWxBhfk8rGoQeQ8BO1YLBzG5yieOzB/YeOZD8w/t+2TgALDByZPYCNiN92PzkVy8kyYIrMab1Vw85GC6hFQDascNz1pQvFTbKtQhO9PUe7xb4xmco/mVZrieIVcK14u3ey+d3KURCYmtj/T94rewlrqNfhpOKzTOvj5KKUGRKGisjU/giNRzlLmvk1muUZkI8XvmdyCGbiT6KEANJHbuC9YfH9vtJVbFc2ps/cg2KVZjMulbaRLvXu0c+kRGFMfZGUve0I/4X6NHkhDW2LFOG+Z48T+vvrZQ/W34juXnAUO49IFcUBPTVmak61DXor5zc+uLwDntOY1U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4827968C6C11134CB78F7FF0C1B2FBD3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ff0bcd-3d27-4853-ef35-08d6e9dbdad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 17:33:00.1077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3446
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050110
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 05, 2019 at 12:39:24AM -0700, Greg Thelen wrote:
> Roman Gushchin <guro@fb.com> wrote:
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
> > and these LRUs contain all charged pages.
> > My experiments show that with the disabled kernel memory accounting the=
 number
> > of dying cgroups stabilizes at a relatively small number (~100, depends=
 on
> > memory pressure and cgroup creation rate), and with kernel memory accou=
nting
> > it grows pretty steadily up to several thousands.
> >
> > Memory cgroups are quite complex and big objects (mostly due to percpu =
stats),
> > so it leads to noticeable memory losses. Memory occupied by dying cgrou=
ps
> > is measured in hundreds of megabytes. I've even seen a host with more t=
han 100Gb
> > of memory wasted for dying cgroups. It leads to a degradation of perfor=
mance
> > with the uptime, and generally limits the usage of cgroups.
> >
> > My previous attempt [3] to fix the problem by applying extra pressure o=
n slab
> > shrinker lists caused a regressions with xfs and ext4, and has been rev=
erted [4].
> > The following attempts to find the right balance [5, 6] were not succes=
sful.
> >
> > So instead of trying to find a maybe non-existing balance, let's do rep=
arent
> > the accounted slabs to the parent cgroup on cgroup removal.
> >
> >
> > # Implementation approach
> >
> > There is however a significant problem with reparenting of slab memory:
> > there is no list of charged pages. Some of them are in shrinker lists,
> > but not all. Introducing of a new list is really not an option.
> >
> > But fortunately there is a way forward: every slab page has a stable po=
inter
> > to the corresponding kmem_cache. So the idea is to reparent kmem_caches
> > instead of slab pages.
> >
> > It's actually simpler and cheaper, but requires some underlying changes=
:
> > 1) Make kmem_caches to hold a single reference to the memory cgroup,
> >    instead of a separate reference per every slab page.
> > 2) Stop setting page->mem_cgroup pointer for memcg slab pages and use
> >    page->kmem_cache->memcg indirection instead. It's used only on
> >    slab page release, so it shouldn't be a big issue.
> > 3) Introduce a refcounter for non-root slab caches. It's required to
> >    be able to destroy kmem_caches when they become empty and release
> >    the associated memory cgroup.
> >
> > There is a bonus: currently we do release empty kmem_caches on cgroup
> > removal, however all other are waiting for the releasing of the memory =
cgroup.
> > These refactorings allow kmem_caches to be released as soon as they
> > become inactive and free.
> >
> > Some additional implementation details are provided in corresponding
> > commit messages.
> >
> > # Results
> >
> > Below is the average number of dying cgroups on two groups of our produ=
ction
> > hosts. They do run some sort of web frontend workload, the memory press=
ure
> > is moderate. As we can see, with the kernel memory reparenting the numb=
er
> > stabilizes in 60s range; however with the original version it grows alm=
ost
> > linearly and doesn't show any signs of plateauing. The difference in sl=
ab
> > and percpu usage between patched and unpatched versions also grows line=
arly.
> > In 7 days it exceeded 200Mb.
> >
> > day           0    1    2    3    4    5    6    7
> > original     56  362  628  752 1070 1250 1490 1560
> > patched      23   46   51   55   60   57   67   69
> > mem diff(Mb) 22   74  123  152  164  182  214  241
>=20
> No objection to the idea, but a question...

Hi Greg!

> In patched kernel, does slabinfo (or similar) show the list reparented
> slab caches?  A pile of zombie kmem_caches is certainly better than a
> pile of zombie mem_cgroup.  But it still seems like it'll might cause
> degradation - does cache_reap() walk an ever growing set of zombie
> caches?

It's not a pile of zombie kmem_caches vs a pile of zombie mem_cgroups.
It's a smaller pile of zombie kmem_caches vs a larger pile of zombie kmem_c=
aches
*and* a pile of zombie mem_cgroups. The patchset makes the number of zombie
kmem_caches lower, not bigger.

Re slabinfo and other debug interfaces: I do not change anything here.

>=20
> We've found it useful to add a slabinfo_full file which includes zombie
> kmem_cache with their memcg_name.  This can help hunt down zombies.

I'm not sure we need to add a permanent debug interface, because something =
like
drgn ( https://github.com/osandov/drgn ) can be used instead.

If you think that we lack some necessary debug interfaces, I'm totally open
here, but it's not a part of this patchset. Let's talk about them separatel=
y.

Thank you for looking into it!

Roman
