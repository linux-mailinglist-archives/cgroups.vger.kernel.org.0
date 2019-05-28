Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F42CFDE
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 21:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfE1T71 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 15:59:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43886 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbfE1T70 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 15:59:26 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SJwv4R008757;
        Tue, 28 May 2019 12:59:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=LkSxTZxdxqWXHs6bcjODkfy5ThgF4ZzKI+BFcFNhJwc=;
 b=WmXfvDLJbX5jj5IFNgc0Wbxcie3JyXKz9Bk3P4JXDoblWYirieoymNy8a43A8rPtyjlv
 a+7676R4Xe6PtyLU232Wz1VTz8k7FgXegFLYnOf7eGQXu/N1kUZHgqPegNxC3nYcd3kV
 AgXMKWUaCJDzC89vCHMFvtIL0uK1O7kHVQo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ss90cgn9c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 12:59:13 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 28 May 2019 12:58:21 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 28 May 2019 12:58:21 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 28 May 2019 12:58:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkSxTZxdxqWXHs6bcjODkfy5ThgF4ZzKI+BFcFNhJwc=;
 b=mz3MGrm9QwsvbTIAx5Q3kP7X2sKuVY/oejW6MoPS8f8Y0CrH7SlH9GlLZxfSGbpJ8Qw/lJH/ptvSFpYKxqWL6sB097D1QFMuAbwF6dIlXVGxK0gJLzzEJtPhN8LpHfPG9WwwjMrBqiYlfrMKJTNCyu05IHUz3bnYGjU6QebJxW4=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2487.namprd15.prod.outlook.com (52.135.198.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Tue, 28 May 2019 19:58:18 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 19:58:18 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Waiman Long" <longman@redhat.com>
Subject: Re: [PATCH v5 6/7] mm: reparent slab memory on cgroup removal
Thread-Topic: [PATCH v5 6/7] mm: reparent slab memory on cgroup removal
Thread-Index: AQHVEBPW5GLT+zCswEKkIpLsH/n20qaA52gAgAAXzAA=
Date:   Tue, 28 May 2019 19:58:17 +0000
Message-ID: <20190528195808.GA27847@tower.DHCP.thefacebook.com>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-7-guro@fb.com>
 <20190528183302.zv75bsxxblc6v4dt@esperanza>
In-Reply-To: <20190528183302.zv75bsxxblc6v4dt@esperanza>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:104:6::31) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:3dca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d059af63-d800-4bfc-0653-08d6e3a6d30b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2487;
x-ms-traffictypediagnostic: BYAPR15MB2487:
x-microsoft-antispam-prvs: <BYAPR15MB248790949526E0D694A8A4EBBE1E0@BYAPR15MB2487.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(99286004)(4326008)(7736002)(71200400001)(71190400001)(66476007)(52116002)(66446008)(66946007)(64756008)(54906003)(7416002)(33656002)(386003)(8936002)(102836004)(53936002)(6916009)(305945005)(1076003)(76176011)(73956011)(6246003)(6506007)(229853002)(186003)(316002)(478600001)(6436002)(6486002)(256004)(86362001)(6116002)(5660300002)(6512007)(14444005)(9686003)(486006)(2906002)(25786009)(8676002)(66556008)(68736007)(81156014)(81166006)(14454004)(46003)(446003)(11346002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2487;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PaCwO8r1jCJ0jLYhVjjURG5ajZfOsFcB3KOO4rrSPsg6QydzTe7hD/zEG+RZuz0b62EfU2kZgk/CdQRkz+QJcF//4y5vuQdO5r/zswk+Fx/305MkU8m8eQCh/lY7O0FWhQumn4xnGYGPo3T1IonprqGqcGA2nMeDGacbLVI1vCQ4nOksTlhwBuKhmHWPS8UWi5m9aGzXty+yfnQO9L5YAkXCPTmjQBUke1Yl8k5QQ/6kOYYL4qGCTi8C7T7GnyC3xdf1Lzhjd1OgGHxS3wMw4rTE0F7WAJ1qfX+W5SpUVMABZGCmX68Ji4c+App3XEsDZFoeyjamSabt4Ln5OOBqgGUxU+dafO1217w/WHCJ3jL8YFMtHkxZPMAwYIYU4WDJZnKBf/KwyF4uPnem9pSsRdFWqzs/Yw2tmYfZ+1eFpgc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0850A1DD02DABC429A7DDA28E4AFE9A8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d059af63-d800-4bfc-0653-08d6e3a6d30b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 19:58:18.4683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2487
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280125
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 28, 2019 at 09:33:02PM +0300, Vladimir Davydov wrote:
> On Tue, May 21, 2019 at 01:07:34PM -0700, Roman Gushchin wrote:
> > Let's reparent memcg slab memory on memcg offlining. This allows us
> > to release the memory cgroup without waiting for the last outstanding
> > kernel object (e.g. dentry used by another application).
> >=20
> > So instead of reparenting all accounted slab pages, let's do reparent
> > a relatively small amount of kmem_caches. Reparenting is performed as
> > a part of the deactivation process.
> >=20
> > Since the parent cgroup is already charged, everything we need to do
> > is to splice the list of kmem_caches to the parent's kmem_caches list,
> > swap the memcg pointer and drop the css refcounter for each kmem_cache
> > and adjust the parent's css refcounter. Quite simple.
> >=20
> > Please, note that kmem_cache->memcg_params.memcg isn't a stable
> > pointer anymore. It's safe to read it under rcu_read_lock() or
> > with slab_mutex held.
> >=20
> > We can race with the slab allocation and deallocation paths. It's not
> > a big problem: parent's charge and slab global stats are always
> > correct, and we don't care anymore about the child usage and global
> > stats. The child cgroup is already offline, so we don't use or show it
> > anywhere.
> >=20
> > Local slab stats (NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE)
> > aren't used anywhere except count_shadow_nodes(). But even there it
> > won't break anything: after reparenting "nodes" will be 0 on child
> > level (because we're already reparenting shrinker lists), and on
> > parent level page stats always were 0, and this patch won't change
> > anything.
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
>=20
> This one looks good to me. I can't see why anything could possibly go
> wrong after this change.

Hi Vladimir!

Thank you for looking into the series. Really appreciate it!

It looks like outstanding questions are:
1) synchronization around the dying flag
2) removing CONFIG_SLOB in 2/7
3) early sysfs_slab_remove()
4) mem_cgroup_from_kmem in 7/7

Please, let me know if I missed anything.

I'm waiting now for Johanness's review, so I'll address these issues
in background and post the next (and hopefully) final version.

Thanks!
