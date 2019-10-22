Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA8F7E0CEB
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 21:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbfJVT4r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 15:56:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50200 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388843AbfJVT4q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 15:56:46 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MJslUq011770;
        Tue, 22 Oct 2019 12:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7ZloJzY3ufLgBoF7TowPMneSzI88EJC36MsIyufKxOU=;
 b=bz8lw1xWzqNtx8YT+OWnmssICIYy7x6ImuvI54zP4Ah1BIXGYKfex0/K1LWsNcT7gno8
 f16xsyx3OBCWSSLyac3+zPMOCYMnF58yJdPZX/v6EGPpVwqQvK6Kg3FIQv11GNDnHWdl
 mpM+uWZg51gLhLgGfjDRLXXO3UPKC/RZIdo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vsp6bw4h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 12:56:37 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 22 Oct 2019 12:56:36 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 12:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpCsUvWmhRfhJZYIEwQPhMiKil8nvJ2f4o1U+czSEp6pmQGhE28A2yf3/D7w+6yff8h9eYeb/8+0uBQfjKWQ7Kh6P2CeJsAHjjWZLv3d+y81rq1FEXuJeic84mcIsBCFGAghzDZ/Eg3j9f0z/s841Ub2fUSAMv2hZYBy51u4a3ZB4fGa6zO+EGSzbL+WQfH+FYz5Q0ViDh86odyQw7IXp6UNmNm+ihTPuiAdV6aL1p7jgBgsUKUWb0HMGRzxiBOWTFrkVfpZUDIOb+CAlshAj7stNRFAYVvfC1LMhYDCM2ceBCUCjQgaPaSurfHt3DLkCdFph0+yifjLuG0Abeyt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZloJzY3ufLgBoF7TowPMneSzI88EJC36MsIyufKxOU=;
 b=aLpdvTqmvnP1POCzjdtkU0IgyxiFIppeJdaR+/QgNA3y4ScHfESD5yv22ptnISxM1ej/S+5CjGejjQmqGvG1nVgXeX/nz3XqHO8lrZT7HF9Rl29MDYkKBX69ctZ8cLyCOMsDbK6EWi8ZRnBN6fGooS9Q9sWaD/spO9C7Io7F2Z+NERu8J58B4YmSKMGrY58bVNc7VYKXkT3aK8VVG79OIe+JJc9wQRtttwXZTvo9avS+YP0MKFVcXwBwiBV+p4NL8EGyLy+wZ6HDMk4IB61Wu1NeMEO1NqCIxMZy53o+UE7zQz+flCWDgXfyE+oVu1u5OmEtYKTlt/7UniZwc7fVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZloJzY3ufLgBoF7TowPMneSzI88EJC36MsIyufKxOU=;
 b=URH/zAs9L95fbl96Uxr5LN8gzik9XdNHCltPjsQZZroxZUVmC2yhgVs+W4l+c2+jYqwzSjp9mF+hCRBGAp+79cWmQLeqEawzS43JQssJ8mFNwabmvw+viHlVi0qmP27hq08ZptqTif4w7UCiWl0AVCLlL3Oe8zZeGMN3rF1Ynew=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3442.namprd15.prod.outlook.com (20.179.74.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Tue, 22 Oct 2019 19:56:33 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 19:56:33 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 5/8] mm: vmscan: replace shrink_node() loop with a retry
 jump
Thread-Topic: [PATCH 5/8] mm: vmscan: replace shrink_node() loop with a retry
 jump
