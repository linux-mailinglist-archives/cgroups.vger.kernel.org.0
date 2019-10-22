Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF8E0D12
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 22:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbfJVUIj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 16:08:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56784 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387609AbfJVUIj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 16:08:39 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MK8Hds023421;
        Tue, 22 Oct 2019 13:08:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kSxBKKs/CV01OvG76EJpyOie2QydFm1ggqmmSisDNmE=;
 b=i2nm7uUuJNSa9jAWC6h8Wqlep677YI2WZ/GblPvUPBYNuupvIhtJrptFE0tTL+KmU4YC
 woW5ru/6S84q+iXUwTczu1jpnm1K6Gn13cCUOf2kJacT/pvcl2EoXVqa7EmdYZW/jO1W
 vI3kJBXWHdJI8+Gs+QuEB1FGCXT/0VkYnlU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vrj6sv1ru-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Oct 2019 13:08:29 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Oct 2019 13:08:27 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 13:08:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQtJa7hmfHdIgeRXaWnOqD2MOGqLJDLSK5OHSC9HfbpuSQnPbxsgvJal4raohsThSsdWwjlFwaGbmB1meSfngH93hrSEBCUM5NxHueMfo0mEN7NRD8gf1CGYTyJrau8tk7uIvmSyNuKtH0p9VVw75NWNWNJL+/mUcjgYO8o3yKPjdjq4kpD47Qx0czhCjECqE8cc1pRvL+gQsUo16oJ9qUG1o+f9iHxv11W9Wt1zpXcBZWMUdnzqpBsZ8/S7CvFH+TPBBx/78mb35sib6s/TVoHfE4fgCNsSd4Kp5NTna2pebr2ax+jTe76CYOPNLhloDRXcsP+o5DTAlD6n5Qt2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSxBKKs/CV01OvG76EJpyOie2QydFm1ggqmmSisDNmE=;
 b=AXP+NK6q3CD9xz6VjYVgUYQDm5pmgfGJ2YpP2arTwg4+cp370Nn9FT80hn2jWBq8UyGASNGddCpurKtZ2sUGvTDWiYe/Nm4fDh10yYPw4eIVq7HpqBid1C7G2lrRBgrDpVOpVnlH6+FJ5JSyg8z2P1ltVJY2Qz/nB2QPZ+kYEM4rYaUYmKDRZIuZlIt4X46HTofidrbladM/u3nmskaeOYgxoBBx4fnrX5X3PGUjSWHx0GD513Zc3UnX+FQc6UgJT6tiPLz7GwaId6lE1GTZZryT/6O08Yd6/Cmdfppt06DmthQ4mzVmKjFE4wQtOQXmlyrlZ6ba2ATuC3r4atmbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSxBKKs/CV01OvG76EJpyOie2QydFm1ggqmmSisDNmE=;
 b=dVjJVN7U0vFlO5PfQTcR/aXQvtWG5MeK1sIvtcPZPLaYdeFpbjSsO+SBr5G83z4B0sIFf1WvTxNquWDFIq99UGi3rtmmlcIwb4c26vP8tPfI5S9RtR1FSYThj0S8INP4YGRITL0kjjzu2mdg98CKASsrlgKKROKAUKss13cwt0Y=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2898.namprd15.prod.outlook.com (20.178.219.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 20:08:23 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 20:08:23 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 7/8] mm: vmscan: split shrink_node() into node part and
 memcgs part
Thread-Topic: [PATCH 7/8] mm: vmscan: split shrink_node() into node part and
 memcgs part
