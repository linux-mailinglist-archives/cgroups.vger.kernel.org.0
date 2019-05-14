Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9F4C1CE39
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 19:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfENRqO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 13:46:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33890 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbfENRqO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 May 2019 13:46:14 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EHebuK016014;
        Tue, 14 May 2019 10:46:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iFTJ0SqketpKa3Ua/Wo7Oc5guTdLd4V8cmejc+ytmug=;
 b=lukHVSqqVLpq/Gt+ZszLWxFY6MEWOlHIp0DoS3rW9X+JDMD9I8ipHev2goAdWseEwUQB
 RnTOMqHXcu41mbxqPh1Eb7Pikyo1wQZUPb4rjCI8AqUp0tZwL+kNuI8RXVQv6HqRs2Se
 Rp5EROZr7k9B86QcHfDBq9JjvLiSz1gEwzg= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sfs5ht067-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 May 2019 10:46:11 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 14 May 2019 10:46:09 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 14 May 2019 10:46:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 14 May 2019 10:46:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFTJ0SqketpKa3Ua/Wo7Oc5guTdLd4V8cmejc+ytmug=;
 b=GukmpHwaZrU4SLgX/I8WijkXNZveGAuFz+tDhn/Sjs1/AqDGVT+eR1zJf4FCN8xcN8hjz+1aj2tNwkkvW17jYBz7mQamSer4MHNPcmFUnIjHDAi9xjjJ6ND8E0ypVqjhfbR0oDZ701U3bvv+aFAdmb3Kd14gmZoeX8lbT7DZFWw=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3191.namprd15.prod.outlook.com (20.179.56.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 14 May 2019 17:46:07 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 17:46:07 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Tejun Heo <tj@kernel.org>, Alex Xu <alex_y_xu@yahoo.ca>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal: don't always leave task frozen after
 ptrace_stop()
Thread-Topic: [PATCH] signal: don't always leave task frozen after
 ptrace_stop()
Thread-Index: AQHVCcYNSLY5w2Qdtk+XJPFi9yaJA6ZqySyAgAAdFIA=
Date:   Tue, 14 May 2019 17:46:07 +0000
Message-ID: <20190514174603.GB12629@tower.DHCP.thefacebook.com>
References: <20190513195517.2289671-1-guro@fb.com>
 <20190514160158.GB32459@redhat.com>
In-Reply-To: <20190514160158.GB32459@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1001CA0024.namprd10.prod.outlook.com
 (2603:10b6:301:2a::37) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::298]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f977f296-3b25-43c0-9031-08d6d8940ada
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3191;
x-ms-traffictypediagnostic: BYAPR15MB3191:
x-microsoft-antispam-prvs: <BYAPR15MB31912A76A3161C3F93A38896BE080@BYAPR15MB3191.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(54534003)(71200400001)(71190400001)(6116002)(86362001)(1076003)(2906002)(256004)(14444005)(5660300002)(6916009)(53936002)(305945005)(7736002)(4326008)(25786009)(6246003)(68736007)(8936002)(81156014)(81166006)(486006)(46003)(446003)(476003)(11346002)(99286004)(54906003)(14454004)(498600001)(186003)(6506007)(76176011)(52116002)(102836004)(66476007)(53546011)(66446008)(33656002)(9686003)(386003)(8676002)(64756008)(6436002)(66556008)(6512007)(229853002)(6486002)(73956011)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3191;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ENf6Et+s3mIM1ZBFVgrFfDAMwStSqkbhVKc7vXHmBXWhsBt9VdgJN40zfbR4mlzNtrsoVE3Nlqs4rTj1jgoum5wJK6DQOkzAavluy4MND0hpaLwQkT5R3a5+H1ITTceqU0EsAlTdG+aZnvNdb/0R1YDpjzekjTnw6YA4wVYwM4rxvR5KWaRQOfu0QIgIvydGyl+vJQ23bQ9EtZQ07pW2r1bRZqPRkyN/HhZiHRsp2C292s8qhMMUIiE4YgdHk1ju1xmq+6zhJgc4Tn9YANhTv3me1WanbCLX1EhXVkRRUXITawxpS5QGMVlxW5i2AR5fyk1N5nd2xfEl1x8uZ6C/gnufxo2yiIX5J7HbFeX+iJ+LU137jXF0ZWj92qPqR9Tasu9w9es+I7a3skb2VV6nmvH0xZ25DmdFd/uCj9y5KsM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C22CEF3A0D495548B30C6E790ADAA0FC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f977f296-3b25-43c0-9031-08d6d8940ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 17:46:07.1047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3191
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 14, 2019 at 06:01:59PM +0200, Oleg Nesterov wrote:
> Roman,
>=20
> Sorry, I can't agree with this patch. And even the changelog doesn't
> look right.
>=20
> On 05/13, Roman Gushchin wrote:
> >
> > The ptrace_stop() function contains the cgroup_enter_frozen() call,
> > but no cgroup_leave_frozen(). When ptrace_stop() is called from the
> > do_jobctl_trap() path, it's correct, because corresponding
> > cgroup_leave_frozen() calls in get_signal() will guarantee that
> > the task won't leave the signal handler loop frozen.
> >
> > However, if ptrace_stop() is called from ptrace_signal() or
> > ptrace_notify(), there is no such guarantee, and the task may leave
> > with the frozen bit set.
>=20
> ptrace_signal() looks fine in that the task can't return to user-mode,
> get_signal() will be called again exactly because ->frozen =3D=3D 1 means
> TIF_SIGPENDING. So I an not surre I understand why ptrace_signal() does
> ptrace_stop(false) with your patch. But this is minor.
>=20
> > It leads to the regression, reported by Alex Xu. Write system call
> > gets mistakenly interrupted by fake TIF_SIGPENDING, which is set
> > by recalc_sigpending_tsk() because of the set frozen bit.
>=20
> IMHO, the real problem is not that syscall was interrupted. The problem
> is that a frozen task must never start the syscall.
>=20
>=20
> -------------------------------------------------------------------------=
--
>=20
> Can't we add the unconditional leave_frozen() into ptrace_stop() for now =
?
>=20
> Sure, this is not what we want. Debugger can disturb CGRP_FROZEN.
>=20
> But. The "may_remain_frozen" argument uglifies this code too much (imo) a=
nd
> at the same time it doesn't solve the problem above: CGRP_FROZEN can be c=
leared
> "for no reason".
>=20
> Say, why ptrace_event_pid() should do leave_frozen(true) ? And if there i=
s any
> reason, then why wait_for_vfork_done() can do leave_frozen(false) ?
>=20
> Or syscall-exit path. It can't miss get_signal(), it doesn't need leave_f=
rozen().
>=20
>=20
> In short, I believe that compared to the unconditional leave_frozen() in =
ptrace_stop()
> this patch buys almost nothing, but makes the code and the whole logic mu=
ch uglier.
>=20
> Oleg.
>=20