Thread-Index: AQHViOfIg7Ukgv6lUkWvXEXYWe2LvqdnE8aA
Date:   Tue, 22 Oct 2019 19:56:33 +0000
Message-ID: <20191022195629.GA24142@tower.DHCP.thefacebook.com>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-6-hannes@cmpxchg.org>
In-Reply-To: <20191022144803.302233-6-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f64378ae-ce99-4334-2e82-08d75729f057
x-ms-traffictypediagnostic: BN8PR15MB3442:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB3442599B940C3E0E6B17603BBE680@BN8PR15MB3442.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(396003)(366004)(199004)(189003)(81156014)(76176011)(71190400001)(81166006)(1076003)(71200400001)(54906003)(14454004)(8676002)(8936002)(316002)(66556008)(66476007)(64756008)(66446008)(66946007)(7736002)(305945005)(5660300002)(86362001)(2906002)(33656002)(6116002)(99286004)(6246003)(52116002)(229853002)(186003)(256004)(11346002)(386003)(4326008)(6506007)(25786009)(6486002)(9686003)(476003)(6916009)(446003)(6436002)(486006)(478600001)(6512007)(102836004)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3442;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RxidOEyQybazrEYgBbykywS0ajKlO8ApuPW8sH7YYC6VVnyYJ8XBlcMlHTEEBfmjd4TNHC5mDaMq5vkuf+YNaLOm8X5jaGkbsHK8KgM7fh4COU0HMaYK4BZNA0bILus/IcU9nab9/EMFnsPSpbqmLKULUr6SOhTdbBylpJ9ZeBEn21GmzMmMzD3OtH1uvC3ysZXR4TQkg1vZ4YIJCdRiqCZLcl6vTI0HddZ3sg1yJzNqMfKSM5JIRQgMucnNcBm7XAOqK/Le234MMWexxUb5SMqKU+jQAksgEs9X6bQcSasL971BhznWCG+SXAYc7HbbTrvVwIMKKVIlzYllGaxmgQk+GytKXS7ZKvfSSttJwz5XeN0hT8seY+14Yx5ySdILaycuxCJX0jA072rJJLp9V9WSg0SU+DaVhWylHfGiYngsLHMA6mRTBPwx2fWU+c96
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87657937D7258B45A5F352CB2FFE9325@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f64378ae-ce99-4334-2e82-08d75729f057
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 19:56:33.6394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BNfm/rAs9F3LMoP6lOxGSZezeB87KnQ924A12ajByGm9MvnP0EfRU61ZqPO2R3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3442
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_06:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220168
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 10:48:00AM -0400, Johannes Weiner wrote:
> Most of the function body is inside a loop, which imposes an
> additional indentation and scoping level that makes the code a bit
> hard to follow and modify.
>=20
> The looping only happens in case of reclaim-compaction, which isn't
> the common case. So rather than adding yet another function level to
> the reclaim path and have every reclaim invocation go through a level
> that only exists for one specific cornercase, use a retry goto.
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 231 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 115 insertions(+), 116 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 302dad112f75..235d1fc72311 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2729,144 +2729,143 @@ static bool pgdat_memcg_congested(pg_data_t *pg=
dat, struct mem_cgroup *memcg)
>  static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  {
>  	struct reclaim_state *reclaim_state =3D current->reclaim_state;
> +	struct mem_cgroup *root =3D sc->target_mem_cgroup;
>  	unsigned long nr_reclaimed, nr_scanned;
>  	bool reclaimable =3D false;
> +	struct mem_cgroup *memcg;
> +again:
> +	memset(&sc->nr, 0, sizeof(sc->nr));
> =20
> -	do {
> -		struct mem_cgroup *root =3D sc->target_mem_cgroup;
> -		struct mem_cgroup *memcg;
> -
> -		memset(&sc->nr, 0, sizeof(sc->nr));
> -
> -		nr_reclaimed =3D sc->nr_reclaimed;
> -		nr_scanned =3D sc->nr_scanned;
> +	nr_reclaimed =3D sc->nr_reclaimed;
> +	nr_scanned =3D sc->nr_scanned;
> =20
> -		memcg =3D mem_cgroup_iter(root, NULL, NULL);
> -		do {
> -			unsigned long reclaimed;
> -			unsigned long scanned;
> +	memcg =3D mem_cgroup_iter(root, NULL, NULL);
> +	do {
> +		unsigned long reclaimed;
> +		unsigned long scanned;
> =20
> -			switch (mem_cgroup_protected(root, memcg)) {
> -			case MEMCG_PROT_MIN:
> -				/*
> -				 * Hard protection.
> -				 * If there is no reclaimable memory, OOM.
> -				 */
> +		switch (mem_cgroup_protected(root, memcg)) {
> +		case MEMCG_PROT_MIN:
> +			/*
> +			 * Hard protection.
> +			 * If there is no reclaimable memory, OOM.
> +			 */
> +			continue;
> +		case MEMCG_PROT_LOW:
> +			/*
> +			 * Soft protection.
> +			 * Respect the protection only as long as
> +			 * there is an unprotected supply
> +			 * of reclaimable memory from other cgroups.
> +			 */
> +			if (!sc->memcg_low_reclaim) {
> +				sc->memcg_low_skipped =3D 1;
>  				continue;
> -			case MEMCG_PROT_LOW:
> -				/*
> -				 * Soft protection.
> -				 * Respect the protection only as long as
> -				 * there is an unprotected supply
> -				 * of reclaimable memory from other cgroups.
> -				 */
> -				if (!sc->memcg_low_reclaim) {
> -					sc->memcg_low_skipped =3D 1;
> -					continue;
> -				}
> -				memcg_memory_event(memcg, MEMCG_LOW);
> -				break;
> -			case MEMCG_PROT_NONE:
> -				/*
> -				 * All protection thresholds breached. We may
> -				 * still choose to vary the scan pressure
> -				 * applied based on by how much the cgroup in
> -				 * question has exceeded its protection
> -				 * thresholds (see get_scan_count).
> -				 */
> -				break;
>  			}
> +			memcg_memory_event(memcg, MEMCG_LOW);
> +			break;
> +		case MEMCG_PROT_NONE:
> +			/*
> +			 * All protection thresholds breached. We may
> +			 * still choose to vary the scan pressure
> +			 * applied based on by how much the cgroup in
> +			 * question has exceeded its protection
> +			 * thresholds (see get_scan_count).
> +			 */
> +			break;
> +		}
> =20
> -			reclaimed =3D sc->nr_reclaimed;
> -			scanned =3D sc->nr_scanned;
> -			shrink_node_memcg(pgdat, memcg, sc);
> -
> -			shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> -					sc->priority);
> -
> -			/* Record the group's reclaim efficiency */
> -			vmpressure(sc->gfp_mask, memcg, false,
> -				   sc->nr_scanned - scanned,
> -				   sc->nr_reclaimed - reclaimed);
> -
> -		} while ((memcg =3D mem_cgroup_iter(root, memcg, NULL)));
> +		reclaimed =3D sc->nr_reclaimed;
> +		scanned =3D sc->nr_scanned;
> +		shrink_node_memcg(pgdat, memcg, sc);
> =20
> -		if (reclaim_state) {
> -			sc->nr_reclaimed +=3D reclaim_state->reclaimed_slab;
> -			reclaim_state->reclaimed_slab =3D 0;
> -		}
> +		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> +			    sc->priority);
> =20
> -		/* Record the subtree's reclaim efficiency */
> -		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> -			   sc->nr_scanned - nr_scanned,
> -			   sc->nr_reclaimed - nr_reclaimed);
> +		/* Record the group's reclaim efficiency */
> +		vmpressure(sc->gfp_mask, memcg, false,
> +			   sc->nr_scanned - scanned,
> +			   sc->nr_reclaimed - reclaimed);

It doesn't look as a trivial change. I'd add some comments to the commit me=
ssage
why it's safe to do.

Thanks!

> =20
> -		if (sc->nr_reclaimed - nr_reclaimed)
> -			reclaimable =3D true;
> +	} while ((memcg =3D mem_cgroup_iter(root, memcg, NULL)));
> =20
> -		if (current_is_kswapd()) {
> -			/*
> -			 * If reclaim is isolating dirty pages under writeback,
> -			 * it implies that the long-lived page allocation rate
> -			 * is exceeding the page laundering rate. Either the
> -			 * global limits are not being effective at throttling
> -			 * processes due to the page distribution throughout
> -			 * zones or there is heavy usage of a slow backing
> -			 * device. The only option is to throttle from reclaim
> -			 * context which is not ideal as there is no guarantee
> -			 * the dirtying process is throttled in the same way
> -			 * balance_dirty_pages() manages.
> -			 *
> -			 * Once a node is flagged PGDAT_WRITEBACK, kswapd will
> -			 * count the number of pages under pages flagged for
> -			 * immediate reclaim and stall if any are encountered
> -			 * in the nr_immediate check below.
> -			 */
> -			if (sc->nr.writeback && sc->nr.writeback =3D=3D sc->nr.taken)
> -				set_bit(PGDAT_WRITEBACK, &pgdat->flags);
> +	if (reclaim_state) {
> +		sc->nr_reclaimed +=3D reclaim_state->reclaimed_slab;
> +		reclaim_state->reclaimed_slab =3D 0;
> +	}
> =20
> -			/*
> -			 * Tag a node as congested if all the dirty pages
> -			 * scanned were backed by a congested BDI and
> -			 * wait_iff_congested will stall.
> -			 */
> -			if (sc->nr.dirty && sc->nr.dirty =3D=3D sc->nr.congested)
> -				set_bit(PGDAT_CONGESTED, &pgdat->flags);
> +	/* Record the subtree's reclaim efficiency */
> +	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> +		   sc->nr_scanned - nr_scanned,
> +		   sc->nr_reclaimed - nr_reclaimed);
> =20
> -			/* Allow kswapd to start writing pages during reclaim.*/
> -			if (sc->nr.unqueued_dirty =3D=3D sc->nr.file_taken)
> -				set_bit(PGDAT_DIRTY, &pgdat->flags);
> +	if (sc->nr_reclaimed - nr_reclaimed)
> +		reclaimable =3D true;
> =20
> -			/*
> -			 * If kswapd scans pages marked marked for immediate
> -			 * reclaim and under writeback (nr_immediate), it
> -			 * implies that pages are cycling through the LRU
> -			 * faster than they are written so also forcibly stall.
> -			 */
> -			if (sc->nr.immediate)
> -				congestion_wait(BLK_RW_ASYNC, HZ/10);
> -		}

