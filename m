Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B935E0C87
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 21:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfJVTZa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 15:25:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727851AbfJVTZ3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 15:25:29 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9MJOoWN009374;
        Tue, 22 Oct 2019 12:25:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BRy3o62wqHZSqQp32Kw0Anapa9F+w5jaGZ+dOALG9ZA=;
 b=gqWZMbCN+6m7Dxlb7R5JOKnCDLyzbYfTjtqdztM4OBlbbLKzAMB+1M7nfmDgCteELJtR
 igAo13TM0vQ7T04om+xsTFS/4nmQOrTzvgEV2uFq1r/EfjcqWE9B//yAoaTZBUP9qhjK
 diWuQ9vQUIDmRjMCK0nIUIsrk20ADPt4uwg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2vsvnbbdy0-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 12:25:22 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 22 Oct 2019 12:25:08 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 12:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtVrb7Q9qSjuNm5TQvQwULdapapICmTaFZ+s8/GkFbD6w8suTT7bONVKL2xyCFMytQvUC6BK/PfryZOwklSqAm/SQaKWeCDDlp6VEEa5aGIcOQ+pGuqWm3VRncjE8p3aVfZCGhUzP7rm6gn0I8bF3m3/XA4FVMcGfqmXWVSIoqVPwCd8lpjD0lWuDuS2vAKVzO6eFMZbpZjWdlFZdAXa03EgsOq5ZWj7SysELN7QFmVgapw6rFoZ3LaFoZPbzRSQtlxR3QTJSdlhfd5Lve7QTRYum7e7u6C7AWMeZR/4Y5h/Uam9pLCUx/Dt4vEWvRnL7HGDLecbG5Q/SH95ZddFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRy3o62wqHZSqQp32Kw0Anapa9F+w5jaGZ+dOALG9ZA=;
 b=bgWAJhlBICSz0UDCLHEOihety/YNVVoBZ0pZStteAENxiQ9JOlgmv5am71Um1YoMVs3yzXdWptpq5UbzxyAsbuBP8Gm06rOlJda+Ntxjdnm67oQWpehHidR1zv6Q6TfoJy9xUQDlH+d7xZXbC+D14JVNEEbhiaxZf9V49pEIodSu3b8EfKPrHNs6JKI80qL7I6kLeqleJB9tO4v4FYCjMwECJZM04sfvnuJnlim9u8Ax6wcSlYKuaZXp5KrzXJoGwUjZKzvwRIMV+txNt3TYlIs+hefRXY8eG5pUw7kh82UwCmC2PFJcibWKyJdk/6Q13uZkyQcYXKJVOk/M2MuwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRy3o62wqHZSqQp32Kw0Anapa9F+w5jaGZ+dOALG9ZA=;
 b=Wim994QIjVcTHYNBAjAfvkHQmapjgeHlmt7HFdne8oEjU59VGE1hnNRB6K70wBfFdwvYxpWqdtMoiIrr9Ry/HhbwLTUFmRRTN2mEGaIBA6dgZlha+ipEFBr0+f8PzYhpbdOTDjinKhiRvArejKZQhD6XMRZuB2hfG/sd+tCw2ic=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2850.namprd15.prod.outlook.com (20.178.219.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 19:25:01 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 19:25:01 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/8] mm: clean up and clarify lruvec lookup procedure
Thread-Topic: [PATCH 2/8] mm: clean up and clarify lruvec lookup procedure
Thread-Index: AQHViOfBGnGtPiJYAkOe4SVj2dUpyKdnCvYA
Date:   Tue, 22 Oct 2019 19:25:01 +0000
Message-ID: <20191022192456.GB11461@tower.DHCP.thefacebook.com>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-3-hannes@cmpxchg.org>
In-Reply-To: <20191022144803.302233-3-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0031.namprd15.prod.outlook.com
 (2603:10b6:300:ad::17) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f4a1208-4bcc-4bb0-2778-08d75725886d
