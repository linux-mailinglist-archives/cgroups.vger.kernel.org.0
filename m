Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA994E0D9E
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfJVVEK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 17:04:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32736 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbfJVVEK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 17:04:10 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9ML3Imx026476;
        Tue, 22 Oct 2019 14:04:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RhsP7dv4/82wcdqo3Emn1e2VnwUblBDFe4h6kHkeJwU=;
 b=VOlcb2W6c1YX4KivnmA1NHuNrwkS0Y1IIAPoH9RC3eDLHxng6JBwPPBPqhTY/HXlDgGg
 D94X+HzIibYakM2inM73Ahz5x5S0xdCScOiEIyNYZqTqaLKqlg3UbNj99p1mS/qPaEzS
 w+NSQWTmCBN6BvinyEPv/T2TvOLDnoyDJAo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vt4ysse82-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 14:04:03 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 22 Oct 2019 14:03:59 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 14:03:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjZfeUcpcccqT3cQvl+k1Ia6ZTgCrvWQk2Y/Sged57Xvk81ptgdRXxI9Y5Mk1pxRHVH02K9KjCRSi0O9CjIGJ6geeJDR9AP3bFgSHRx9VreK++OyVENVjURdAEMhKydBnLSh5KJWdBaLzUCKy5eEjvHylQ1hMUlsS4UdKU5PL12Jk6pZFq5S5CLaKxOMqbflk0FRDTepRG9wYphKXxuOSawQbFFTTfRJoVdw8gozEiPBm/X31Mj87ylqt8nN/W/94NkFwbqbZjug1SAHVllkeS+378CSsocmFx+7jUsAefr46mZcoG8QFy3vBt7UlPGh9A2yQf9g6RNpzztanUh+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhsP7dv4/82wcdqo3Emn1e2VnwUblBDFe4h6kHkeJwU=;
 b=VYmiQBVmOflQfKg2cqFnfLV3zaecBERU/z1qTrcJAGci9WfG8sGqSMHVo9GZtrQYOdg7rNCVYrv3WZowFoUTAOEHP2L8F2aLIIdsP5OYbHSsQUKrEc3q49IM9qKe1QpwzQpht1Zg5Aphlan1ZZz9YbqUzdXXzSokuoHq78T2JsleXrfs/xAALUXf7z1IW7mFxgEeh4ZsMYiZBoeLIS1tqP9l5AOJ+IypZHXFKmlwrb76IYHQbGIIrGAZpqoqum3ADIr9WNQegMvwYh7ytp9xFzKBo9EYog4rrW2kdV36VDsLRzi/SRZt7Mml9V2PyioM7gsvKn9hR6ndsIU01IFq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhsP7dv4/82wcdqo3Emn1e2VnwUblBDFe4h6kHkeJwU=;
 b=O45aW4+TtMkywADV3BvSMre3klQYKzVUo/oi/do/QBT9woxNmnQ/Ss1YBh7W0LQJrWKUHVkb6p0zpvOy72yGHuLY9idiyv3EzK31H+eiSIk55+vTvTTtcrgheQfLR4uM4T1IPYUjoma8Q3x+ii8VvcBgXes1Ssdi6REPrt98Owg=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2578.namprd15.prod.outlook.com (20.179.139.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 22 Oct 2019 21:03:57 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 21:03:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 8/8] mm: vmscan: harmonize writeback congestion tracking
 for nodes & memcgs
Thread-Topic: [PATCH 8/8] mm: vmscan: harmonize writeback congestion tracking
 for nodes & memcgs
Thread-Index: AQHViOfOWROJHeWuvk2hQYUSZHgn+KdnJpoA
Date:   Tue, 22 Oct 2019 21:03:57 +0000
Message-ID: <20191022210352.GB24142@tower.DHCP.thefacebook.com>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-9-hannes@cmpxchg.org>
In-Reply-To: <20191022144803.302233-9-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0021.namprd20.prod.outlook.com
 (2603:10b6:301:15::31) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c009f8aa-a013-4523-7498-08d757335a94
