Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A9E0CB1
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 21:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbfJVTlH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 15:41:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63162 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbfJVTlH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 15:41:07 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MJdquj013086;
        Tue, 22 Oct 2019 12:40:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Yyld/l3iBVpg6QGUiVTQuQUs4aorX0m4S27DlFqcmNs=;
 b=SYwxQXRPkl8nwTl0GuaBzq0tuVBm5a9Uzy4picTsKpMBgZgI+YV2VFRWpBkwlLMQzyOV
 Ovschpf4nDslPZwmZbJphYX5vs8DAWwfe6cHzCqLuETpj/S8IdMdqwfSh0ZtxMDSq+G8
 YkmbQJmknSsx79LZrChPT3WLNxg8S9NZS1A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vsp6bw29u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Oct 2019 12:40:56 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Oct 2019 12:40:55 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 12:40:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjJiZFqWla+0G/TqcPwqsC7JvHgOpwmhKNYsMiHIVYKk6YKONt3spc7jbS9QbEWOYRqOyenW+xKg9+Q1cJNsD9WaOEHJqYBOMJzH62+xwFqwTyxE92nMB81ys1TyTlhzVnwG5F5tKY8k6x+AnHGmnDZi2TDA2F7B8FwGVGBYes0JQqQc5F/hxJkn0kK5p8IKm6P+cwvLU4OFqjgdhBE2x9sJgZgCwkI5wkojQhgfycJwxVkDkG4rMMFJ/TUeTqckprFBp7XYhCbNPJcq1Wmqh6y01QlW/PodBkdMyhRxg9a1REePn+Ry4maoxAzqHncrCNtjIobaFeqcWigx344LTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyld/l3iBVpg6QGUiVTQuQUs4aorX0m4S27DlFqcmNs=;
 b=VDH80wAaXt5qNCTEhuvtxJ+BotRC+1djbABq7E9MaDwZl/iYsfear+xmSjyv8EK4q7OSF18bADqsvVRhnFgZysuEebQakiYovQwcw8wzQVmac/5h8C8nrncK/D8Ax7DjRlafWj2jwLwSfrEiRu8nmwCZejlHKAc6fYpKUSThkn2Z4+oOEoYG4XmL1+umur6Fh3NLCG7WK7EnjuZxuCnyN/duL9dezSaVx/oDfuTIzI9IFB8fRiJGPEVRzxN/EStI++LUkQqLAT9JWJh0pDKaptyeMZPDif2iDIdky68SSmTMVzdv/9lfr58mvUVTCJrc7qnP6Cm5K6RDMDhYuNcZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyld/l3iBVpg6QGUiVTQuQUs4aorX0m4S27DlFqcmNs=;
 b=HMG1kpDaJc62VPqcM9TMTJ04d8XW0Wa7+abeJ7LKhAQoVV4Oiz7YCzeEahc3r/kLK3o4El58w3/bGcDPCDMC2U7sFSU4Q4CIKOMWwixXN977Qlwoj9qWoqN49R3VzIx0C1SBwU0fysJxZjkA/YDStH4DOQj1MP/YxbBAeijCQTI=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2531.namprd15.prod.outlook.com (20.179.140.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Tue, 22 Oct 2019 19:40:52 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 19:40:52 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 4/8] mm: vmscan: naming fixes: global_reclaim() and
 sane_reclaim()
Thread-Topic: [PATCH 4/8] mm: vmscan: naming fixes: global_reclaim() and
 sane_reclaim()
Thread-Index: AQHViOfGvfHB1RVNUEqJs289GMlc3qdnD2UA
Date:   Tue, 22 Oct 2019 19:40:52 +0000
Message-ID: <20191022194048.GA22721@tower.DHCP.thefacebook.com>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-5-hannes@cmpxchg.org>
In-Reply-To: <20191022144803.302233-5-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0092.namprd19.prod.outlook.com
 (2603:10b6:320:1f::30) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdd27fb6-956a-4bb8-e035-08d75727bf7b
