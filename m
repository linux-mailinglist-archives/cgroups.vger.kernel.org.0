Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D69E0DA6
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfJVVGC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 17:06:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31534 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731942AbfJVVGC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 17:06:02 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MK3YIM025340;
        Tue, 22 Oct 2019 13:05:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=KM3denrXSVWQiRwu0fwZ7TxzuDWvG0h3C/tN3Th1IHI=;
 b=DHnWCvVQUtxjMdm4plilCrX9pJKqnYfwoED645hD/toBj7cCNx9cAAo+EwL42J3GDnpA
 ffKQobpRMemtao6mNKO+BdkNnMxzB3BsZrhFZpV02h38VdQq41GgVRKqWuxMk7AnHEwJ
 PqGy2wiD9QpTHvP61PSxlzARM5PxrATDnv8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vt4yss5fv-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Oct 2019 13:05:48 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Oct 2019 13:04:53 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 13:04:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aj760n3u8QJJ/d2VjTjgULC5TqRRd8BpKanD65OBJ9MMaUPIcecGdehVFbMopO6J5/gyEoEUMkRKv+UYWeb9TzdklVKQ7S6vFIqQUtwEBIUHDzKVdNzpe2nrcffNsUPrr5m2/DHN33yQTZMc3nTbWaBr+vrbFWvYDPAynfMUDoa2L7DnoS1/446mQveCkTehsERhKACqXnK+Qj7NVdjjnSaYThULRdA0kPEYX4MDIIy1WClhUy0Ci8cQZeJQhmNEAvnKZF0xfmZJKpKfn6maNgqdccZkbi90zw32Q1g0jrMSHD8AepEa13CeoUBEpZMzCKkHfpZ5jO3ex/weTHJD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM3denrXSVWQiRwu0fwZ7TxzuDWvG0h3C/tN3Th1IHI=;
 b=fsXZugiu1ESfTI/Bd0AZbcw+z2wk8MWg/uul/QN0AV34QHPAoJQgffR2A9oQrCy5ghz0fYzRz8raej4S9QATGfZ+yK2WviRVcYuNN1K6jJbvB8O3y1KNnLrVY0VKNArHXOSVu0BbrRMRcXzdcSamyjZk5+DTywBXXqENH7EAeD/zJdL3CD6lZdmv24hvhKVli4Xm2rdf5EQpVGOIftXAJDG253UVTxWKTKyqYsHVaLslMl8Vh9ze3ZNq3yeP/ZwfG5pYnPAEghbEPn0UV02E5EmBzGz3dFDFlvSEGzuhpfeZ1bICrI9sBr2IU/FqhFJ63/r2mSJZXXnFGk3/bLZfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM3denrXSVWQiRwu0fwZ7TxzuDWvG0h3C/tN3Th1IHI=;
 b=U7aF6H98PIL72n/tPxbX2iF5O9zaGWUiHM2CaGN1pmVlTJ4N6TZfo16IM43VC5g6Gxq6DCi+cX+qhL9iJIyi5YEK9ZlaMxdNUhrqHKLOeHLWWtY96wa0EgV9HOSfxlDKpiZXMz0DdnUSY8jJb09b7f+MEEvnCRk+GcRaXIyU3Gk=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2898.namprd15.prod.outlook.com (20.178.219.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 20:04:48 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 20:04:48 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 6/8] mm: vmscan: turn shrink_node_memcg() into
 shrink_lruvec()
Thread-Topic: [PATCH 6/8] mm: vmscan: turn shrink_node_memcg() into
 shrink_lruvec()
Thread-Index: AQHViOfFiRbRcAynw0WgbDAtD7WDKadnFhUA
Date:   Tue, 22 Oct 2019 20:04:48 +0000
Message-ID: <20191022200444.GB22721@tower.DHCP.thefacebook.com>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-7-hannes@cmpxchg.org>
In-Reply-To: <20191022144803.302233-7-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0131.namprd04.prod.outlook.com
 (2603:10b6:104:7::33) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b0732f6-6f9c-4359-1dbf-08d7572b176c