Don't you want to separate the block below into a separate function?
It can probably make the big loop shorter and easier to follow.

Thanks!

> +	if (current_is_kswapd()) {
> +		/*
> +		 * If reclaim is isolating dirty pages under writeback,
> +		 * it implies that the long-lived page allocation rate
> +		 * is exceeding the page laundering rate. Either the
> +		 * global limits are not being effective at throttling
> +		 * processes due to the page distribution throughout
> +		 * zones or there is heavy usage of a slow backing
> +		 * device. The only option is to throttle from reclaim
> +		 * context which is not ideal as there is no guarantee
> +		 * the dirtying process is throttled in the same way
> +		 * balance_dirty_pages() manages.
> +		 *
> +		 * Once a node is flagged PGDAT_WRITEBACK, kswapd will
> +		 * count the number of pages under pages flagged for
> +		 * immediate reclaim and stall if any are encountered
> +		 * in the nr_immediate check below.
> +		 */
> +		if (sc->nr.writeback && sc->nr.writeback =3D=3D sc->nr.taken)
> +			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
> =20
>  		/*
> -		 * Legacy memcg will stall in page writeback so avoid forcibly
> -		 * stalling in wait_iff_congested().
> +		 * Tag a node as congested if all the dirty pages
> +		 * scanned were backed by a congested BDI and
> +		 * wait_iff_congested will stall.
>  		 */
> -		if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
> -		    sc->nr.dirty && sc->nr.dirty =3D=3D sc->nr.congested)
> -			set_memcg_congestion(pgdat, root, true);
> +		if (sc->nr.dirty && sc->nr.dirty =3D=3D sc->nr.congested)
> +			set_bit(PGDAT_CONGESTED, &pgdat->flags);
> +
> +		/* Allow kswapd to start writing pages during reclaim.*/
> +		if (sc->nr.unqueued_dirty =3D=3D sc->nr.file_taken)
> +			set_bit(PGDAT_DIRTY, &pgdat->flags);
> =20
>  		/*
> -		 * Stall direct reclaim for IO completions if underlying BDIs
> -		 * and node is congested. Allow kswapd to continue until it
> -		 * starts encountering unqueued dirty pages or cycling through
> -		 * the LRU too quickly.
> +		 * If kswapd scans pages marked marked for immediate
> +		 * reclaim and under writeback (nr_immediate), it
> +		 * implies that pages are cycling through the LRU
> +		 * faster than they are written so also forcibly stall.
>  		 */
> -		if (!sc->hibernation_mode && !current_is_kswapd() &&
> -		   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
> -			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
> +		if (sc->nr.immediate)
> +			congestion_wait(BLK_RW_ASYNC, HZ/10);
> +	}
> +
> +	/*
> +	 * Legacy memcg will stall in page writeback so avoid forcibly
> +	 * stalling in wait_iff_congested().
> +	 */
> +	if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
> +	    sc->nr.dirty && sc->nr.dirty =3D=3D sc->nr.congested)
> +		set_memcg_congestion(pgdat, root, true);
> +
> +	/*
> +	 * Stall direct reclaim for IO completions if underlying BDIs
> +	 * and node is congested. Allow kswapd to continue until it
> +	 * starts encountering unqueued dirty pages or cycling through
> +	 * the LRU too quickly.
> +	 */
> +	if (!sc->hibernation_mode && !current_is_kswapd() &&
> +	    current_may_throttle() && pgdat_memcg_congested(pgdat, root))
> +		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
> =20
> -	} while (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed=
,
> -					 sc));
> +	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
> +				    sc))
> +		goto again;
> =20
>  	/*
>  	 * Kswapd gives up on balancing particular nodes after too
> --=20
> 2.23.0
>=20
>=20