x-ms-traffictypediagnostic: BN8PR15MB2578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB257808BCA4578A739D3D9811BE680@BN8PR15MB2578.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:389;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(66946007)(2906002)(54906003)(76176011)(7736002)(71190400001)(6512007)(6916009)(316002)(305945005)(9686003)(5660300002)(71200400001)(52116002)(256004)(99286004)(1076003)(6436002)(14444005)(186003)(25786009)(33656002)(6246003)(64756008)(66476007)(478600001)(6116002)(486006)(11346002)(4326008)(8936002)(102836004)(476003)(8676002)(446003)(46003)(229853002)(6506007)(386003)(14454004)(6486002)(66556008)(86362001)(66446008)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2578;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bi+kpDMa4pVL8Q30IOD8LT0uJivjHRn8vrVy1Cn4nAdacR2Fub+rggJBh7fWbu7+aTSudXQtsyL6J+xKa3HIsK+DRAIdts3nK90klZ6WF65PQ6Luc7DgQnorOKWR6gTLrrVoNvA3KNqpHaTeRJRMXH2A5M38PhfaNL5/h8Smjy/Fx0bk7COSknfdGpnSnTnt+v0G37KiTia5YCDgD4IGUYxHF375LX/OD7599sFGagI/E0seN7Kfl7Epdzd6xzOPEWfdtG6rUAe61AfDrw+zf9pvkt1IFGawY5+8+DwX3fCf/jE7BkySx+Ba0AQhojFIfK91XSVhfEuMrXvBrujWLPmf9B/p45hH4cpy5A+5saaoE8N/WT0ixHtA3FHTZ9pOfLhi6cutDbiZuOYEn1/BCC2GMTlv2v7H73VTIJWLYFpCDlqsKAG9W6Yexa6xhdcj
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F156AB9644B27347BF2282BDA832FEE2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c009f8aa-a013-4523-7498-08d757335a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 21:03:57.2430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lulQ1RgEikABjl/5b922GmOhTeUUv/biLAGw5a/PeXp5BxvSNkszfUW1U6vz8L1+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2578
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_06:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=767 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220180
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 10:48:03AM -0400, Johannes Weiner wrote:
> The current writeback congestion tracking has separate flags for
> kswapd reclaim (node level) and cgroup limit reclaim (memcg-node
> level). This is unnecessarily complicated: the lruvec is an existing
> abstraction layer for that node-memcg intersection.
>=20
> Introduce lruvec->flags and LRUVEC_CONGESTED. Then track that at the
> reclaim root level, which is either the NUMA node for global reclaim,
> or the cgroup-node intersection for cgroup reclaim.

Good idea!

Reviewed-by: Roman Gushchin <guro@fb.com>

