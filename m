Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B1712746F
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2019 05:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfLTEGf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Dec 2019 23:06:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7254 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726986AbfLTEGf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Dec 2019 23:06:35 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBK41xgY014204;
        Thu, 19 Dec 2019 20:06:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Sn8mdDEZbmlAseTcnBwC4N9LFeeFcWpfGwn1PGVmyY8=;
 b=GPmOI/HWcKnxg7HnTO1FwOjg0Q7Cy8Zm+Q5z1xLXncu66dTMEVGL1LwUJkfg60PWdYam
 tJOL+C7zdoAIjA8vRDBQI07uIRL5/Hj+G7K6vb83qp4cyZKuxOfR0lCtcOSi/Vp/M/KI
 YfXmpNSua/RGYvodwUd+ifVPcdAE5d5zQ0g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2x01dfwrya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 Dec 2019 20:06:26 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Dec 2019 20:06:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5qTSKMZTbSJsqzJxPnGwyVjCvUVXrJtYSp/+MVRoZzSdegCFvBwMw+BO4BIjsh6Iod5u7Qg8naFjlL6lxvtU1Ld88+BAmARopwn2lgeFEIrLYV/b/3YIK7/DdBt7DBoCKAvbEjt1kyIlYdscsW6a96MGFZcCXkysLJ1kzFSb05VFRmX5jPHrUIrPD8VnOoHc3ihNNv78xSCv19+sSpUGGQOMwYhnHyriX+ICNQvf13/lIBVLgqrOnBjqHkRtfoYEBalVMH3luo7kxlIVuzfVWz4vKBvn3Xv8Rdn6AlK9FtC/rr0CMyXWcSVLxpvr0rCRdjzl/fRuEfFjMnUate7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn8mdDEZbmlAseTcnBwC4N9LFeeFcWpfGwn1PGVmyY8=;
 b=AtcFvnmxiqmIAQhKoW+Y6603RyMGSP0cux8w4ysapvV/YbuYX3hZHSvWw3J9kR0y9RX+MVJJFngSNG00g6MH5+CZpYLf0//CSW1dDlgr/vAFfcGDXZzJKD13ltvBTfDiWGbhZ6FU5qW363R2QGo4d6XURBTjBCMoAcnuvqHALRMRkKodd+X35i1dO6gR6Hl3yCjrenaIXPBhuMQUhExbLoaHcyTuidWgCAM823f3ULodw8Yj8vjCN6yV4BmJB1SqUWzfD+8AACHauF5ZZkD/UJfQG8w1bvRYySI7U88ZBsoEZZgl/rpQDWrl2CrFUZtXv+bWbRdpV146rAQHI5VdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn8mdDEZbmlAseTcnBwC4N9LFeeFcWpfGwn1PGVmyY8=;
 b=ZABfVH0t5DzZpNrVRqKHif4o/rRO+S4OE71/DkDPLJ5+TcVeIdwpe9jDAH//9HKT9oqlBk2xW951mjogBqimcQ8Xor6JJcurRn21Kgryoy32yuYHZocL6GjYiq2oqi4FN7C5tPWLBTTR+g/hBSlwl8UvmhG1FpU27gBfanBzzsY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2807.namprd15.prod.outlook.com (20.179.158.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 20 Dec 2019 04:06:23 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2559.012; Fri, 20 Dec 2019
 04:06:23 +0000
Received: from localhost.localdomain (2620:10d:c090:180::c7de) by MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.2 via Frontend Transport; Fri, 20 Dec 2019 04:06:21 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 0/3] mm: memcontrol: recursive memory protection
Thread-Topic: [PATCH v2 0/3] mm: memcontrol: recursive memory protection
Thread-Index: AQHVtqfzhe/2CaI+GUqL7UNG9lFOkafCaFgA
Date:   Fri, 20 Dec 2019 04:06:22 +0000
Message-ID: <20191220040618.GA8069@localhost.localdomain>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
In-Reply-To: <20191219200718.15696-1-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR2101CA0012.namprd21.prod.outlook.com
 (2603:10b6:302:1::25) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::c7de]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ae1820e-4494-4638-9511-08d78501f9ae
