Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B449AE0AB5
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfJVRc2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 13:32:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13484 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727881AbfJVRc2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 13:32:28 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MHOZXo017383;
        Tue, 22 Oct 2019 10:31:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hTQPEcCODCJUgwDAid0u4LsGjEBeG69aYfdmn2BfDmY=;
 b=NBf/J6MNgF4ZDJV3wgGnES16nuYDupAgP9oChBWXarCR4jtZP/XashbhmFskO97rX04j
 riVUxYQ1eGF/XXMe8eKTUBkgquief+Ky7wu6VJ/+HMyXSoWKzc3e6hGiJPWPkniodHef
 yHpfIRGTHiVEOMKf7F1tqNEz6xwcEaSzz1E= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vsp6bvegc-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 10:31:25 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 22 Oct 2019 10:31:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 10:31:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqukaAI01LmWC215maRmI8v/J9nUz2NV5haG6FXHp6VSHf2V+tCHYiVRBNfxNKPJ2HOcZbxl72UsZsMZzTkbUUd8iPxQPvaYVgaTYV24TrV80sOE7mJCWHL5PcbXOMjFEo/Op915j7QnIA+Mi764xpgqK9P1YMdGVXWBiMpNoV3JFR1Tp6ejXhusYkj5U+IKLkaw/RsEROhGfWp1QnRgzGgX1maaSmdHrTGr8q6BQYmUS5K5k4i5MWWLfhym4oBBJgO2EOyeiG1iVDr2VR2Io3q4YysfpNTZVA/zKkYdtEE19v+LlN/XQ9LXkcIFYQr8tXbreca6T1ryxL1Xg5Ynjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTQPEcCODCJUgwDAid0u4LsGjEBeG69aYfdmn2BfDmY=;
 b=cfND9wASWC5TgT4RjuwtkfyDOsEjI1r/eLvn1uC6WOks68BYxAZOwlMYlm5yAaThjX889wyUxrLFhshLOKuYKviGqApSgg1x6IC/ZhqJVmKeH58NHOoh4YkefIqbQXM3qijgimuN5sxPpiOBbzsikuj8Glrta/Yy6ZMndbHQbZo2fd/PBxArs+1KMtiAbWJh8RSZphLTu+czTjePcEH/Co1WYK2R7VAAU3R7man2rWns4Qg0cA6fhk3wbcVqvBTD0KHzw772QsB2AR49kJm0+NgoKwqotacjXd0S56z8xjNlZ3qtcPHn0kTJbPl2Jziz9Kbg4uthcB9TTasSBza8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTQPEcCODCJUgwDAid0u4LsGjEBeG69aYfdmn2BfDmY=;
 b=jC+gQcHnhjfk2G9EIDcnybehplvV37hBhSWOO6oMjYLDxXOUumKMwBBwYUFJ1D66lP9czs3J9zcrzVdpMU7lfGhBII5cw++TZHCootkSGWJubVp+IkZDz31OfTKuFvC5p5IdqQgXARRThdkhVHdh9XR6+TBvslc8miB6nwDXH0U=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2930.namprd15.prod.outlook.com (20.178.220.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 22 Oct 2019 17:31:19 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 17:31:19 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Honglei Wang <honglei.wang@oracle.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH] cgroup: freezer: don't change task and cgroups status
 unnecessarily
Thread-Topic: [PATCH] cgroup: freezer: don't change task and cgroups status
 unnecessarily
Thread-Index: AQHVh+gjYPie2GVScEWCWWzVFHDWDKdmrj2AgAA+8oA=
Date:   Tue, 22 Oct 2019 17:31:18 +0000
Message-ID: <20191022173113.GD21381@tower.DHCP.thefacebook.com>
References: <20191021081826.8769-1-honglei.wang@oracle.com>
 <20191022134555.GA5307@redhat.com>
In-Reply-To: <20191022134555.GA5307@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0079.namprd07.prod.outlook.com (2603:10b6:100::47)
 To BN8PR15MB2626.namprd15.prod.outlook.com (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:e274]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30e3ea3c-c837-4c69-f8b3-08d75715a5fb
