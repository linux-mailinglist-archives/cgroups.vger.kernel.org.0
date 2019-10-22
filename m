Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25254E0C70
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 21:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfJVTTC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 15:19:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36894 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730186AbfJVTTC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 15:19:02 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MJE8DY017770;
        Tue, 22 Oct 2019 12:18:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=M/V6yi+wMDg4kFrNEEAneW64BO+255sD/jPJaAf4IFc=;
 b=AMnaIQahpsF7Dx9bxfN3+ylwIpb89rU9N/9J2CDUINXAj4wrZXkoJUdIoX8veoPNQSjK
 oeqclieSAzkJKX5N7RRQnXUJ8ejlxDeRnv3/fVZEtakDdpfaD1SUJ8c7KHA7+DxvzHz2
 IZ3BONvNNX9hXi6gWwKWhvIwMVL1vUd5vSk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vsp6bvxrf-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 12:18:52 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 22 Oct 2019 12:18:13 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 12:18:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wo1Un6NedFuYqDQZ+cclf2rp0GehJf1PPAoJjKwTYepAWg3HvnwGjDxRjp1CRsGssHdvt02VvpFvo2VWEnbAP/g4WCy7lFv+mlK2fRFcrckv87fTNtyQy6sSKCBk0O2jUDxid4rr66NJV0umhoI9QFnxfm5Yf9vQGJ2KPM0RJSFvzlvUbJdDuBZb94ZGu8KROuvAbW5Nrs9pqlcDl4Di2hPz0fWqcQx1pxWg1hjoYOWnO1ZGoP9LIhhH40h2bqyBiTte1LKCfEixpb+8nf62fGPW1nXUaqH0UD4Hj4VuiR7bh9AGduNJwFO4v2E25D82g+E+gl60VWRDi6Or94GOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/V6yi+wMDg4kFrNEEAneW64BO+255sD/jPJaAf4IFc=;
 b=bq3xA28Ssj2IdDeVShywak7sILDtRAgdLOUP9T11Gu314PCx5uQXICeb+Shn3Nnh4CUHbQJZ96MTRu9sCJ3cNO42Z+FpGRTRtqmB54Jjxfx86FW5rZVlhYgvw03DmPv56rxKyLTD8Q/lSu2y0AWlN7AYyyJNBEYoOIHFSN5vbeZNeZpf+E5QcUlZqhJe28WUZ1u9jxh5Z/oWWJDCns1z2r3ULn/Cc0sSg9f6mXSj3B0gikwylVWKg0pi6rY9XG73ASIcZTQZWvZIoRlKDuOkb+hjJJDZ1y0ik057g8u7wYvXclugt6RRzxfNUNkkmZMDV5+9bustR63g2PSVpgH2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/V6yi+wMDg4kFrNEEAneW64BO+255sD/jPJaAf4IFc=;
 b=N+QtiYL5TnoDSocfoeAv8Kvf2Fhq/TzGtJ1AWR9iVYKsiB6SO8zroTRNwn1PFCSOuFoG4W3TamkBPzikkcUQXwJRkFVyoevk9n2cI6mPBHJOFuJiuf6aoXsI9FnxpPMovqbHd9ZqrbTJ0E48BRCxzePVTuEMZU6r7a3PpOJ4hlE=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3428.namprd15.prod.outlook.com (20.179.76.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Tue, 22 Oct 2019 19:18:10 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 19:18:10 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/8] mm: vmscan: simplify lruvec_lru_size()
Thread-Topic: [PATCH 1/8] mm: vmscan: simplify lruvec_lru_size()
Thread-Index: AQHViOfEo5akA3poAU6bhyPJDLwASqdnCQ0A
Date:   Tue, 22 Oct 2019 19:18:10 +0000
Message-ID: <20191022191806.GA11461@tower.DHCP.thefacebook.com>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-2-hannes@cmpxchg.org>
In-Reply-To: <20191022144803.302233-2-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:104:5::23) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:5d4e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f04f636-30e3-49ed-b7f8-08d7572493ae
x-ms-traffictypediagnostic: BN8PR15MB3428:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB34281658763CA9095A17D146BE680@BN8PR15MB3428.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(71190400001)(316002)(8676002)(52116002)(5660300002)(46003)(54906003)(4326008)(14454004)(11346002)(6916009)(1076003)(33656002)(8936002)(7736002)(305945005)(81156014)(476003)(446003)(229853002)(86362001)(81166006)(9686003)(66476007)(6436002)(102836004)(66946007)(66556008)(66446008)(6506007)(256004)(71200400001)(386003)(6512007)(25786009)(64756008)(76176011)(6486002)(478600001)(99286004)(6246003)(486006)(186003)(2906002)(14444005)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3428;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Co4J950/N66wKxqmTYvNKjoMSItHDu5zefGRIhlpItraUcU83RkLupXUaVrvdhUkWfjKxHqq3LVjfhg0bLMyXIJqa9IRMCvTwfpwFdM1L8WUV7iGiMiKpkSI3guVcZZTzq+1x0btBo9bDYdnuwa9HedzwSe9qicGk7Z1bvopqtMDbzR8eixtDO5CJw2DvoADHc4ZsizAkgEJsFUwvx6biJW5oqSu7HiJXUbgTxuU6PTI2CuDl6tnyqZnIdug37X7XXqiJ7GMuIaXpOh3LN/SX6cEDo/zDCAP/ONMhziIo1Dnxhz4Ppvatn7R6difnN8J0yI2ENuUvuN2AsLOnR48xYlpIhiiV6WASsUMRV9RZCSaDIkUak4uTwXFtcIckfH7eI/xu00dMWJqU5HvQL7kYgo2RT/7d1LBUpKkGwFCxjZqV8E2K7VAjSyqUCWRHk7V
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4335EC072729F4448C5FC9BE0C1FC642@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f04f636-30e3-49ed-b7f8-08d7572493ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 19:18:10.5973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKwvZ1ZZvfyTGAUHhawWxwNtvQIZssfwgMzAg/qnUqm2MSDX3crrFQys3//a76EJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3428
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_03:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220161
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 10:47:56AM -0400, Johannes Weiner wrote:
> This function currently takes the node or lruvec size and subtracts
> the zones that are excluded by the classzone index of the
> allocation. It uses four different types of counters to do this.
>=20
> Just add up the eligible zones.
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1154b3a2b637..57f533b808f2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -351,32 +351,21 @@ unsigned long zone_reclaimable_pages(struct zone *z=
one)
>   */
>  unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, =
int zone_idx)
>  {
> -	unsigned long lru_size =3D 0;
> +	unsigned long size =3D 0;
>  	int zid;
> =20
> -	if (!mem_cgroup_disabled()) {
> -		for (zid =3D 0; zid < MAX_NR_ZONES; zid++)
> -			lru_size +=3D mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
> -	} else
> -		lru_size =3D node_page_state(lruvec_pgdat(lruvec), NR_LRU_BASE + lru);
> -
> -	for (zid =3D zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
> +	for (zid =3D 0; zid <=3D zone_idx; zid++) {
>  		struct zone *zone =3D &lruvec_pgdat(lruvec)->node_zones[zid];
> -		unsigned long size;
> =20
>  		if (!managed_zone(zone))
>  			continue;
> =20
>  		if (!mem_cgroup_disabled())
> -			size =3D mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
> +			size +=3D mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
>  		else
> -			size =3D zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
> -				       NR_ZONE_LRU_BASE + lru);
> -		lru_size -=3D min(size, lru_size);
> +			size +=3D zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
>  	}
> -
> -	return lru_size;
> -
> +	return size;

Neat!

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
