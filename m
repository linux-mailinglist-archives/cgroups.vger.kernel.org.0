Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 124DEAAEFA
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 01:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfIEXLr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Sep 2019 19:11:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38026 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfIEXLq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Sep 2019 19:11:46 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x85N3b42011765;
        Thu, 5 Sep 2019 16:11:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tenXssdW4E1XDma9BTQJomHLmn+Qu+z0mCqwlEqDzYs=;
 b=F8/80u1slN9HC/YtGJK/rShXYA2o4026fN+fSphKy8YOUvBL0lDmcDDIkFDqnwYrp9Xs
 fUmZNNU4P2xbD27FwXnLaP7aii0n/Q/W+VfTPIaDrbw4qKXY7pgKwjGdxw/AETAczk2p
 XM7H7q6E6USAbjdKjtts8gMeBX14HIbqTPE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2uu4yja0jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Sep 2019 16:11:41 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Sep 2019 16:11:41 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 5 Sep 2019 16:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5rpXQkk3RrxAyJyBVFp2MYtwnNsTMTxIt4XvwqxV6Lq4uzH5gk7quAxQsYfyJMGL5a/5qEOLWAu3F4EIkdE3SjCcGTPYMsEdlVUebHvMORb0/g+6hhBHFscC39ydyRcMCNoVEK4HthMr5wndNpYuIvTFadO+a9LSNI5D1VKir6gNeBf2bAHQdkb7kgx6grU7lzU/oj+VaIV8dOTl78f2D8ZdrA/QgUff8HLgB3FJ2ia/3hPXOf/qOFOrqJPMyQ20QD6+vjfEkHu7eEZKs0h3zzE5rPmFe5ANaxASsq4PmpXEo+blKZgj/q6era+r3UonqmNIXqe5dnhMbN0qOsdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tenXssdW4E1XDma9BTQJomHLmn+Qu+z0mCqwlEqDzYs=;
 b=VgFgZPxNmAK6+IXtLCBd7sT5VYyvVq61XD1PTcDdbm2VZuCXb9Ju4GvJiTPA3YWqPx1a1JslYCxn/Db7v35pFyVIP1VoviQ3etsY+9NwL/1pjxhoObrk7JZa9+uAxHi5YDtK7kMrAALd2fB8VgAgMm9uWH4oQScUcLfXj94P/+8xFECYxLaKrHglYViDRLFD9H5itOY+Ukz0VkMIhIhyrabifaqezG0tfnfoHMlu6ZVpUl21DjvD48YYsDQ9Ri+D5GtrQJimIjk6MUqpRFCgGrB8LC/PDhG9pRLVUClp86cDOQ8O7aP5hDCP+Uo9bER9x73wK9CGcCKTE4GIj/Wk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tenXssdW4E1XDma9BTQJomHLmn+Qu+z0mCqwlEqDzYs=;
 b=ewhH9JB/UPMc5I0NbM1EMkDIrXce2AzNEhasy7O5betKiOrRkrvFAg+jw0ao5yx2bm0UIroit+/pGSKrB7RnpeNd6Xfxfhj31LOi7mv/QJUb2i+LfXA9cc/eS4AWqS5950ZB1PV3XOBy9jEvjkAZqtJFDGyQkEJoTIEmy3bSfW8=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3484.namprd15.prod.outlook.com (20.179.48.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Thu, 5 Sep 2019 23:11:39 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::d1fc:b5c5:59a1:bd7e]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::d1fc:b5c5:59a1:bd7e%3]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019
 23:11:39 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
CC:     Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v1 0/7] mm/memcontrol: recharge mlocked pages
Thread-Topic: [PATCH v1 0/7] mm/memcontrol: recharge mlocked pages
Thread-Index: AQHVYygb4ML2nlRWy0qljqLE4Dgc06cbllOAgAEdHwCAAQTEgA==
Date:   Thu, 5 Sep 2019 23:11:39 +0000
Message-ID: <20190905231135.GA9822@tower.dhcp.thefacebook.com>
References: <156760509382.6560.17364256340940314860.stgit@buzz>
 <20190904143747.GA3838@dhcp22.suse.cz>
 <6171edb1-4598-5709-bb62-07bed89175b1@yandex-team.ru>
In-Reply-To: <6171edb1-4598-5709-bb62-07bed89175b1@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0056.namprd21.prod.outlook.com
 (2603:10b6:300:db::18) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::e156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9326fdf-cf28-444b-260c-08d73256681b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR15MB3484;