x-ms-traffictypediagnostic: BN8PR15MB2930:
x-microsoft-antispam-prvs: <BN8PR15MB2930EBA3A87D993C54808109BE680@BN8PR15MB2930.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(136003)(396003)(346002)(189003)(199004)(229853002)(316002)(54906003)(6116002)(2906002)(86362001)(446003)(6486002)(6916009)(5660300002)(11346002)(486006)(476003)(1076003)(46003)(305945005)(66946007)(7736002)(71190400001)(71200400001)(81156014)(256004)(14444005)(8936002)(81166006)(64756008)(66476007)(66556008)(66446008)(25786009)(33656002)(6246003)(4326008)(99286004)(14454004)(478600001)(186003)(102836004)(386003)(6436002)(9686003)(6512007)(6506007)(8676002)(52116002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2930;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5L4plQYlUM0HAveGj+CiGqvQkT5O+oT6QUG2jxlzV3cW+ZSGWgN68mWGCa3PLaXkGcPdJFSMLoLOtVo/o/p2tEGTYQ94DRAxz1niYB73J0pSeMY6yLPTFsZPBRw+5QxsWPtWi3FV0+8BDhfmbRh1ZBdXWIweiN+aPFKnjeT4lRF+dZ2qC/dKbP6VnoopnUpeW9b7BGjVCs62h/oeMEqn+7AyB07/CRWbqJxoJM04eXmeEcw1btuDqpph5/MgnEE72sh8090XIZl47bxce6XndkH8j/1edNWpW2/wiPvOe/Ye6r2d4lSVhGJyU3xalnhhewrAr/a46UxO1SlEyYcGwwZ+xxlvfwiQ+SO10kMG+NSuVpGZ0cZLhxZKMZYZTYy2L67yBAg7xapnJmCBWy/bBXKWWniZb+Zhf/X9M/AbW+ZiPaZB/jwG/R6SQG0iUgq
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C6C0C51232BBBD4FB2167E6FD11C6B3F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e3ea3c-c837-4c69-f8b3-08d75715a5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 17:31:18.9066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oL7VJ+BEW17ZomsHZlaBMz7ajArak4/c/c0vVwmlp51Uob9mE8dVncUyhHgxvklD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2930
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_03:2019-10-22,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 mlxlogscore=758 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220144
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 22, 2019 at 03:45:55PM +0200, Oleg Nesterov wrote:
> On 10/21, Honglei Wang wrote:
> >
> > @@ -230,6 +230,15 @@ void cgroup_freezer_migrate_task(struct task_struc=
t *task,
> > +	/*
> > +	 * It's not necessary to do changes if both of the src and dst cgroup=
s
> > +	 * are not freeze and task is not frozen.
> > +	 */
> > +	if (!test_bit(CGRP_FREEZE, &src->flags) &&
> > +	    !test_bit(CGRP_FREEZE, &dst->flags) &&
> > +	    !task->frozen)
> > +		return;
> > +
>=20
> If we want to optimize cgroup_freezer_migrate_task()... I am sure I misse=
d
> something, but can't we do better ?
>=20
> If a frozen task enters or leaves cgrp, this should never change the stat=
e
> of FROZEN bit?

Yes, it's correct.

We probably can, but I'm not sure if we want it: moving a frozen task isn't
a hot path, so code simplicity and correctness are way more important here.

It's not an objection to the proposed change though.

>=20
> Oleg.
>=20
> --- x/kernel/cgroup/freezer.c
> +++ x/kernel/cgroup/freezer.c
> @@ -238,14 +238,14 @@ void cgroup_freezer_migrate_task(struct
>  	if (task->frozen) {
>  		cgroup_inc_frozen_cnt(dst);
>  		cgroup_dec_frozen_cnt(src);
> +	} else {
> +		if (test_bit(CGRP_FREEZE, &src->flags))
> +			cgroup_update_frozen(src);
> +		if (test_bit(CGRP_FREEZE, &dst->flags)) {
> +			cgroup_update_frozen(dst);
> +			cgroup_freeze_task(task, true);
> +		}
>  	}
> -	cgroup_update_frozen(dst);
> -	cgroup_update_frozen(src);


> -
> -	/*
> -	 * Force the task to the desired state.
> -	 */
> -	cgroup_freeze_task(task, test_bit(CGRP_FREEZE, &dst->flags));

Hm, I'm not sure we can skip this part.

Imagine A->B migration, A has just been unfrozen, B is frozen.

The task has JOBCTL_TRAP_FREEZE cleared, but task->frozen is still set.
Now we move the task to B. No one will set JOBCTL_TRAP_FREEZE again, so
the task will remain running.

Is it a valid concern?

Thank you!
