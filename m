Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DCAE0C92
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfJVT20 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 15:28:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13710 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbfJVT20 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 15:28:26 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MJRNXq029735;
        Tue, 22 Oct 2019 12:28:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FYdrSghnpTrVWnv8inCzCSDuoKr2VRRzrJKqEkqq9L4=;
 b=nT5rgyasfm/GRrHl9os5wzPS1D3galfrU7P6fYM6XOeYof4eNV8A+A82jJE0v6QZ38fO
 58KWPyR8vIH2O7MwFUnlE0ySurQwCpWPVWmnl1QS7buKXwWdE1lZ2b7QundiTA9CicEg
 MHdzLFCkfA5Qk5VLmIu4+af56DIn4E3CkoI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vsn68568f-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Oct 2019 12:28:17 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Oct 2019 12:28:16 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Oct 2019 12:28:16 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 12:28:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgzdZFZeEUqhWzpYLnWvoYBO9YFpeUGn5/TgjftZ9BPj+W0nlQIte7oZ6Ypn3bYfsA6hnfa37CKYptc++4z8hrGamlooS0/04wvWKd6BUv69c8SjHOPiH0GZfyE3x01xBOO74YNkErMrs5khYi9QvTBU4ebqpVAh12HkhDHlGA45yF2v1hqW2f+MY1qupQE4F3md1LA9zScfw86PmV/RioD8ySqm+co5av0+FY7kk89ywE7tYyefZDiayMIbahpQnO/ITnZl5v5sE5xIwOYIDqRtzPoY9p+CqD4USxPTDFzFtSSZWeR4Zd7ilL/Fmra/AdQZUzeLwP+WAwrOEt+3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYdrSghnpTrVWnv8inCzCSDuoKr2VRRzrJKqEkqq9L4=;
 b=K+COjLpB2ysSPCRodq/4p+Yzsg40tVLPT0DUWhFiq1dCJnJYxhM/vcuMD35Yzd4ZCMQdLrqx1IKXrhUR4dV5QZXY8u63mq0kf+9piSwC1EDA2A2pMQh+GUEuUsaAZA7V78QzsKH1mgnXk7AMQd+bsRVPhGO1Dt9LaMDUJmTCLktJYSFWoVRnvZuz0blhWZjo5bCm6QqIlLOjSSDBOygC6iIOfAJWUAu9sVLj9sNey/RlWaSwfJbzfltnWwIAYiqvwhskVuFJ+fOV9uoh7BrK5jlt5WKVqtLwh1SwQcJr5h2SOTJMhmVq0x0kgXMU2rl9pjCodvycq0z7rBUXtEi5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYdrSghnpTrVWnv8inCzCSDuoKr2VRRzrJKqEkqq9L4=;
 b=Una0L7fSOawJP7MPiIhtD0V3KjPNiSymwxqX8OaCmmCUp5gZgnA7eBglKpTNeNWz54fahZq3N+5S8D1EswibpcSP+Sgy4DnkqR1tUHGQHomGKWPuOCPmhthQDgE7Y1Fo+VDRtUP0RafgLZkJlz8Jap0ClOduIlXNyqn6mMnbf9k=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3329.namprd15.prod.outlook.com (20.179.75.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 19:28:14 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 19:28:14 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 3/8] mm: vmscan: move inactive_list_is_low() swap check to
 the caller
Thread-Topic: [PATCH 3/8] mm: vmscan: move inactive_list_is_low() swap check
 to the caller
Thread-Index: AQHViOfEBDjuAS+dyEG0t9yNg1bDT6dnC90A
Date:   Tue, 22 Oct 2019 19:28:14 +0000
Message-ID: <20191022192810.GC11461@tower.DHCP.thefacebook.com>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-4-hannes@cmpxchg.org>
In-Reply-To: <20191022144803.302233-4-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0058.namprd15.prod.outlook.com
 (2603:10b6:301:4c::20) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f871d308-b000-4dd6-7ff9-08d75725fb7c