x-ms-traffictypediagnostic: DM6PR15MB3484:
x-microsoft-antispam-prvs: <DM6PR15MB34842CF52BF304FD6192BE4EBEBB0@DM6PR15MB3484.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39860400002)(366004)(346002)(52314003)(199004)(189003)(33656002)(1076003)(99286004)(46003)(6436002)(14454004)(2906002)(6116002)(6246003)(5660300002)(486006)(476003)(11346002)(478600001)(6512007)(54906003)(9686003)(66946007)(64756008)(66556008)(66476007)(66446008)(446003)(6486002)(14444005)(52116002)(53936002)(386003)(6506007)(76176011)(25786009)(102836004)(256004)(186003)(86362001)(71190400001)(71200400001)(81166006)(81156014)(316002)(6916009)(8676002)(4326008)(8936002)(7736002)(305945005)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3484;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o2mXAOeqtYU5+pcZjhiinEWqJ+4NoklqfafelH553/DPKiJqgqJ9YAVzrrK4NT9jIldrbKgoig3oO0QoyVK2dnrOtjPBi7hI04wU1PTjLC/3SGxLev+0ZPoNJXXllGb4oztiiyzEYGOsEUWLaAqaIWdSGwBYenycFi8nfR24w6TcLpMUkh/j5WFVfxUWlIIARfxxfOdKu9X6ktZTGfZmrlOtW0EN2qcc7pyWzw5USKkBbcnr7xU9VtPhI0FDhvEmUuwNNINyrkN5IrhwdZua/NEwjIOnJ33AGpKKRXsTPEHeAcMkxy+0T216eWXY3J9sDiY9v462/mhatHlCP4oxWphXQfOVVx9tfuaR4cexPdQ60KLIRQ2IKzngVmUgqKoRemh0sFixjOZbzo1VQ/VbmjvqAA4OzC2hR3KF+jamh7c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <015F4A3CFBCB944290F5F79213C6A233@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9326fdf-cf28-444b-260c-08d73256681b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:11:39.6117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZDtTlbSbNArjLrperXB9uF13fB42a+NAvVu1/a/ihY2uqhm2ZOAur67hUJr5+kh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3484
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-05_10:2019-09-04,2019-09-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=1
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909050215
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 05, 2019 at 10:38:16AM +0300, Konstantin Khlebnikov wrote:
> On 04/09/2019 17.37, Michal Hocko wrote:
> > On Wed 04-09-19 16:53:08, Konstantin Khlebnikov wrote:
> > > Currently mlock keeps pages in cgroups where they were accounted.
> > > This way one container could affect another if they share file cache.
> > > Typical case is writing (downloading) file in one container and then
> > > locking in another. After that first container cannot get rid of cach=
e.
> > > Also removed cgroup stays pinned by these mlocked pages.
> > >=20
> > > This patchset implements recharging pages to cgroup of mlock user.
> > >=20
> > > There are three cases:
> > > * recharging at first mlock
> > > * recharging at munlock to any remaining mlock
> > > * recharging at 'culling' in reclaimer to any existing mlock
> > >=20
> > > To keep things simple recharging ignores memory limit. After that mem=
ory
> > > usage temporary could be higher than limit but cgroup will reclaim me=
mory
> > > later or trigger oom, which is valid outcome when somebody mlock too =
much.
> >=20
> > I assume that this is mlock specific because the pagecache which has th=
e
> > same problem is reclaimable and the problem tends to resolve itself
> > after some time.
> >=20
> > Anyway, how big of a problem this really is? A lingering memcg is
> > certainly not nice but pages are usually not mlocked for ever. Or is
> > this a way to protect from an hostile actor?
>=20
> We're using mlock mostly to avoid non-deterministic behaviour in cache.
> For example some of our applications mlock index structures in databases
> to limit count of major faults in worst case.
>=20
> Surprisingly mlock fixates unwanted effects of non-predictable cache shar=
ing.
>=20
> So, it seems makes sense to make mlock behaviour simple and completely
> deterministic because this isn't cheap operation and needs careful
> resource planning.
>

Totally agree.

>=20
>=20
> On 05/09/2019 02.13, Roman Gushchin wrote:> On Wed, Sep 04, 2019 at 04:53=
:08PM +0300, Konstantin Khlebnikov wrote:
> >> Currently mlock keeps pages in cgroups where they were accounted.
> >> This way one container could affect another if they share file cache.
> >> Typical case is writing (downloading) file in one container and then
> >> locking in another. After that first container cannot get rid of cache=
.
> >
> > Yeah, it's a valid problem, and it's not about mlocked pages only,
> > the same thing is true for generic pagecache. The only difference is th=
at
> > in theory memory pressure should fix everything. But in reality
> > pagecache used by the second container can be very hot, so the first
> > once can't really get rid of it.
> > In other words, there is no way to pass a pagecache page between cgroup=
s
> > without evicting it and re-reading from a storage, which is sub-optimal
> > in many cases.
> >
> > We thought about new madvise(), which will uncharge pagecache but set
> > a new page flag, which will mean something like "whoever first starts u=
sing
> > the page, should be charged for it". But it never materialized in a pat=
chset.
>=20
> I've implemented something similar in OpenVZ kernel - "shadow" LRU sets f=
or
> abandoned cache which automatically changes ownership at first activation=
.
>=20
> I'm thinking about fadvise() or fcntl() for moving cache into current mem=
ory cgroup.
> This should give enough control to solve all our problems.

Idk, it feels a bit fragile: because only one cgroup can own a page, there
should be a strong coordination, otherwise cgroups may just spend non-trivi=
al
amount of cpu time stealing pages back and forth.

I'm not strictly against such fadvise() though, it can be useful in certain
cases. But in general the abandoning semantics makes more sense to me.
If a cgroup doesn't plan to use the page anymore, it marks it in a special =
way,
so that the next one who want to use it pays the whole price. So it works
exactly as if the page had been evicted, but more efficiently.

Thanks!