x-ms-traffictypediagnostic: BN8PR15MB2850:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB2850079948247AB3A8C4A22FBE680@BN8PR15MB2850.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(8936002)(7736002)(8676002)(66946007)(66476007)(4326008)(6436002)(6486002)(229853002)(9686003)(6246003)(81166006)(81156014)(6512007)(66556008)(64756008)(66446008)(305945005)(99286004)(52116002)(86362001)(76176011)(478600001)(386003)(6506007)(25786009)(256004)(102836004)(71190400001)(486006)(71200400001)(54906003)(316002)(6116002)(46003)(476003)(446003)(14454004)(14444005)(11346002)(186003)(5660300002)(30864003)(1076003)(2906002)(33656002)(6916009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2850;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dqFJraUX6Byw5uUQ+9JbydaplspYeTdRMOH+guul4M+28OOuc9KW7dHNvp30H42XOskxjAKxNov9C29Ue/6oT9IZaPFs0qu7IaWqIprtUczIsecVrzMVJfHgLaHDLg6UYOKcq6U23ggshb6mgl5s9yoXMMpLhceqWIWXQF+qKIIKkfVdIlvb7arwYfS9NKUWjdMl3VrLUYjhH+UiAsyjplyCwJs0sRLvsmLzubO6QHhAD+lRbOMXmavSd4qxRgwEoxgbmDAgBkD45Hl4CNv1u3g5Y/fLtPDihBnC71Gx0ePPrtyT5eT7+a+ebZrfZ1cKC+zgcJR5dqkWHcVZ6q/CqLfpKTq4xbzZ7oH0Y2fdOcr05wEcUy81CyohJ430Njn+MD9iPjSo/65ZMmSfg0R/QoEpjsTkkjelHXzJrBFz4fYpNUzwHebdFriv+0xcUWwe
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6EF78597FFC0634F8BB209AE89CC41CB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4a1208-4bcc-4bb0-2778-08d75725886d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 19:25:01.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFTvzOIZifTrXI1p3vpljaAaX2DRsAV3rAbUHQ0KlE0KhxMu4ZF/yC+mXczngwUU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2850
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_06:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220162
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 10:47:57AM -0400, Johannes Weiner wrote:
> There is a per-memcg lruvec and a NUMA node lruvec. Which one is being
> used is somewhat confusing right now, and it's easy to make mistakes -
> especially when it comes to global reclaim.
>=20
> How it works: when memory cgroups are enabled, we always use the
> root_mem_cgroup's per-node lruvecs. When memory cgroups are not
> compiled in or disabled at runtime, we use pgdat->lruvec.
>=20
> Document that in a comment.
>=20
> Due to the way the reclaim code is generalized, all lookups use the
> mem_cgroup_lruvec() helper function, and nobody should have to find
> the right lruvec manually right now. But to avoid future mistakes,
> rename the pgdat->lruvec member to pgdat->__lruvec and delete the
> convenience wrapper that suggests it's a commonly accessed member.

This part looks great!

>=20
> While in this area, swap the mem_cgroup_lruvec() argument order. The
> name suggests a memcg operation, yet it takes a pgdat first and a
> memcg second. I have to double take every time I call this. Fix that.

Idk, I agree that the new order makes more sense (slightly), but
such changes make any backports / git blame searches more complex.
So, I'm not entirely convinced that it worth it. The compiler will
prevent passing bad arguments by mistake.

Thanks!

>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/memcontrol.h | 26 +++++++++++++-------------
>  include/linux/mmzone.h     | 15 ++++++++-------
>  mm/memcontrol.c            | 12 ++++++------
>  mm/page_alloc.c            |  2 +-
>  mm/slab.h                  |  4 ++--
>  mm/vmscan.c                |  6 +++---
>  mm/workingset.c            |  8 ++++----
>  7 files changed, 37 insertions(+), 36 deletions(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 2b34925fc19d..498cea07cbb1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -393,22 +393,22 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int n=
id)
>  }
> =20
>  /**
> - * mem_cgroup_lruvec - get the lru list vector for a node or a memcg zon=
e
> - * @node: node of the wanted lruvec
> + * mem_cgroup_lruvec - get the lru list vector for a memcg & node
>   * @memcg: memcg of the wanted lruvec
> + * @node: node of the wanted lruvec
>   *
> - * Returns the lru list vector holding pages for a given @node or a give=
n
> - * @memcg and @zone. This can be the node lruvec, if the memory controll=
er
> - * is disabled.
> + * Returns the lru list vector holding pages for a given @memcg &
> + * @node combination. This can be the node lruvec, if the memory
> + * controller is disabled.
>   */
> -static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat=
,
> -				struct mem_cgroup *memcg)
> +static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> +					       struct pglist_data *pgdat)
>  {
>  	struct mem_cgroup_per_node *mz;
>  	struct lruvec *lruvec;
> =20
>  	if (mem_cgroup_disabled()) {
> -		lruvec =3D node_lruvec(pgdat);
> +		lruvec =3D &pgdat->__lruvec;
>  		goto out;
>  	}
> =20
> @@ -727,7 +727,7 @@ static inline void __mod_lruvec_page_state(struct pag=
e *page,
>  		return;
>  	}
> =20
> -	lruvec =3D mem_cgroup_lruvec(pgdat, page->mem_cgroup);
> +	lruvec =3D mem_cgroup_lruvec(page->mem_cgroup, pgdat);
>  	__mod_lruvec_state(lruvec, idx, val);
>  }
> =20
> @@ -898,16 +898,16 @@ static inline void mem_cgroup_migrate(struct page *=
old, struct page *new)
>  {
>  }
> =20
> -static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat=
,
> -				struct mem_cgroup *memcg)
> +static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> +					       struct pglist_data *pgdat)
>  {
> -	return node_lruvec(pgdat);
> +	return &pgdat->__lruvec;
>  }
> =20
>  static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
>  						    struct pglist_data *pgdat)
>  {
> -	return &pgdat->lruvec;
> +	return &pgdat->__lruvec;
>  }
> =20
>  static inline bool mm_match_cgroup(struct mm_struct *mm,
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index d4ca03b93373..449a44171026 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -777,7 +777,13 @@ typedef struct pglist_data {
>  #endif
> =20
>  	/* Fields commonly accessed by the page reclaim scanner */
> -	struct lruvec		lruvec;
> +
> +	/*
> +	 * NOTE: THIS IS UNUSED IF MEMCG IS ENABLED.
> +	 *
> +	 * Use mem_cgroup_lruvec() to look up lruvecs.
> +	 */
> +	struct lruvec		__lruvec;
> =20
>  	unsigned long		flags;
> =20
> @@ -800,11 +806,6 @@ typedef struct pglist_data {
>  #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
>  #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
> =20
> -static inline struct lruvec *node_lruvec(struct pglist_data *pgdat)
> -{
> -	return &pgdat->lruvec;
> -}
> -
>  static inline unsigned long pgdat_end_pfn(pg_data_t *pgdat)
>  {
>  	return pgdat->node_start_pfn + pgdat->node_spanned_pages;
> @@ -842,7 +843,7 @@ static inline struct pglist_data *lruvec_pgdat(struct=
 lruvec *lruvec)
>  #ifdef CONFIG_MEMCG
>  	return lruvec->pgdat;
>  #else
> -	return container_of(lruvec, struct pglist_data, lruvec);
> +	return container_of(lruvec, struct pglist_data, __lruvec);
>  #endif
>  }
> =20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 98c2fd902533..055975b0b3a3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -770,7 +770,7 @@ void __mod_lruvec_slab_state(void *p, enum node_stat_=
item idx, int val)
>  	if (!memcg || memcg =3D=3D root_mem_cgroup) {
>  		__mod_node_page_state(pgdat, idx, val);
>  	} else {
> -		lruvec =3D mem_cgroup_lruvec(pgdat, memcg);
> +		lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>  		__mod_lruvec_state(lruvec, idx, val);
>  	}
>  	rcu_read_unlock();
> @@ -1226,7 +1226,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *=
page, struct pglist_data *pgd
>  	struct lruvec *lruvec;
> =20
>  	if (mem_cgroup_disabled()) {
> -		lruvec =3D &pgdat->lruvec;
> +		lruvec =3D &pgdat->__lruvec;
>  		goto out;
>  	}
> =20
> @@ -1605,7 +1605,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgr=
oup *memcg, gfp_t gfp_mask,
>  static bool test_mem_cgroup_node_reclaimable(struct mem_cgroup *memcg,
>  		int nid, bool noswap)
>  {
> -	struct lruvec *lruvec =3D mem_cgroup_lruvec(NODE_DATA(nid), memcg);
> +	struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> =20
>  	if (lruvec_page_state(lruvec, NR_INACTIVE_FILE) ||
>  	    lruvec_page_state(lruvec, NR_ACTIVE_FILE))
> @@ -3735,7 +3735,7 @@ static int mem_cgroup_move_charge_write(struct cgro=
up_subsys_state *css,
>  static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *mem=
cg,
>  					   int nid, unsigned int lru_mask)
>  {
> -	struct lruvec *lruvec =3D mem_cgroup_lruvec(NODE_DATA(nid), memcg);
> +	struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_DATA(nid));
>  	unsigned long nr =3D 0;
>  	enum lru_list lru;
> =20
> @@ -5433,8 +5433,8 @@ static int mem_cgroup_move_account(struct page *pag=
e,
>  	anon =3D PageAnon(page);
> =20
>  	pgdat =3D page_pgdat(page);
> -	from_vec =3D mem_cgroup_lruvec(pgdat, from);
> -	to_vec =3D mem_cgroup_lruvec(pgdat, to);
> +	from_vec =3D mem_cgroup_lruvec(from, pgdat);
> +	to_vec =3D mem_cgroup_lruvec(to, pgdat);
> =20
>  	spin_lock_irqsave(&from->move_lock, flags);
> =20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fe76be55c9d5..791c018314b3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6708,7 +6708,7 @@ static void __meminit pgdat_init_internals(struct p=
glist_data *pgdat)
> =20
>  	pgdat_page_ext_init(pgdat);
>  	spin_lock_init(&pgdat->lru_lock);
> -	lruvec_init(node_lruvec(pgdat));
> +	lruvec_init(&pgdat->__lruvec);
>  }
> =20
>  static void __meminit zone_init_internals(struct zone *zone, enum zone_t=
ype idx, int nid,
> diff --git a/mm/slab.h b/mm/slab.h
> index 3eb29ae75743..2bbecf28688d 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -369,7 +369,7 @@ static __always_inline int memcg_charge_slab(struct p=
age *page,
>  	if (ret)
>  		goto out;
> =20
> -	lruvec =3D mem_cgroup_lruvec(page_pgdat(page), memcg);
> +	lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
>  	mod_lruvec_state(lruvec, cache_vmstat_idx(s), 1 << order);
> =20
>  	/* transer try_charge() page references to kmem_cache */
> @@ -393,7 +393,7 @@ static __always_inline void memcg_uncharge_slab(struc=
t page *page, int order,
>  	rcu_read_lock();
>  	memcg =3D READ_ONCE(s->memcg_params.memcg);
>  	if (likely(!mem_cgroup_is_root(memcg))) {
> -		lruvec =3D mem_cgroup_lruvec(page_pgdat(page), memcg);
> +		lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
>  		mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
>  		memcg_kmem_uncharge_memcg(page, order, memcg);
>  	} else {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 57f533b808f2..be3c22c274c1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2545,7 +2545,7 @@ static void get_scan_count(struct lruvec *lruvec, s=
truct mem_cgroup *memcg,
>  static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgro=
up *memcg,
>  			      struct scan_control *sc)
>  {
> -	struct lruvec *lruvec =3D mem_cgroup_lruvec(pgdat, memcg);
> +	struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>  	unsigned long nr[NR_LRU_LISTS];
>  	unsigned long targets[NR_LRU_LISTS];
>  	unsigned long nr_to_scan;
> @@ -3023,7 +3023,7 @@ static void snapshot_refaults(struct mem_cgroup *ro=
ot_memcg, pg_data_t *pgdat)
>  		unsigned long refaults;
>  		struct lruvec *lruvec;
> =20
> -		lruvec =3D mem_cgroup_lruvec(pgdat, memcg);
> +		lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>  		refaults =3D lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
>  		lruvec->refaults =3D refaults;
>  	} while ((memcg =3D mem_cgroup_iter(root_memcg, memcg, NULL)));
> @@ -3391,7 +3391,7 @@ static void age_active_anon(struct pglist_data *pgd=
at,
> =20
>  	memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
>  	do {
> -		struct lruvec *lruvec =3D mem_cgroup_lruvec(pgdat, memcg);
> +		struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> =20
>  		if (inactive_list_is_low(lruvec, false, sc, true))
>  			shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
> diff --git a/mm/workingset.c b/mm/workingset.c
> index c963831d354f..e8212123c1c3 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -233,7 +233,7 @@ void *workingset_eviction(struct page *page)
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> =20
> -	lruvec =3D mem_cgroup_lruvec(pgdat, memcg);
> +	lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>  	eviction =3D atomic_long_inc_return(&lruvec->inactive_age);
>  	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
>  }
> @@ -280,7 +280,7 @@ void workingset_refault(struct page *page, void *shad=
ow)
>  	memcg =3D mem_cgroup_from_id(memcgid);
>  	if (!mem_cgroup_disabled() && !memcg)
>  		goto out;
> -	lruvec =3D mem_cgroup_lruvec(pgdat, memcg);
> +	lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>  	refault =3D atomic_long_read(&lruvec->inactive_age);
>  	active_file =3D lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES);
> =20
> @@ -345,7 +345,7 @@ void workingset_activation(struct page *page)
>  	memcg =3D page_memcg_rcu(page);
>  	if (!mem_cgroup_disabled() && !memcg)
>  		goto out;
> -	lruvec =3D mem_cgroup_lruvec(page_pgdat(page), memcg);
> +	lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
>  	atomic_long_inc(&lruvec->inactive_age);
>  out:
>  	rcu_read_unlock();
> @@ -426,7 +426,7 @@ static unsigned long count_shadow_nodes(struct shrink=
er *shrinker,
>  		struct lruvec *lruvec;
>  		int i;
> =20
> -		lruvec =3D mem_cgroup_lruvec(NODE_DATA(sc->nid), sc->memcg);
> +		lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
>  		for (pages =3D 0, i =3D 0; i < NR_LRU_LISTS; i++)
>  			pages +=3D lruvec_page_state_local(lruvec,
>  							 NR_LRU_BASE + i);
> --=20
> 2.23.0
>=20
>=20
