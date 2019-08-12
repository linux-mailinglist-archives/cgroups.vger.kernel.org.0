Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 520F78A8FE
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2019 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfHLVIL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Aug 2019 17:08:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63118 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbfHLVIL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Aug 2019 17:08:11 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CL45TY006161;
        Mon, 12 Aug 2019 14:07:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UQpM2DVd4KdWt+/TmUpgV8F/tE9aHCVCkVKeMEToXDY=;
 b=QpIullFToN6RVQl2OOoYDtRgu7DDVCcA2klcgBKmNuCKppznt+ZisETwVeAy0shgnJno
 uZaI9vCoZIcSmPOoDxOXQNa62yS9c6RQPUO8DjKG+A686kgmNBUz3Sb7IGB9J+7rpGt7
 rbW2bQpsNm7Usf7wsYLBTBsDR4MyMBdIga0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ubf7q04j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Aug 2019 14:07:41 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Aug 2019 14:07:40 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Aug 2019 14:07:40 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 12 Aug 2019 14:07:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy/7BC010UUoWX3/46+7Whk2swvHFzhkxk3gc5B1fLc+2KpjkBNzktht7wsdhlN7zcLuxy3uchzdqo/BmO24kdLHQMMcBg2yfdqIJO198VFHk88/ibazeHAM9iRiKualnd+e5MYT9zMsIVEo/WS7frhOmeaiXbRQW4UjvNmNvnd2WsmsAR54IxVGB67FQRnvGaYC0oHPHFbGkNKNZspn2mtmyG9GiCAtmgWEBUCj20nXHdAwOcPweKk3tUDmRp3hySfzdi+4TnBuvqo1LaZf+s4FRAjJ1pblRuceLMs5WbzR0RlIWJ2UcqAKwBt4R8ERmYYppZHVr1NE2QXu+IBfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQpM2DVd4KdWt+/TmUpgV8F/tE9aHCVCkVKeMEToXDY=;
 b=Z1T2O8627j0VOyClZ8/T6NxGINCIbd/SKhDNXDnB+MF4v+diiXIvd9Hp28IULAIa8vQopV0TycIuyzbaajs9yuzE5QI4MdRrFra8AZXSvN2dKhqcwGuUlFUExWn5iTs4OCmgBdNJpj/mICw+dnctfBFvQQLIQswQDUuRWgJlLFKzuRpT6XjsjgytSvqmIqo4B/8OO+FTU/gbmemBFt5lfQezFTAtV3uthI7FOy5+kVbxA3CBRSr6S6JuurxwgrPks9lwe4bIK5n8CdQo2hIf4kTTlb/yafx+rbtCH3PAdErB9sYvVFrkPw78E3SNbXwM3C+S0LyKgRGbZGjsa0mHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQpM2DVd4KdWt+/TmUpgV8F/tE9aHCVCkVKeMEToXDY=;
 b=ae0nL76yu/Z8gP9C/ycoWYjckNEqCrHNNH4scvbAkvxMAteACBWI7T2q1r1qyIQASD93+mGoaifs7iCuxYMTGTljo7VaXAu8UdrTnE0Fiy0bAUhtwmO2y8T0VDejFSsBhwuADyPAeBFKUzOwuzz03S6Si1+ZQ/e0U5GAT1qEFMc=
Received: from BYASPR01MB0023.namprd15.prod.outlook.com (20.177.126.93) by
 BYAPR15MB2198.namprd15.prod.outlook.com (52.135.196.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Mon, 12 Aug 2019 21:07:27 +0000
Received: from BYASPR01MB0023.namprd15.prod.outlook.com
 ([fe80::ac2e:7dcd:ed70:fc2c]) by BYASPR01MB0023.namprd15.prod.outlook.com
 ([fe80::ac2e:7dcd:ed70:fc2c%4]) with mapi id 15.20.2136.022; Mon, 12 Aug 2019
 21:07:27 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: vmscan: do not share cgroup iteration between
 reclaimers
Thread-Topic: [PATCH] mm: vmscan: do not share cgroup iteration between
 reclaimers
Thread-Index: AQHVUUNx8y143g4rH0O5Qp3cDtgeLKb4AViA
Date:   Mon, 12 Aug 2019 21:07:27 +0000
Message-ID: <20190812210723.GA9423@tower.dhcp.thefacebook.com>
References: <20190812192316.13615-1-hannes@cmpxchg.org>
In-Reply-To: <20190812192316.13615-1-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27)
 To BYASPR01MB0023.namprd15.prod.outlook.com (2603:10b6:a03:72::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:817]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f08840cf-1c2d-4f6c-1a2f-08d71f691431
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2198;
x-ms-traffictypediagnostic: BYAPR15MB2198:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB21981429506E951F29B4F576BED30@BYAPR15MB2198.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(39860400002)(366004)(54094003)(189003)(199004)(6436002)(46003)(4326008)(5660300002)(305945005)(81166006)(53936002)(81156014)(66476007)(64756008)(66556008)(66946007)(7736002)(66446008)(478600001)(1076003)(33656002)(86362001)(6246003)(386003)(8936002)(6506007)(102836004)(8676002)(186003)(99286004)(14454004)(52116002)(229853002)(25786009)(316002)(76176011)(11346002)(6486002)(6916009)(6116002)(476003)(486006)(71190400001)(71200400001)(54906003)(446003)(14444005)(2906002)(6512007)(256004)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2198;H:BYASPR01MB0023.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lrE1cPPx7Pu6P/vh7XiHYGc1ZRfx8oxGNKVrp9FDsginnZflevgD8G43QdHcotY6RyeCAaP+JRz22RAnrNuY5U7MhjONzFS7YL4diSkYeEw/+0YKQgugNKZZS48OGP521tfNyPccyrJS5YveLDUAA7WMZuJS3Qf1BzLmKXQZBPYFRzpLoZ50cxOm47O51HInK+OHYDl6CfrQap9EGVDt2vhMdURYjk0vUzcw87JatUrNMmI2edKIe4m3ktRVtiWBxy5rOo3i8VNumtYspOLTvz+lseBhnMCRhZ5cAlrQEi+oJStrekV4vbsDWp4WMPJHV+4htH0o8Qdy2Llg6KiO1krLRFZumZTJihS3Sg2lm9FrZBfjAgsnoQMMkV7tCZ431DZ2/CMtQB9xEXL6cJk5b/5WiX9nK9LvDc+kmbqWIJE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <479A78A55F73BE4F993CA3F36F15FFD8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f08840cf-1c2d-4f6c-1a2f-08d71f691431
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 21:07:27.4939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2198
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120205
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 12, 2019 at 03:23:16PM -0400, Johannes Weiner wrote:
> One of our services observed a high rate of cgroup OOM kills in the
> presence of large amounts of clean cache. Debugging showed that the
> culprit is the shared cgroup iteration in page reclaim.
>=20
> Under high allocation concurrency, multiple threads enter reclaim at
> the same time. Fearing overreclaim when we first switched from the
> single global LRU to cgrouped LRU lists, we introduced a shared
> iteration state for reclaim invocations - whether 1 or 20 reclaimers
> are active concurrently, we only walk the cgroup tree once: the 1st
> reclaimer reclaims the first cgroup, the second the second one etc.
> With more reclaimers than cgroups, we start another walk from the top.
>=20
> This sounded reasonable at the time, but the problem is that reclaim
> concurrency doesn't scale with allocation concurrency. As reclaim
> concurrency increases, the amount of memory individual reclaimers get
> to scan gets smaller and smaller. Individual reclaimers may only see
> one cgroup per cycle, and that may not have much reclaimable
> memory. We see individual reclaimers declare OOM when there is plenty
> of reclaimable memory available in cgroups they didn't visit.

