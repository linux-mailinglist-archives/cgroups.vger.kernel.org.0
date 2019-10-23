Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90DEE2070
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407214AbfJWQWU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 12:22:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18504 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404929AbfJWQWT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Oct 2019 12:22:19 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9NG5EHO011801;
        Wed, 23 Oct 2019 09:20:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9jhF9/rS1XjLcBr0YSo5jWT8FcAtn6x7aR0dCIo7uPE=;
 b=oS2H6ZyeK8I3vxAezJ7LcA0IdQXmT93ZeUJone8+hHJjhYctpO+RwssOdaEOJ8Rgn/EF
 p8xNQ6EcRjxWL5uil0Q3vlnI4kiuvOhQi2jxESx7CqE1uBvcpr7AQX4rxglICk3YxH0P
 Ff9KsuPBomWWia9It41p7uArDRR7lLZqD3E= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vt9tt46nv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 09:20:37 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 23 Oct 2019 09:20:36 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 23 Oct 2019 09:20:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqyVaxtyxX3Nf3he8tJ61MWcL7rkonauPoIreURiGxg9mYJTmmExD4gw8novxg0O3ODsEqzI9nz8aCD6KV7o0pjmuME3hbqDuKhObDZy+b7nC+Q8Guq1G8OfvUIfLUPXDrL4NbIDE2iLn/t+s36dVyys2d4b1CeSnwg4B9uU6Slk8qrH8hCysXwcNzHkMeoXnbf6PYJZTn4DoAmxcQx0cqCtq5NvgKm76J94INkC5Bfdr7g69u5+ShMJFhj9yYrzgvsfEbisWavcnyRhiWSfyJPZ0gJbHzHEpanFcHhuvLKR3+rDQPBsbooTXVeEkvT4zp7n0VZcI3Jp9EGLb/Kp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jhF9/rS1XjLcBr0YSo5jWT8FcAtn6x7aR0dCIo7uPE=;
 b=Ce3maLl8XsfodOcwXdPaKoUnQkv9l019Cqp3FIHfv+fPosL5W+DqfH99/1qOM2wg+7b/MKA2susfAFG0S2arcJbDBbIquSy1ZFLEAMcO8gqAdXD8Jv3kVHO2LKptMPEwArLT5Liemd3ISfI2SCN7U8ZJtiRUNyNtBR/37FF/HTIMOxXQnsOyUlI2BOlZLr+/zqTIkvmSXA0CYpSdIJhqp8eLl6Knd/n7thoPFCMGXvz5muJEIcWcn7dBzSONQT4MDbXHjBT/Sk1iANatF5VPJY7LowX10MpLxTz261Ez3oFXjKrNmgjrfo4i9qTIpvDyBaXuEgjFi5pivAGc93Br4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jhF9/rS1XjLcBr0YSo5jWT8FcAtn6x7aR0dCIo7uPE=;
 b=kCaJuhZFMtOvHj9JQpST8LNulp0ii9rIbg4KhYPuvFJ+HofP+ji/oDP+1voqkUQZW3JH4uu+AZUMkl3jUcGdfqekOM1LccDGbcASjbyDWMohpcyEgjSoXjYmheSGEWv4aBA7Q3l522ngSIPL2VGHXGN+mI8MswQTvgOhw2M5ZuY=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3004.namprd15.prod.outlook.com (20.178.231.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Wed, 23 Oct 2019 16:20:15 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::6c21:9cae:72c2:695]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::6c21:9cae:72c2:695%7]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 16:20:15 +0000
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
Thread-Index: AQHVh+gjYPie2GVScEWCWWzVFHDWDKdmrj2AgAA+8oCAAU03AIAAMUaA
Date:   Wed, 23 Oct 2019 16:20:15 +0000
Message-ID: <20191023162011.GA27766@tower.DHCP.thefacebook.com>
References: <20191021081826.8769-1-honglei.wang@oracle.com>
 <20191022134555.GA5307@redhat.com>
 <20191022173113.GD21381@tower.DHCP.thefacebook.com>
 <20191023132350.GB14327@redhat.com>