x-ms-traffictypediagnostic: BN8PR15MB2531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB2531D2CA013661572096CED0BE680@BN8PR15MB2531.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(136003)(376002)(366004)(199004)(189003)(43544003)(476003)(99286004)(66446008)(64756008)(14454004)(8936002)(86362001)(486006)(446003)(6436002)(6246003)(46003)(102836004)(6512007)(229853002)(186003)(76176011)(66476007)(66946007)(54906003)(9686003)(6116002)(8676002)(6486002)(66556008)(316002)(478600001)(305945005)(6916009)(81166006)(2906002)(7736002)(33656002)(6506007)(71190400001)(71200400001)(256004)(5660300002)(81156014)(52116002)(1076003)(386003)(25786009)(14444005)(4326008)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2531;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S1xwivGMTgQ9jPvZ9B9qn2S/Y0NbXHobPln2Z+pw9mggQ/K1bGVOHiD/tTWoQtlAs4fYAv5TcMbGvh7DZR/8BR+BMNT8vzmVkWOoAW/Gw76BlXaizF+KqrnahgjQsyW+PlJBlRvrhrObr4W1CsYWRV2/PnUwza73OP0RQWuQcFt/qXH7Yaa31wIX4I+PUhenTRcRFTha1zCgcvBmsTdSf3L5XIkMMLfh/aIMtY78/Z35ufKiMh0OKJJildmyV9ShMi4QIhFTHr4fHjrQcP9xUvfU8fYgkKKC0v+/WbOxv6DI5mmxMvsW6UGJnAV77YpemVlVTwPDc95YIDx5vSCz9aeGc6U8HUz+exMz+B+lkvICHf8DjDZAy4atq56/C1Ah6YPH64UN+lLs8G/9zzR5RsD8k25E13GMhZAjRACxhi/9vqyVzI5cpdFwmXog7OMN
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5AE45F65CD7F8B4B8921E2F7B23987C0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd27fb6-956a-4bb8-e035-08d75727bf7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 19:40:52.6390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgA2byRF7afNhZBQTb7RsQvJvvTjSsHG0zaSNtGzkGp5Gd4ZTATQwOrK26eVgAWp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2531
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_06:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220165
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 10:47:59AM -0400, Johannes Weiner wrote:
> Seven years after introducing the global_reclaim() function, I still
> have to double take when reading a callsite. I don't know how others
> do it, this is a terrible name.
>=20
> Invert the meaning and rename it to cgroup_reclaim().
>=20
> [ After all, "global reclaim" is just regular reclaim invoked from the
>   page allocator. It's reclaim on behalf of a cgroup limit that is a
>   special case of reclaim, and should be explicit - not the reverse. ]
>=20
> sane_reclaim() isn't very descriptive either: it tests whether we can
> use the regular writeback throttling - available during regular page
> reclaim or cgroup2 limit reclaim - or need to use the broken
> wait_on_page_writeback() method. Use "writeback_throttling_sane()".
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 38 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 622b77488144..302dad112f75 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -239,13 +239,13 @@ static void unregister_memcg_shrinker(struct shrink=
er *shrinker)
>  	up_write(&shrinker_rwsem);
>  }
> =20
> -static bool global_reclaim(struct scan_control *sc)
> +static bool cgroup_reclaim(struct scan_control *sc)
>  {
> -	return !sc->target_mem_cgroup;
> +	return sc->target_mem_cgroup;
>  }

Isn't targeted_reclaim() better?

cgroup_reclaim() is also ok to me, but it sounds a bit like we reclaim
from this specific cgroup. Also targeted/global is IMO a better opposition
than cgroup/global (the latter reminds me days when there were global
and cgroup LRUs).

The rest of the patch looks good!

Reviewed-by: Roman Gushchin <guro@fb.com>