x-ms-traffictypediagnostic: BN8PR15MB2898:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB28988250EE263E17A38D665BBE680@BN8PR15MB2898.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(5660300002)(186003)(476003)(81166006)(6486002)(229853002)(81156014)(8676002)(9686003)(1076003)(256004)(14444005)(6246003)(11346002)(4326008)(6512007)(478600001)(71190400001)(25786009)(8936002)(14454004)(446003)(6436002)(71200400001)(54906003)(305945005)(66446008)(64756008)(66556008)(6506007)(6116002)(386003)(7736002)(66946007)(46003)(76176011)(99286004)(86362001)(6916009)(102836004)(486006)(2906002)(316002)(52116002)(66476007)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2898;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +00TMqaVMKOY4pIIeMKdm77wYObOVBfi0EYCLD2oQ1rZ6rICEbeZJfAj6CvKxNR4D9bzobajbjegdDq2sQiFZHjJ+X2wMl0mdKSz5GnTfcFDOWdYwrN7+/otKh5qGZLM1Y2p+lrbCufJ3z9mcFuVlSrDmloNb2VGCe6mDt4Mx+9P9kXAUqmJEbdqzq0GydJSl2kk592S59CyJIaG5OrmPnvyPrSnOoDV1lIYxF+4KbBdxar9Fd4Kqeh8bP0B4VavKptKtlnYQkjnEw9T6gmRVEFSw4lXHGXpLyLM+6OgJ/JEHPCc+P5X45haCiLGPfbeJHtyjRhj0hGNtJMZkRauxo83blJJyZxYEISEZ2bRd8OMt4Q6xuPL+/0SnjvF/IIfx3azyAnHKl9drL8h6uOaMEVN+zT5ve4Lr/K9ZvPvIRuGYK3B70Xo8ajzxjAi+Z4S
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F3DF65956583C4CBAC4BBF46643B806@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0732f6-6f9c-4359-1dbf-08d7572b176c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:04:48.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARuHeGfWCge9e9mYwMD3bnw16Ce03eD47droOGtLsUFPGpshu5UGPVhlvNg8lMD/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2898
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_06:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220169
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 10:48:01AM -0400, Johannes Weiner wrote:
> A lruvec holds LRU pages owned by a certain NUMA node and cgroup.
> Instead of awkwardly passing around a combination of a pgdat and a
> memcg pointer, pass down the lruvec as soon as we can look it up.
>=20
> Nested callers that need to access node or cgroup properties can look
> them them up if necessary, but there are only a few cases.
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 235d1fc72311..db073b40c432 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2280,9 +2280,10 @@ enum scan_balance {
>   * nr[0] =3D anon inactive pages to scan; nr[1] =3D anon active pages to=
 scan
>   * nr[2] =3D file inactive pages to scan; nr[3] =3D file active pages to=
 scan
>   */
> -static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *mem=
cg,
> -			   struct scan_control *sc, unsigned long *nr)
> +static void get_scan_count(struct lruvec *lruvec, struct scan_control *s=
c,
> +			   unsigned long *nr)
>  {
> +	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>  	int swappiness =3D mem_cgroup_swappiness(memcg);
>  	struct zone_reclaim_stat *reclaim_stat =3D &lruvec->reclaim_stat;
>  	u64 fraction[2];
> @@ -2530,13 +2531,8 @@ static void get_scan_count(struct lruvec *lruvec, =
struct mem_cgroup *memcg,
>  	}
>  }
> =20
> -/*
> - * This is a basic per-node page freer.  Used by both kswapd and direct =
reclaim.
> - */
> -static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgro=
up *memcg,
> -			      struct scan_control *sc)
> +static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc=
)
>  {
> -	struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>  	unsigned long nr[NR_LRU_LISTS];
>  	unsigned long targets[NR_LRU_LISTS];
>  	unsigned long nr_to_scan;
> @@ -2546,7 +2542,7 @@ static void shrink_node_memcg(struct pglist_data *p=
gdat, struct mem_cgroup *memc
>  	struct blk_plug plug;
>  	bool scan_adjusted;
> =20
> -	get_scan_count(lruvec, memcg, sc, nr);
> +	get_scan_count(lruvec, sc, nr);
> =20
>  	/* Record the original scan target for proportional adjustments later *=
/
>  	memcpy(targets, nr, sizeof(nr));
> @@ -2741,6 +2737,7 @@ static bool shrink_node(pg_data_t *pgdat, struct sc=
an_control *sc)
> =20
>  	memcg =3D mem_cgroup_iter(root, NULL, NULL);
>  	do {
> +		struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>  		unsigned long reclaimed;
>  		unsigned long scanned;
> =20
> @@ -2777,7 +2774,8 @@ static bool shrink_node(pg_data_t *pgdat, struct sc=
an_control *sc)
> =20
>  		reclaimed =3D sc->nr_reclaimed;
>  		scanned =3D sc->nr_scanned;
> -		shrink_node_memcg(pgdat, memcg, sc);
> +
> +		shrink_lruvec(lruvec, sc);
> =20
>  		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
>  			    sc->priority);
> @@ -3281,6 +3279,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgr=
oup *memcg,
>  						pg_data_t *pgdat,
>  						unsigned long *nr_scanned)
>  {
> +	struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>  	struct scan_control sc =3D {
>  		.nr_to_reclaim =3D SWAP_CLUSTER_MAX,
>  		.target_mem_cgroup =3D memcg,
> @@ -3307,7 +3306,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgr=
oup *memcg,
>  	 * will pick up pages from other mem cgroup's as well. We hack
>  	 * the priority and make it zero.
>  	 */
> -	shrink_node_memcg(pgdat, memcg, &sc);
> +	shrink_lruvec(lruvec, &sc);
> =20
>  	trace_mm_vmscan_memcg_softlimit_reclaim_end(
>  					cgroup_ino(memcg->css.cgroup),
> --=20
> 2.23.0
>=20

Reviewed-by: Roman Gushchin <guro@fb.com>