x-ms-traffictypediagnostic: BN8PR15MB3329:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB33293D584A6D7ABC061CB691BE680@BN8PR15MB3329.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(305945005)(66946007)(86362001)(66556008)(66446008)(66476007)(64756008)(33656002)(316002)(54906003)(7736002)(102836004)(386003)(6506007)(6916009)(6246003)(71200400001)(99286004)(478600001)(9686003)(76176011)(6436002)(25786009)(486006)(446003)(11346002)(229853002)(6486002)(6512007)(256004)(8936002)(14454004)(476003)(14444005)(8676002)(71190400001)(81156014)(81166006)(4326008)(186003)(6116002)(1076003)(5660300002)(46003)(2906002)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3329;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VPRdJVIp96FQGdDh6z13pWjOJmhQ5n4HBHQTYjvZouBaYAaQZGRvcC6NfyJgDxadqvW3d7Amu8myzNP4z0bKrvSFCjYC7Xzefm4svNHXKWfzyresk+OWmJfrs9EajijbEKhFCqmY8XEDAM9Shv9VFV6w89EzZIM/dbcMlg3yOA4Kvvt+CE2dtC+Y9IqaHp9FjYtqN53g7HYpD4n0smH2yVx/Ri3f8Y3pa/ZnWWeXH2Y6ItazMcKVOTFCazhahoSG6CHKInbDTqvcJi2y6hhif8F8sRiVnz2kDSrxa1ojcefavb7bO/DCL6nlaPisRIqmT6T1CbZ3lAk0ZoJdTl2kijA2MVd9pmPXIyblEB3tsJbDwVR9baNtpY9Hzdx1yQ0Qg33WJsrcsHXRN9Ci2TofL1KCqjSi2poe2KZSCS3SVLgr6TLURUofsdsupLrnwjwb
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EC1CB5581D2114D956DF44FA235F099@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f871d308-b000-4dd6-7ff9-08d75725fb7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 19:28:14.3639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRuFScnxkaNvnc9kAyRvHmgLfRs5IWboAtqL5AA/iuAmOvvWaEXCfzrFHkLJLJM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3329
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_06:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220163
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 10:47:58AM -0400, Johannes Weiner wrote:
> inactive_list_is_low() should be about one thing: checking the ratio
> between inactive and active list. Kitchensink checks like the one for
> swap space makes the function hard to use and modify its
> callsites. Luckly, most callers already have an understanding of the
> swap situation, so it's easy to clean up.
>=20
> get_scan_count() has its own, memcg-aware swap check, and doesn't even
> get to the inactive_list_is_low() check on the anon list when there is
> no swap space available.
>=20
> shrink_list() is called on the results of get_scan_count(), so that
> check is redundant too.
>=20
> age_active_anon() has its own totalswap_pages check right before it
> checks the list proportions.
>=20
> The shrink_node_memcg() site is the only one that doesn't do its own
> swap check. Add it there.
>=20
> Then delete the swap check from inactive_list_is_low().
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index be3c22c274c1..622b77488144 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2226,13 +2226,6 @@ static bool inactive_list_is_low(struct lruvec *lr=
uvec, bool file,
>  	unsigned long refaults;
>  	unsigned long gb;
> =20
> -	/*
> -	 * If we don't have swap space, anonymous page deactivation
> -	 * is pointless.
> -	 */
> -	if (!file && !total_swap_pages)
> -		return false;
> -
>  	inactive =3D lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
>  	active =3D lruvec_lru_size(lruvec, active_lru, sc->reclaim_idx);
> =20
> @@ -2653,7 +2646,7 @@ static void shrink_node_memcg(struct pglist_data *p=
gdat, struct mem_cgroup *memc
>  	 * Even if we did not try to evict anon pages at all, we want to
>  	 * rebalance the anon lru active/inactive ratio.
>  	 */
> -	if (inactive_list_is_low(lruvec, false, sc, true))
> +	if (total_swap_pages && inactive_list_is_low(lruvec, false, sc, true))
>  		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
>  				   sc, LRU_ACTIVE_ANON);
>  }
> --=20
> 2.23.0
>=20
>=20

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
