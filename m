Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69DE40EB
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2019 03:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbfJYBRu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Oct 2019 21:17:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4166 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388515AbfJYBRt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Oct 2019 21:17:49 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9OJdLnT030060;
        Thu, 24 Oct 2019 18:16:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=l4flFa18hW/haqSa2WZ5Q/gZakoCES+LDialWRhhLOY=;
 b=TW4iP9j+/QO5TL2qEaky0UjlXhI7SbMma8RbDZzXRRh2RltjyFAhabW8ivlWJw236CcU
 9344K9kCUxr380KPA+zCEglceLeH+Ph8Fo2oJjD8lLhTIDkro4tqEArO3GTyZ83YimDi
 ntY67YFA/fLmhvMJ3a2SQmPNdWQpE5Vfh6Q= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2vuja7s7jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 18:16:52 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 24 Oct 2019 18:16:51 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 24 Oct 2019 18:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYd9gnbmV3GU4LY3Uy4wwkKe7f7kI5n1XsQ16jIlR4rUaTlgzo2Bms9LDJiBcj3k4MfaoLxkKuiw6hWhvzP+qYeA5xIjGyMMdjZ+CXFkiV0oQKFJyAMwrV6/kCDLxHUgtYoQc/O4Aw4YwUXqgwcGQ84D7i3daSo7hGDCedl2DaReKuH/kzGxjZsZXOwDJTOjCGrxLpo/RCiV/PSAr3SmIVv9xnNK+70sr/S7dZlYGWEXA6m1MsljmF03IajRFbeWCKYQDF+KL9lKP9CGTyRQQv1uAjbAdsVWlaNUaH3LVPGD65C3VgYBq9N78Bw22QRu+F0nisG94v5eI/eBjYINuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4flFa18hW/haqSa2WZ5Q/gZakoCES+LDialWRhhLOY=;
 b=LbsRuMSga+ycePtKfkZNKUhQinVEe9M6S6+PInd2rI4Xy1zJkYYROlSQ75bwUQWMT+ZcHMsRPeBjyI7DzSs3r4L0+NJ6wXFDFEKn7GkRSDom0Qk14a/ryfgNPoupf9ZpdtHObM4nBKHn93Xu8VAnd15F19CGa4CeIlrtQmAhIKx4ZX6cFOiPbXka5R+AAck9lOpHc354Md7AF01UwPqqYCF57+1wjowgS67K+cmNxgI2SExVUHa87ydBe49rWx+88XOHZofqjsPcTJhHMtATO6Xlc24Jx9sn9u59BLRhY3dRx7Oag9C/IvgcDL97+fE5XjkolHtA/ZPsVEPZRysO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4flFa18hW/haqSa2WZ5Q/gZakoCES+LDialWRhhLOY=;
 b=RAEKv0MOPqrMTl4/pOVTpWHkQ01OyJX3EeH50OX2bdSH8MkRQg3osj3a4MPP17kCoTErPLSd5fyhCiwFU7OFlb7p2oxS8TLH3Fve1EWZNMdVgV/SnG1QjjccgnMr1uNsheJeFGo5KfQtXQ2B5rPRv79CDeClb8kFXeEMwDVR3uM=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3218.namprd15.prod.outlook.com (20.179.73.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 01:16:50 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 01:16:49 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Honglei Wang <honglei.wang@oracle.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: Re: [PATCH] cgroup: freezer: don't change task and cgroups status
 unnecessarily
Thread-Topic: [PATCH] cgroup: freezer: don't change task and cgroups status
 unnecessarily
Thread-Index: AQHVh+gjYPie2GVScEWCWWzVFHDWDKdlRYeAgAI7EACAAxNUgA==
Date:   Fri, 25 Oct 2019 01:16:49 +0000
Message-ID: <20191025011645.GA16643@tower.DHCP.thefacebook.com>
References: <20191021081826.8769-1-honglei.wang@oracle.com>
 <20191021161453.GA3407@castle.DHCP.thefacebook.com>
 <4db30150-262d-b69f-3adf-4cc1be976119@oracle.com>
In-Reply-To: <4db30150-262d-b69f-3adf-4cc1be976119@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:300:4b::26) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::c513]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cc529a1-6cd9-4df1-072f-08d758e902dd
x-ms-traffictypediagnostic: BN8PR15MB3218:
x-microsoft-antispam-prvs: <BN8PR15MB3218428BF25D8CFF19A1F362BE650@BN8PR15MB3218.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(66946007)(8936002)(76176011)(66476007)(2906002)(46003)(316002)(6436002)(229853002)(186003)(14444005)(54906003)(9686003)(6246003)(256004)(6916009)(53546011)(486006)(4326008)(6506007)(386003)(6486002)(476003)(102836004)(11346002)(446003)(71200400001)(71190400001)(561944003)(33656002)(6512007)(14454004)(478600001)(81156014)(305945005)(7736002)(25786009)(8676002)(1076003)(81166006)(64756008)(5660300002)(86362001)(6116002)(66556008)(66446008)(52116002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3218;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ILhIZdGxoqAPN31IG0TedUQmQZfJxBN3iJNjmpS6lTTVifvZkgHQKVDOJvplsS22C0A83kNXG+pFO6fDQAOcVNG5t0po8r23t96j3WUJXgRY3QZAS/yP2On5BWQYoX6PAgqfvLc7PoTDUWtNCFTz1TMLGsMPqW0ZfujRILvKlBvZtYvAutDHlO2VE1E+E1DnT6zeMnq6iRKtxXTlFjAeV8kubW5LbGlHa21WGrh156fNtfKz+wdgVOITEqtyGfrQEXqoTyhzMPY4f+WywgMIxyKBobs6qJq5j4gu8IHA9Le6hLU43Urlgp8FAVcBdlIJdHUeG1pHWOJCZrHa2ZkWvrdQ0yDGaa0NmXwujNM7Zd1Kto1fVPsgpghGeWEsEkAxWQzdpSGzjJdm5rSnyP0q41GWF+wU6zisCp8zOwPYIdOY+GV76P1o7t5X7QsiQfGN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B58CEE4892F3EB459A325FD30230436D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc529a1-6cd9-4df1-072f-08d758e902dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 01:16:49.7277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w47UZbl5a8MwuGO0mdGS2yEg+zgOPk9OdHPTXtLr/ddXD2sA3pdaJcUQasK39MQ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3218
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_11:2019-10-23,2019-10-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910240184
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 23, 2019 at 10:18:48AM +0800, Honglei Wang wrote:
>=20
>=20
> On 10/22/19 12:14 AM, Roman Gushchin wrote:
> > On Mon, Oct 21, 2019 at 04:18:26PM +0800, Honglei Wang wrote:
> > > Seems it's not necessary to adjust the task state and revisit the
> > > state of source and destination cgroups if the cgroups are not in
> > > freeze state and the task itself is not frozen.
> > >=20
> > > Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
> >=20
> > Hello Honglei!
> >=20
> > Overall the patch looks correct to me, but what's the goal of this chan=
ge?
> > Do you see any performance difference in some tests?
> > Maybe you can use freezer tests from kselftests to show the difference?
> >=20
> > Your patch will sightly change the behavior of the freezer if unfreezin=
g
> > of a cgroup is racing with the task migration. The change is probably f=
ine
> > (at least I can't imagine why not), and I'd totally support the patch,
> > if there is any performance benefit.
> >=20
> > Thank you!
> >=20
>=20
> Hi Roman,
>=20
> Thank you for your attention!
>=20
> When I debug another problem, I just happen add some debug print which sh=
ow
> me there are many tasks be woke up when moving tasks from one cgroup to
> another. After a bit more test, I find there are hundreds of task waking =
up
> happen even when the kernel boot up.
>=20
> All of these tasks are not in running state when they are moved into a
> cgroup or moved from one to anther, and the movement itself is not the
> signal to wake up these tasks. I feel it's waste that the whole wake-up
> process have to be done for the tasks who are not supposed ready to put i=
nto
> the runqueue...

Hello Honglei!

I'm deeply sorry, I've missed your e-mail being thinking about the proposal
from Oleg and various edge cases.

I don't think saving 50% cpu time on migrating 1000 tasks is important,
but not waking tasks without a reason looks as a perfect justification for
the patch.

Please, fell free to use
Acked-by: Roman Gushchin <guro@fb.com>
after fixing the comment and adding some justification text to the commit
message.

Thank you!

>=20
> Then I think further, if somebody want to move huge amount of tasks from =
one
> cgroup to another OR from the child cgroup to its parent before remove it=
,
> more such waste happens. I do a test which move 1000 tasks from child to
> parent via a script:
>=20
> without the code change:
> real 0m0.037s
> user 0m0.021s
> sys  0m0.016s
>=20
> with the code change:
> real 0m0.028s
> user 0m0.020s
> sys  0m0.008s
>=20
> it saves 50% time in system part (yes, 0.008s is not a big deal ;)).
>=20
> Does it make sense to you?
>=20
> Thank,
> Honglei
>=20
>=20
> > > ---
> > >   kernel/cgroup/freezer.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> > > index 8cf010680678..2dd66551d9a6 100644
> > > --- a/kernel/cgroup/freezer.c
> > > +++ b/kernel/cgroup/freezer.c
> > > @@ -230,6 +230,15 @@ void cgroup_freezer_migrate_task(struct task_str=
uct *task,
> > >   	if (task->flags & PF_KTHREAD)
> > >   		return;
> > > +	/*
> > > +	 * It's not necessary to do changes if both of the src and dst cgro=
ups
> > > +	 * are not freeze and task is not frozen.
> >                         ^^^
> > 		are not freezing?
>=20
> Will fix it in next version if we think this patch is necessary.
>=20
> > > +	 */
> > > +	if (!test_bit(CGRP_FREEZE, &src->flags) &&
> > > +	    !test_bit(CGRP_FREEZE, &dst->flags) &&
> > > +	    !task->frozen)
> > > +		return;
> > > +
> > >   	/*
> > >   	 * Adjust counters of freezing and frozen tasks.
> > >   	 * Note, that if the task is frozen, but the destination cgroup is=
 not
> > > --=20
> > > 2.17.0
> > >=20