Hi Oleg!

I agree that "may_remain_frozen" adds a lot of ugliness, so let's fix
the regression with the unconditional leave_frozen(true). The patch below.
Please, let me know if it's not what you meant.

The problem is that it makes the ptrace freezer kselftest to flap,
so it's good only as a temporarily solution. But it looks like we agree her=
e.

Thank you!


--

From 2602261b066a06f6884057d2cd7369951768b9ed Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Tue, 14 May 2019 10:13:19 -0700
Subject: [PATCH] signal: unconditionally leave the frozen state in
 ptrace_stop()

Alex Xu reported a regression in strace, caused by the introduction of
the cgroup v2 freezer. The regression can be reproduced by stracing
the following simple program:

  #include <unistd.h>

  int main() {
      write(1, "a", 1);
      return 0;
  }

An attempt to run strace ./a.out leads to the infinite loop:
  [ pre-main omitted ]
  write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
  write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
  write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
  write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
  write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
  write(1, "a", 1)                        =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
  [ repeats forever ]

The problem occurs because the traced task leaves ptrace_stop()
(and the signal handling loop) with the frozen bit set. So let's
call cgroup_leave_frozen(true) unconditionally after sleeping
in ptrace_stop().

With this patch applied, strace works as expected:
  [ pre-main omitted ]
  write(1, "a", 1)                        =3D 1
  exit_group(0)                           =3D ?
  +++ exited with 0 +++

Reported-by: Alex Xu <alex_y_xu@yahoo.ca>
Fixes: 76f969e8948d ("cgroup: cgroup v2 freezer")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 8607b11ff936..565ba14d89d5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2112,6 +2112,7 @@ static void ptrace_stop(int exit_code, int why, int c=
lear_code, kernel_siginfo_t
 		preempt_enable_no_resched();
 		cgroup_enter_frozen();
 		freezable_schedule();
+		cgroup_leave_frozen(true);
 	} else {
 		/*
 		 * By the time we got the lock, our tracer went away.
--=20
2.20.1