Nice catch!


>=20
> This patch does away with the shared iterator, and every reclaimer is
> allowed to scan the full cgroup tree and see all of reclaimable
> memory, just like it would on a non-cgrouped system. This way, when
> OOM is declared, we know that the reclaimer actually had a chance.
>=20
> To still maintain fairness in reclaim pressure, disallow cgroup
> reclaim from bailing out of the tree walk early. Kswapd and regular
> direct reclaim already don't bail, so it's not clear why limit reclaim
> would have to, especially since it only walks subtrees to begin with.
>=20
> This change completely eliminates the OOM kills on our service, while
> showing no signs of overreclaim - no increased scan rates, %sys time,
> or abrupt free memory spikes. I tested across 100 machines that have
> 64G of RAM and host about 300 cgroups each.
>=20
> [ It's possible overreclaim never was a *practical* issue to begin
>   with - it was simply a concern we had on the mailing lists at the
>   time, with no real data to back it up. But we have also added more
>   bail-out conditions deeper inside reclaim (e.g. the proportional
>   exit in shrink_node_memcg) since. Regardless, now we have data that
>   suggests full walks are more reliable and scale just fine. ]
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index dbdc46a84f63..b2f10fa49c88 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2667,10 +2667,6 @@ static bool shrink_node(pg_data_t *pgdat, struct s=
can_control *sc)
> =20
>  	do {
>  		struct mem_cgroup *root =3D sc->target_mem_cgroup;
> -		struct mem_cgroup_reclaim_cookie reclaim =3D {
> -			.pgdat =3D pgdat,
> -			.priority =3D sc->priority,
> -		};
>  		unsigned long node_lru_pages =3D 0;
>  		struct mem_cgroup *memcg;
> =20
> @@ -2679,7 +2675,7 @@ static bool shrink_node(pg_data_t *pgdat, struct sc=
an_control *sc)
>  		nr_reclaimed =3D sc->nr_reclaimed;
>  		nr_scanned =3D sc->nr_scanned;
> =20
> -		memcg =3D mem_cgroup_iter(root, NULL, &reclaim);
> +		memcg =3D mem_cgroup_iter(root, NULL, NULL);

I wonder if we can remove the shared memcg tree walking at all? It seems th=
at
the only use case left is the soft limit, and the same logic can be applied
to it. The we potentially can remove a lot of code in mem_cgroup_iter().
Just an idea...

>  		do {
>  			unsigned long lru_pages;
>  			unsigned long reclaimed;
> @@ -2724,21 +2720,7 @@ static bool shrink_node(pg_data_t *pgdat, struct s=
can_control *sc)
>  				   sc->nr_scanned - scanned,
>  				   sc->nr_reclaimed - reclaimed);
> =20
> -			/*
> -			 * Kswapd have to scan all memory cgroups to fulfill
> -			 * the overall scan target for the node.
> -			 *
> -			 * Limit reclaim, on the other hand, only cares about
> -			 * nr_to_reclaim pages to be reclaimed and it will
> -			 * retry with decreasing priority if one round over the
> -			 * whole hierarchy is not sufficient.
> -			 */
> -			if (!current_is_kswapd() &&
> -					sc->nr_reclaimed >=3D sc->nr_to_reclaim) {
> -				mem_cgroup_iter_break(root, memcg);
> -				break;
> -			}
> -		} while ((memcg =3D mem_cgroup_iter(root, memcg, &reclaim)));
> +		} while ((memcg =3D mem_cgroup_iter(root, memcg, NULL)));
> =20
>  		if (reclaim_state) {
>  			sc->nr_reclaimed +=3D reclaim_state->reclaimed_slab;
> --=20
> 2.22.0
>

Otherwise looks good to me!

Reviewed-by: Roman Gushchin <guro@fb.com>