> =20
>  /**
> - * sane_reclaim - is the usual dirty throttling mechanism operational?
> + * writeback_throttling_sane - is the usual dirty throttling mechanism a=
vailable?
>   * @sc: scan_control in question
>   *
>   * The normal page dirty throttling mechanism in balance_dirty_pages() i=
s
> @@ -257,11 +257,9 @@ static bool global_reclaim(struct scan_control *sc)
>   * This function tests whether the vmscan currently in progress can assu=
me
>   * that the normal dirty throttling mechanism is operational.
>   */
> -static bool sane_reclaim(struct scan_control *sc)
> +static bool writeback_throttling_sane(struct scan_control *sc)
>  {
> -	struct mem_cgroup *memcg =3D sc->target_mem_cgroup;
> -
> -	if (!memcg)
> +	if (!cgroup_reclaim(sc))
>  		return true;
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> @@ -302,12 +300,12 @@ static void unregister_memcg_shrinker(struct shrink=
er *shrinker)
>  {
>  }
> =20
> -static bool global_reclaim(struct scan_control *sc)
> +static bool cgroup_reclaim(struct scan_control *sc)
>  {
> -	return true;
> +	return false;
>  }
> =20
> -static bool sane_reclaim(struct scan_control *sc)
> +static bool writeback_throttling_sane(struct scan_control *sc)
>  {
>  	return true;
>  }
> @@ -1227,7 +1225,7 @@ static unsigned long shrink_page_list(struct list_h=
ead *page_list,
>  				goto activate_locked;
> =20
>  			/* Case 2 above */
> -			} else if (sane_reclaim(sc) ||
> +			} else if (writeback_throttling_sane(sc) ||
>  			    !PageReclaim(page) || !may_enter_fs) {
>  				/*
>  				 * This is slightly racy - end_page_writeback()
> @@ -1821,7 +1819,7 @@ static int too_many_isolated(struct pglist_data *pg=
dat, int file,
>  	if (current_is_kswapd())
>  		return 0;
> =20
> -	if (!sane_reclaim(sc))
> +	if (!writeback_throttling_sane(sc))
>  		return 0;
> =20
>  	if (file) {
> @@ -1971,7 +1969,7 @@ shrink_inactive_list(unsigned long nr_to_scan, stru=
ct lruvec *lruvec,
>  	reclaim_stat->recent_scanned[file] +=3D nr_taken;
> =20
>  	item =3D current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
> -	if (global_reclaim(sc))
> +	if (!cgroup_reclaim(sc))
>  		__count_vm_events(item, nr_scanned);
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
>  	spin_unlock_irq(&pgdat->lru_lock);
> @@ -1985,7 +1983,7 @@ shrink_inactive_list(unsigned long nr_to_scan, stru=
ct lruvec *lruvec,
>  	spin_lock_irq(&pgdat->lru_lock);
> =20
>  	item =3D current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> -	if (global_reclaim(sc))
> +	if (!cgroup_reclaim(sc))
>  		__count_vm_events(item, nr_reclaimed);
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
>  	reclaim_stat->recent_rotated[0] +=3D stat.nr_activate[0];
> @@ -2309,7 +2307,7 @@ static void get_scan_count(struct lruvec *lruvec, s=
truct mem_cgroup *memcg,
>  	 * using the memory controller's swap limit feature would be
>  	 * too expensive.
>  	 */
> -	if (!global_reclaim(sc) && !swappiness) {
> +	if (cgroup_reclaim(sc) && !swappiness) {
>  		scan_balance =3D SCAN_FILE;
>  		goto out;
>  	}
> @@ -2333,7 +2331,7 @@ static void get_scan_count(struct lruvec *lruvec, s=
truct mem_cgroup *memcg,
>  	 * thrashing file LRU becomes infinitely more attractive than
>  	 * anon pages.  Try to detect this based on file LRU size.
>  	 */
> -	if (global_reclaim(sc)) {
> +	if (!cgroup_reclaim(sc)) {
>  		unsigned long pgdatfile;
>  		unsigned long pgdatfree;
>  		int z;
> @@ -2564,7 +2562,7 @@ static void shrink_node_memcg(struct pglist_data *p=
gdat, struct mem_cgroup *memc
>  	 * abort proportional reclaim if either the file or anon lru has alread=
y
>  	 * dropped to zero at the first pass.
>  	 */
> -	scan_adjusted =3D (global_reclaim(sc) && !current_is_kswapd() &&
> +	scan_adjusted =3D (!cgroup_reclaim(sc) && !current_is_kswapd() &&
>  			 sc->priority =3D=3D DEF_PRIORITY);
> =20
>  	blk_start_plug(&plug);
> @@ -2853,7 +2851,7 @@ static bool shrink_node(pg_data_t *pgdat, struct sc=
an_control *sc)
>  		 * Legacy memcg will stall in page writeback so avoid forcibly
>  		 * stalling in wait_iff_congested().
>  		 */
> -		if (!global_reclaim(sc) && sane_reclaim(sc) &&
> +		if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
>  		    sc->nr.dirty && sc->nr.dirty =3D=3D sc->nr.congested)
>  			set_memcg_congestion(pgdat, root, true);
> =20
> @@ -2948,7 +2946,7 @@ static void shrink_zones(struct zonelist *zonelist,=
 struct scan_control *sc)
>  		 * Take care memory controller reclaiming has small influence
>  		 * to global LRU.
>  		 */
> -		if (global_reclaim(sc)) {
> +		if (!cgroup_reclaim(sc)) {
>  			if (!cpuset_zone_allowed(zone,
>  						 GFP_KERNEL | __GFP_HARDWALL))
>  				continue;
> @@ -3048,7 +3046,7 @@ static unsigned long do_try_to_free_pages(struct zo=
nelist *zonelist,
>  retry:
>  	delayacct_freepages_start();
> =20
> -	if (global_reclaim(sc))
> +	if (!cgroup_reclaim(sc))
>  		__count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
> =20
>  	do {
> --=20
> 2.23.0
>=20