x-ms-traffictypediagnostic: BYAPR15MB2807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB28072547552989A13450FDB8BE2D0@BYAPR15MB2807.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(346002)(396003)(366004)(54534003)(189003)(199004)(1076003)(316002)(6506007)(4326008)(69590400006)(86362001)(33656002)(8936002)(5660300002)(186003)(6916009)(52116002)(16526019)(81166006)(81156014)(71200400001)(9686003)(8676002)(7696005)(66556008)(54906003)(66476007)(55016002)(66946007)(478600001)(66446008)(2906002)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2807;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 525pGNGKqI28trkpoZDwyqhlaKSvDfSQDMziNBvuwQkzYTCXjOoNHvOtnbo/ZpTe7L80gJVD2w8lMzG0fYetKIRyt7zCZjKE3dWGTPt7YBEWHCy7bDwRgHnPeM2ojg50+6vja31Zb9iTd34hPCtJFGZ0ePsmwbfSKC3OvkbGql5K3eGTb4RxWDgHmdtnyUauFxof01xv15xnQOpO91QcsTuW7kp5OMBrSdp/lRj50jQRL9nGH7bINQU8eBvBbGQzpNs6+dE3FPLNPUGWQgMWnQmawlzU/zdTDhUFFQC2niEot4dFxfAVBi4k21WpqLyxW++5witEro7YSiCOzxOeXLOxzaTg9ZVc6hAjkx7PY0ITItyPvpoWBEJW3iWZr84RlTLYNIv9bm0BsgI+eNFWOWjWyULThJmK21MszFZ/0T62hbCTzbufnk+CzqStRz5aHTwSCcjQCCUhTde8B1JvWYqJ1PXu0ZenKTApGC4BhP3ifWIgk1sFXFw9DG4DSMFF3q7BYnY4keCyIPsrkt6DnQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CAFF278338101D4AB85FB890F3EC784B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae1820e-4494-4638-9511-08d78501f9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 04:06:23.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJeVPCWan4t5c1mIg8EftgS/tNEzc8frxNCito/fLPAhmc/RTKkkXezBo2CEtn85
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2807
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_08:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200028
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 19, 2019 at 03:07:15PM -0500, Johannes Weiner wrote:
> Changes since v1:
> - improved Changelogs based on the discussion with Roman. Thanks!
> - fix div0 when recursive & fixed protection is combined
> - fix an unused compiler warning
>=20
> The current memory.low (and memory.min) semantics require protection
> to be assigned to a cgroup in an untinterrupted chain from the
> top-level cgroup all the way to the leaf.
>=20
> In practice, we want to protect entire cgroup subtrees from each other
> (system management software vs. workload), but we would like the VM to
> balance memory optimally *within* each subtree, without having to make
> explicit weight allocations among individual components. The current
> semantics make that impossible.
>=20
> This patch series extends memory.low/min such that the knobs apply
> recursively to the entire subtree. Users can still assign explicit
> protection to subgroups, but if they don't, the protection set by the
> parent cgroup will be distributed dynamically such that children
> compete freely - as if no memory control were enabled inside the
> subtree - but enjoy protection from neighboring trees.
>=20
> Patch #1 fixes an existing bug that can give a cgroup tree more
> protection than it should receive as per ancestor configuration.
>=20
> Patch #2 simplifies and documents the existing code to make it easier
> to reason about the changes in the next patch.
>=20
> Patch #3 finally implements recursive memory protection semantics.
>=20
> Because of a risk of regressing legacy setups, the new semantics are
> hidden behind a cgroup2 mount option, 'memory_recursiveprot'.

I really like the new semantics: it looks nice and doesn't require
any new magic values aka "bypass", which have been discussed previously.
The ability to disable the protection for a particular cgroup inside
the protected sub-tree looks overvalued: I don't have any practical
example when it makes any sense. So it's totally worth it to sacrifice
it. Thank you for adding comments to the changelog!

Acked-by: Roman Gushchin <guro@fb.com>
for the series.

Thanks!
