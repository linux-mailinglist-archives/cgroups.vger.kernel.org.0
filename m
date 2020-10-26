Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD92997E7
	for <lists+cgroups@lfdr.de>; Mon, 26 Oct 2020 21:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgJZUZQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Oct 2020 16:25:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16936 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731463AbgJZUZP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Oct 2020 16:25:15 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QKFbTt028428;
        Mon, 26 Oct 2020 13:25:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SvtcLkE2YtFXPGaJJQrYm7/DO4OiLJiMHt9yRv60gtQ=;
 b=ZHkAB+z5qwRq7unhKO+/ZmmBK1Yo+hOmSxFViWHGvtly2wiC5ZQuzqC1/nIbyUNzenm3
 +7BLHpzd6pc4qSfPrwKFJHYR51FzEUMP07VcOR193pbBzeOoJHK9TpH8UFYpVSOke21+
 UJZsTz++jOhBCu6uvxMxG/lkcKTfDffqiDs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34d3rty8nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Oct 2020 13:25:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 26 Oct 2020 13:25:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY2iMHqwZLlnecI2TuYhCbv2+jVk6xQ89AdzstqzDstVnxj6/HjHTtD6SIsdAhU7+xdNaHs3IFaX5zLD1mnM7jQxNFpF/rnYzl9Sv1eDE7SZWI3ItYYvOa8MR7dcFNTNu7pJS9ITF8KsykisOl+0ntaGftS1y0mITt2pAICH5wl6MSy8nYQd2HoyZyoYbE7Gmb/5yRjcDo2gIRhHuNAvzZXl8BZfF14R7Im3DSKc22u1ZhJDQAF4Is4FZkv/benvQsquacrKE4SHdtBCsFrHtLYdKD3p+ayrodealDtJsFIYjsG/+y7BCLUzvSgTZP45ILZ8JozHs9Y7t01DatcpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvtcLkE2YtFXPGaJJQrYm7/DO4OiLJiMHt9yRv60gtQ=;
 b=oR+PqQHr4lgJcYJPZrvA8Gw9kxhBcZP4RAQgIUTistMfmLEhCOAHI4Tr2EGHUeMS75RSgwANV/fGjOAsddNO4qyl8SZ2DcJYk4YyJRYzvuLaTjJxvNDIseOkFpsFsks8Syfw3OZcn2zCzve9mTovm8ELoOfxax24h6Rw43GmKeogxbGXeSAlYpNvBNSs8h+wY76BkhTJ9GlxQCoBV3bfRTlG87m54fHlUXOOkfHbjaHxUq3ElpKoy68bmsUDLFS0XewJmd9ZHUVUHWyak8B+6ho1excnSDHiHwU1Oo/6yg59a9YjiaySVRpst/ci4iWnEB7Er1LEwydWk0tRG4BMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvtcLkE2YtFXPGaJJQrYm7/DO4OiLJiMHt9yRv60gtQ=;
 b=ZflQG0lll+zLtSCF1ub+laQVXcYsa85bpojrx1oz68eos6X5bQKj9VwFM4GMwmm9RIKIqkQ3pr6LEtvILa65CCi2GfA3ZZ2CHnfsL2P7qIAVPtvYyqZZzhrr59710YPCKuHkctj3k+nsVd/0k0H2tVJTBosyEKqOACFKu77Jqes=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3570.namprd15.prod.outlook.com (2603:10b6:a03:1f9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 26 Oct
 2020 20:24:50 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 20:24:50 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
Thread-Topic: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
Thread-Index: AQHWqIbuu9kr39B/B0y2sC9cGMZEtqmqWwyA
Date:   Mon, 26 Oct 2020 20:24:50 +0000
Message-ID: <2A2CE07F-47DC-4B3B-82D3-F0CDD2C58B42@fb.com>
References: <20201022151844.489337-1-hannes@cmpxchg.org>
In-Reply-To: <20201022151844.489337-1-hannes@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::4:31e7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 949d0bf0-8718-4e6d-52e0-08d879ed30e8
x-ms-traffictypediagnostic: BY5PR15MB3570:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3570102CD1050BB5643A8714B3190@BY5PR15MB3570.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihAHP0deinhLs0Plw/rLHqYWRc6CUpguZwg0D4JL2mDxon9voWe0xzT06AuIdcQLVR3XCL8WP/Hopuilmezp73lLOtJSXPxsH0jo45Dhf6TPQVODCfQZzJWaYs6eEcyvX93g9izqoe1Apt3qaZBgQR5oTxanWNepGlLJlIZZLFcZk/WoN2fId88z3DWY/Mog+INfeUUB8ZZWDGcROBRezm19segGXcRS0Uf5B8GAv0++IqvZSTF2WgFfC6NhzLN7NvMU5tA/+BHSPif9rjOdTCj4rusuhVSV2xEh5TAW6m8xakW+eIUS+iEZlS5n9Lz4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(39860400002)(366004)(316002)(33656002)(5660300002)(53546011)(54906003)(186003)(6506007)(83380400001)(478600001)(6916009)(4744005)(2616005)(36756003)(6486002)(6512007)(86362001)(71200400001)(4326008)(91956017)(76116006)(2906002)(8936002)(64756008)(66446008)(66946007)(66476007)(66556008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MX+oFY/d92eXlRK9cpPDV6v1zaZgeiWaG3TX4hOHgpyw4RWbIwncgd8lFKPE4g3TZLjUtIuy+nh7rpys9DDvqJo9CdX38keMKpECmWIf38VqOcmgr1bmNbgNs07+9uzbgT7SLZ2i3bVWNFCYKQbDSboLr5ktwbqiozb6dXvw878BGwKNEmJ4a9LP0SqOfmyni80qW8wHpn1AzLddwK7n+jMH8RZOBIkPldjbaSGUCDN26wiZ49nR4fzji1kL0No4lBRfD+qfpmEh7HV1xEadmBUtpoV09DUqYog0xo/JzCBPgk68WBb9uuTpG/3NgylG8qcOGwVAek/pZwQEkCbYttecaoZMxlDZVAhurum/iMylKUl/K4vREpO8G1UXf7/11djkGtz0aPHDabDq+6cdCh7CXiJqJbG6naJE1ZtTmWy8VQn2hTFIQuEy5+2iwB1WJa4zrCMFKcfxYAUT3ituHyBZOHAtXBknQ85sW4d6vm3s394TlhCYJvMKdsbU90D+099VNqQ0rUpMw38NKhKiJq2jNlm46/sf/naR0EGOxVN4AWH5SCbAAacLpRvjfEipjPTyVugoeTiS4EVGe3325oST5z3jU4b6UPzBwd8cMIg32vINLx5x7QK0+jGJ+xCZDbEVHbsXtFwKNUa8wzkFskKdFRENhDHO0wEX1oejIBxdjaHi4dD2aqEPAibzRyj/
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BC5D6CB40312340849799477F37C04A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949d0bf0-8718-4e6d-52e0-08d879ed30e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 20:24:50.6917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qADVKRMaXvYHXDmVxZX/CkBucp7Ah5H0NJ4lk0OUigPfaao3QcDThtAVVW2oOQN0Wi0/J12pFjE1hcSDZ2/GSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3570
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_14:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 clxscore=1011 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Oct 22, 2020, at 8:18 AM, Johannes Weiner <hannes@cmpxchg.org> wrote:
>=20
> As huge page usage in the page cache and for shmem files proliferates
> in our production environment, the performance monitoring team has
> asked for per-cgroup stats on those pages.
>=20
> We already track and export anon_thp per cgroup. We already track file
> THP and shmem THP per node, so making them per-cgroup is only a matter
> of switching from node to lruvec counters. All callsites are in places
> where the pages are charged and locked, so page->memcg is stable.
>=20
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Song Liu <songliubraving@fb.com>

Thanks!