Thread-Index: AQHViOfH2m2ZEFsCqUCyP/k19Cd9B6dnFxWA
Date:   Tue, 22 Oct 2019 20:08:23 +0000
Message-ID: <20191022200819.GC22721@tower.DHCP.thefacebook.com>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-8-hannes@cmpxchg.org>
In-Reply-To: <20191022144803.302233-8-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0149.namprd04.prod.outlook.com (2603:10b6:104::27)
 To BN8PR15MB2626.namprd15.prod.outlook.com (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1907ecf-4874-42fc-c3db-08d7572b9798
x-ms-traffictypediagnostic: BN8PR15MB2898:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB28983B799124C0A3E07B7D80BE680@BN8PR15MB2898.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(5660300002)(186003)(476003)(81166006)(6486002)(229853002)(81156014)(8676002)(9686003)(1076003)(256004)(6246003)(11346002)(4326008)(6512007)(478600001)(71190400001)(25786009)(8936002)(14454004)(446003)(6436002)(71200400001)(54906003)(305945005)(66446008)(64756008)(66556008)(6506007)(6116002)(386003)(7736002)(66946007)(46003)(76176011)(99286004)(86362001)(6916009)(102836004)(486006)(2906002)(316002)(52116002)(66476007)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2898;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H6WzfsBJwP3cknd9zhdjFF8T0rejgcf18ing/hOU6oEAEHDcizOwz7TfshuJy0AN2pqeFn+/JOM/AFkqfG21l0o3sjDTGe6FYNGVJLf+xfzoyGAYCkMiJgjyh5doYSmc1e86XiPK2HH+EqkqcPdpuAd2HqMXuHISwf2blqQ6gFBGew0spBp67yyM4NBAv1iG3TjYfg3JFHr0Gxcr/G7DfV8KdWDb5H9Snl4b4klNnLUWGeIEeZVT6pIDfyxqqB3NzIMV4IssQeUIjsg1KHWigX2OQN48BGTMlsaqFGsD+noPvd6sfAcQgSgYwQk6RIwF/zyQIZtYPZcrsdFvuWbjEg6XFSysx0aVP/WG52imP5KAHGZq/gFiugm8p4zl8xOesVer9+ocqB6voOmnXYTCPIFgeyDCZ+xVOvVFhO/gUzz674NmA0UJLslAreRGSYNx
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A5FC583F63CE3C4DB54A3E316B1BE943@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1907ecf-4874-42fc-c3db-08d7572b9798
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:08:23.6475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEjlfZKobG2qLWrTK7vKBgrA3iWSrjbvmudPchIAl2uhNYv35tL6Sje7Fa+QDE67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2898
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_06:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220170
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 10:48:02AM -0400, Johannes Weiner wrote:
> This function is getting long and unwieldy, split out the memcg bits.
>=20
> The updated shrink_node() handles the generic (node) reclaim aspects:
>   - global vmpressure notifications
>   - writeback and congestion throttling
>   - reclaim/compaction management
>   - kswapd giving up on unreclaimable nodes
>=20
> It then calls a new shrink_node_memcgs() which handles cgroup specifics:
>   - the cgroup tree traversal
>   - memory.low considerations
>   - per-cgroup slab shrinking callbacks
>   - per-cgroup vmpressure notifications
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index db073b40c432..65baa89740dd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2722,18 +2722,10 @@ static bool pgdat_memcg_congested(pg_data_t *pgda=
t, struct mem_cgroup *memcg)
>  		(memcg && memcg_congested(pgdat, memcg));
>  }
> =20
> -static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> +static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc=
)
>  {
> -	struct reclaim_state *reclaim_state =3D current->reclaim_state;
>  	struct mem_cgroup *root =3D sc->target_mem_cgroup;
> -	unsigned long nr_reclaimed, nr_scanned;
> -	bool reclaimable =3D false;
>  	struct mem_cgroup *memcg;
> -again:
> -	memset(&sc->nr, 0, sizeof(sc->nr));
> -
> -	nr_reclaimed =3D sc->nr_reclaimed;
> -	nr_scanned =3D sc->nr_scanned;
> =20
>  	memcg =3D mem_cgroup_iter(root, NULL, NULL);
>  	do {
> @@ -2786,6 +2778,22 @@ static bool shrink_node(pg_data_t *pgdat, struct s=
can_control *sc)
>  			   sc->nr_reclaimed - reclaimed);
> =20
>  	} while ((memcg =3D mem_cgroup_iter(root, memcg, NULL)));
> +}
> +
> +static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> +{
> +	struct reclaim_state *reclaim_state =3D current->reclaim_state;
> +	struct mem_cgroup *root =3D sc->target_mem_cgroup;
> +	unsigned long nr_reclaimed, nr_scanned;
> +	bool reclaimable =3D false;
> +
> +again:
> +	memset(&sc->nr, 0, sizeof(sc->nr));
> +
> +	nr_reclaimed =3D sc->nr_reclaimed;
> +	nr_scanned =3D sc->nr_scanned;
> +
> +	shrink_node_memcgs(pgdat, sc);
> =20
>  	if (reclaim_state) {
>  		sc->nr_reclaimed +=3D reclaim_state->reclaimed_slab;
> @@ -2793,7 +2801,7 @@ static bool shrink_node(pg_data_t *pgdat, struct sc=
an_control *sc)
>  	}
> =20
>  	/* Record the subtree's reclaim efficiency */
> -	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> +	vmpressure(sc->gfp_mask, root, true,

Maybe target? Or target_memcg? The word root is associated with the root cg=
roup.

Other than root the patch looks good to me:

Reviewed-by: Roman Gushchin <guro@fb.com>