In-Reply-To: <20191023132350.GB14327@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:300:94::30) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:16f6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f350110-610a-43d9-98f7-08d757d4e308
x-ms-traffictypediagnostic: DM6PR15MB3004:
x-microsoft-antispam-prvs: <DM6PR15MB30049C1BD712609189955848BE6B0@DM6PR15MB3004.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(86362001)(25786009)(6436002)(5660300002)(6116002)(81166006)(486006)(4326008)(81156014)(46003)(6486002)(8676002)(229853002)(478600001)(64756008)(476003)(66446008)(66946007)(66476007)(66556008)(446003)(11346002)(6916009)(9686003)(305945005)(7736002)(316002)(186003)(102836004)(14454004)(8936002)(6506007)(386003)(6512007)(6246003)(256004)(14444005)(76176011)(33656002)(52116002)(2906002)(71190400001)(1076003)(71200400001)(99286004)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3004;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QX9F9OYUyJVWEZvlrf9ZxzTytq2ZEcrCC7MKZm/M+F+ymtLxFeQevI1HZytz2HJxw4nlHogG2xMDoG4D+/rBLPzwMKOjZeKT1nGfVtsu9VylfItYv4DUdtGJFOwokZSiLyckQmSZQbkzYkRcCNnJ/Xz6OmM8eSFufG7GdNHwTUt56QRUBIvXtJbVfmJlgU/1M+bKBq8DIJ1vu86/PkoH/w3OC2Fmk1/4to6Sj06hmIwq+yZ0gB2ie9hi3qGv+zm9/KXjqlqQISE4avRM7MiMx5ohP34/xvF5Tgy8G1HctImtKFKa9O9MKvzNVwEPmqJwI3MjoM109O+jZ3qZbH3SVFJ5NsLvG/VrDntZo/jC70UjY/B6Rpx2yYfBr15Ta/t+nmeyZZbfabfC5jPhul50iZjAtob/iE/fcr0XjzW0LdV0Haaav8yMrQ4XDKnr56ar
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C54AEF01DDB44D44B86E5FF761835C99@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f350110-610a-43d9-98f7-08d757d4e308
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 16:20:15.1948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYhuuHuzUsng5OdgRxHPKygBD3K4IDSm1At5SyCaNh2qKSJ9FPu9FGW9ByhN7XDf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3004
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_04:2019-10-23,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=633 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230156
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 23, 2019 at 03:23:50PM +0200, Oleg Nesterov wrote:
> On 10/22, Roman Gushchin wrote:
> >
> > On Tue, Oct 22, 2019 at 03:45:55PM +0200, Oleg Nesterov wrote:
> > >
> > > --- x/kernel/cgroup/freezer.c
> > > +++ x/kernel/cgroup/freezer.c
> > > @@ -238,14 +238,14 @@ void cgroup_freezer_migrate_task(struct
> > >  	if (task->frozen) {
> > >  		cgroup_inc_frozen_cnt(dst);
> > >  		cgroup_dec_frozen_cnt(src);
> > > +	} else {
> > > +		if (test_bit(CGRP_FREEZE, &src->flags))
> > > +			cgroup_update_frozen(src);
> > > +		if (test_bit(CGRP_FREEZE, &dst->flags)) {
> > > +			cgroup_update_frozen(dst);
> > > +			cgroup_freeze_task(task, true);
> > > +		}
> > >  	}
> > > -	cgroup_update_frozen(dst);
> > > -	cgroup_update_frozen(src);
> >
> >
> > > -
> > > -	/*
> > > -	 * Force the task to the desired state.
> > > -	 */
> > > -	cgroup_freeze_task(task, test_bit(CGRP_FREEZE, &dst->flags));
> >
> > Hm, I'm not sure we can skip this part.
>=20
> Neither me, but
>=20
> > Imagine A->B migration, A has just been unfrozen, B is frozen.
> >
> > The task has JOBCTL_TRAP_FREEZE cleared, but task->frozen is still set.
> > Now we move the task to B. No one will set JOBCTL_TRAP_FREEZE again, so
> > the task will remain running.
> >
> > Is it a valid concern?
>=20
> Not sure I understand... The patch doesn't remove cgroup_freeze_task(),
> it shifts it up, under the test_bit(CGRP_FREEZE, &dst).

Yes, but it does remove cgroup_freeze_task(task, false) if the target
cgroup is not frozen. So a much simpler test case will fail: if a frozen
task is moved from a frozen cgroup to a running cgroup, it will remain
frozen. Sorry for the confusion with my original example, it's obviously ba=
d.

Thanks!