>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/memcontrol.h |  6 +--
>  include/linux/mmzone.h     | 11 ++++--
>  mm/vmscan.c                | 80 ++++++++++++--------------------------
>  3 files changed, 36 insertions(+), 61 deletions(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 498cea07cbb1..d8ffcf60440c 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -133,9 +133,6 @@ struct mem_cgroup_per_node {
>  	unsigned long		usage_in_excess;/* Set to the value by which */
>  						/* the soft limit is exceeded*/
>  	bool			on_tree;
> -	bool			congested;	/* memcg has many dirty pages */
> -						/* backed by a congested BDI */
> -
>  	struct mem_cgroup	*memcg;		/* Back pointer, we cannot */
>  						/* use container_of	   */
>  };
> @@ -412,6 +409,9 @@ static inline struct lruvec *mem_cgroup_lruvec(struct=
 mem_cgroup *memcg,
>  		goto out;
>  	}
> =20
> +	if (!memcg)
> +		memcg =3D root_mem_cgroup;
> +
>  	mz =3D mem_cgroup_nodeinfo(memcg, pgdat->node_id);
>  	lruvec =3D &mz->lruvec;
>  out:
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 449a44171026..c04b4c1f01fa 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -296,6 +296,12 @@ struct zone_reclaim_stat {
>  	unsigned long		recent_scanned[2];
>  };
> =20
> +enum lruvec_flags {
> +	LRUVEC_CONGESTED,		/* lruvec has many dirty pages
> +					 * backed by a congested BDI
> +					 */
> +};
> +
>  struct lruvec {
>  	struct list_head		lists[NR_LRU_LISTS];
>  	struct zone_reclaim_stat	reclaim_stat;
> @@ -303,6 +309,8 @@ struct lruvec {
>  	atomic_long_t			inactive_age;
>  	/* Refaults at the time of last reclaim cycle */
>  	unsigned long			refaults;
> +	/* Various lruvec state flags (enum lruvec_flags) */
> +	unsigned long			flags;
>  #ifdef CONFIG_MEMCG
>  	struct pglist_data *pgdat;
>  #endif
> @@ -572,9 +580,6 @@ struct zone {
>  } ____cacheline_internodealigned_in_smp;
> =20
>  enum pgdat_flags {
> -	PGDAT_CONGESTED,		/* pgdat has many dirty pages backed by
> -					 * a congested BDI
> -					 */
>  	PGDAT_DIRTY,			/* reclaim scanning has recently found
>  					 * many dirty file pages at the tail
>  					 * of the LRU.
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 65baa89740dd..3e21166d5198 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -267,29 +267,6 @@ static bool writeback_throttling_sane(struct scan_co=
ntrol *sc)
>  #endif
>  	return false;
>  }
> -
> -static void set_memcg_congestion(pg_data_t *pgdat,
> -				struct mem_cgroup *memcg,
> -				bool congested)
> -{
> -	struct mem_cgroup_per_node *mn;
> -
> -	if (!memcg)
> -		return;
> -
> -	mn =3D mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> -	WRITE_ONCE(mn->congested, congested);
> -}
> -
> -static bool memcg_congested(pg_data_t *pgdat,
> -			struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup_per_node *mn;
> -
> -	mn =3D mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> -	return READ_ONCE(mn->congested);
> -
> -}
>  #else
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
> @@ -309,18 +286,6 @@ static bool writeback_throttling_sane(struct scan_co=
ntrol *sc)
>  {
>  	return true;
>  }
> -
> -static inline void set_memcg_congestion(struct pglist_data *pgdat,
> -				struct mem_cgroup *memcg, bool congested)
> -{
> -}
> -
> -static inline bool memcg_congested(struct pglist_data *pgdat,
> -			struct mem_cgroup *memcg)
> -{
> -	return false;
> -
> -}
>  #endif
> =20
>  /*
> @@ -2716,12 +2681,6 @@ static inline bool should_continue_reclaim(struct =
pglist_data *pgdat,
>  	return inactive_lru_pages > pages_for_compaction;
>  }
> =20
> -static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *m=
emcg)
> -{
> -	return test_bit(PGDAT_CONGESTED, &pgdat->flags) ||
> -		(memcg && memcg_congested(pgdat, memcg));
> -}
> -
>  static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc=
)
>  {
>  	struct mem_cgroup *root =3D sc->target_mem_cgroup;
> @@ -2785,8 +2744,11 @@ static bool shrink_node(pg_data_t *pgdat, struct s=
can_control *sc)
>  	struct reclaim_state *reclaim_state =3D current->reclaim_state;
>  	struct mem_cgroup *root =3D sc->target_mem_cgroup;
>  	unsigned long nr_reclaimed, nr_scanned;
> +	struct lruvec *target_lruvec;
>  	bool reclaimable =3D false;
> =20
> +	target_lruvec =3D mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
> +
>  again:
>  	memset(&sc->nr, 0, sizeof(sc->nr));
> =20
> @@ -2829,14 +2791,6 @@ static bool shrink_node(pg_data_t *pgdat, struct s=
can_control *sc)
>  		if (sc->nr.writeback && sc->nr.writeback =3D=3D sc->nr.taken)
>  			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
> =20
> -		/*
> -		 * Tag a node as congested if all the dirty pages
> -		 * scanned were backed by a congested BDI and
> -		 * wait_iff_congested will stall.
> -		 */
> -		if (sc->nr.dirty && sc->nr.dirty =3D=3D sc->nr.congested)
> -			set_bit(PGDAT_CONGESTED, &pgdat->flags);
> -
>  		/* Allow kswapd to start writing pages during reclaim.*/
>  		if (sc->nr.unqueued_dirty =3D=3D sc->nr.file_taken)
>  			set_bit(PGDAT_DIRTY, &pgdat->flags);
> @@ -2852,12 +2806,17 @@ static bool shrink_node(pg_data_t *pgdat, struct =
scan_control *sc)
>  	}
> =20
>  	/*
> +	 * Tag a node/memcg as congested if all the dirty pages
> +	 * scanned were backed by a congested BDI and
> +	 * wait_iff_congested will stall.
> +	 *
>  	 * Legacy memcg will stall in page writeback so avoid forcibly
>  	 * stalling in wait_iff_congested().
>  	 */
> -	if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
> +	if ((current_is_kswapd() ||
> +	     (cgroup_reclaim(sc) && writeback_throttling_sane(sc))) &&
>  	    sc->nr.dirty && sc->nr.dirty =3D=3D sc->nr.congested)
> -		set_memcg_congestion(pgdat, root, true);
> +		set_bit(LRUVEC_CONGESTED, &target_lruvec->flags);
> =20
>  	/*
>  	 * Stall direct reclaim for IO completions if underlying BDIs
> @@ -2865,8 +2824,9 @@ static bool shrink_node(pg_data_t *pgdat, struct sc=
an_control *sc)
>  	 * starts encountering unqueued dirty pages or cycling through
>  	 * the LRU too quickly.
>  	 */
> -	if (!sc->hibernation_mode && !current_is_kswapd() &&
> -	    current_may_throttle() && pgdat_memcg_congested(pgdat, root))
> +	if (!current_is_kswapd() && current_may_throttle() &&
> +	    !sc->hibernation_mode &&
> +	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
>  		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
> =20
>  	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
> @@ -3080,8 +3040,16 @@ static unsigned long do_try_to_free_pages(struct z=
onelist *zonelist,
>  		if (zone->zone_pgdat =3D=3D last_pgdat)
>  			continue;
>  		last_pgdat =3D zone->zone_pgdat;
> +
>  		snapshot_refaults(sc->target_mem_cgroup, zone->zone_pgdat);
> -		set_memcg_congestion(last_pgdat, sc->target_mem_cgroup, false);
> +
> +		if (cgroup_reclaim(sc)) {
> +			struct lruvec *lruvec;
> +
> +			lruvec =3D mem_cgroup_lruvec(sc->target_mem_cgroup,
> +						   zone->zone_pgdat);
> +			clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
> +		}
>  	}
> =20
>  	delayacct_freepages_end();
> @@ -3461,7 +3429,9 @@ static bool pgdat_balanced(pg_data_t *pgdat, int or=
der, int classzone_idx)
>  /* Clear pgdat state for congested, dirty or under writeback. */
>  static void clear_pgdat_congested(pg_data_t *pgdat)
>  {
> -	clear_bit(PGDAT_CONGESTED, &pgdat->flags);
> +	struct lruvec *lruvec =3D mem_cgroup_lruvec(NULL, pgdat);
> +
> +	clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
>  	clear_bit(PGDAT_DIRTY, &pgdat->flags);
>  	clear_bit(PGDAT_WRITEBACK, &pgdat->flags);
>  }
> --=20
> 2.23.0
>=20
>=20
