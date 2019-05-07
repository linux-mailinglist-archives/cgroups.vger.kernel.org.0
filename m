Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6DC16D44
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2019 23:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfEGVjD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 May 2019 17:39:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbfEGVjD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 May 2019 17:39:03 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47LUXaY008536;
        Tue, 7 May 2019 14:38:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RNN4LBOFtefrvAX1xBIexBu2lvT5Ch1nLeo0DJY36Kg=;
 b=kA1mQnQbrPfn4zDn9zZa+DDZu1oidG+gVk2c8cNGAZZtH8v61FkAtxSA1SKnLBzIix7/
 vnYTr+klcVwEdyWHo5788UxOfWRrLqeqg9WN/mgz39kaSpThEHyU/C31gZHG5oZvSGlW
 SsoG2LVHjz0pPV9rXu6rl8Qv47lSOoYckTk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sb2rkkcww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 May 2019 14:38:08 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 14:38:04 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 14:38:03 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 7 May 2019 14:38:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNN4LBOFtefrvAX1xBIexBu2lvT5Ch1nLeo0DJY36Kg=;
 b=gA0dZ3TDJJlvRFHoOBGzBtyha+L5dsL3AzTK9N5PeJVc5M2BLYabUNsL99rBVr6EP7Z/jqD8BCI7txl+awd8M9guqvS0Oi21w0JEmpTNvle01O5NIbmt3i7KgjHruJ7DCwMTbWSOA3kKYYVNgK3ss4tZuj4nrgehxoAaAHwLhUU=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3461.namprd15.prod.outlook.com (20.179.59.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Tue, 7 May 2019 21:37:58 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ddd2:172e:d688:b5b7]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ddd2:172e:d688:b5b7%3]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 21:37:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Qian Cai <cai@lca.pw>
CC:     "oleg@redhat.com" <oleg@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ptrace warning due to "cgroup: get rid of
 cgroup_freezer_frozen_exit()"
Thread-Topic: ptrace warning due to "cgroup: get rid of
 cgroup_freezer_frozen_exit()"
Thread-Index: AQHVBRAdiRV9e0TuJUe+IcFJ/bKLuqZgMCKA
Date:   Tue, 7 May 2019 21:37:58 +0000
Message-ID: <20190507213752.GA24308@tower.DHCP.thefacebook.com>
References: <1557259462.6132.20.camel@lca.pw>
In-Reply-To: <1557259462.6132.20.camel@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0053.namprd14.prod.outlook.com
 (2603:10b6:300:81::15) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:e676]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fb6a2d3-28bb-41ce-b7ff-08d6d33445f1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3461;
x-ms-traffictypediagnostic: BYAPR15MB3461:
x-microsoft-antispam-prvs: <BYAPR15MB34617DE1C8140E0CBC0E6C4ABE310@BYAPR15MB3461.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(6916009)(86362001)(6506007)(46003)(68736007)(76176011)(11346002)(9686003)(4326008)(102836004)(476003)(305945005)(256004)(6436002)(6246003)(73956011)(25786009)(1076003)(66446008)(6512007)(7736002)(14444005)(446003)(66556008)(66476007)(64756008)(66946007)(71200400001)(486006)(99286004)(71190400001)(45080400002)(54906003)(478600001)(2906002)(5660300002)(8936002)(186003)(6116002)(8676002)(14454004)(53936002)(81166006)(81156014)(6486002)(33656002)(386003)(229853002)(316002)(52116002)(26583001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3461;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sAE1LUYSH5faGODH1pjq6ST5L3R0/SfRWKYHzpdXgzDFtPfzHPlq8RGzpF8sEhog6KfcMVjWTHQIDuBpbiJmDVQPvakUfLE5Gmem8lR8FR/+0AuqrpB1QS2LjAQi29koQqU1BVpv+T5yiU+avSzQ1Jfws9qDVp+n5pKepoeM3GOrmByeBsqZu3eVSlTc0VPyb+tLocbL+Zqnz34f1aXOeEkAm0RWnX9frkwRcFWImo0WNeZSqVK34dr7adsljrDEjurWdFX0GFs90HlQwKPLfZaYnwnpo3wb2A/4SNvtd2wQrfkW5DqVxrfYkRaADb+XnAo9SRvMng78kqf/bLzJsBB45zP7trSIR0TpkHlCJE58Otj42Jk+rLrwp6V3fjzG9UDDr/GL/6Wju8F19ycybGqrezIyNLjhjFZ6hHlhoQI=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9B589E8022892A4FBFD8897D5CD8C2B1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb6a2d3-28bb-41ce-b7ff-08d6d33445f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 21:37:58.7565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3461
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070134
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 07, 2019 at 04:04:22PM -0400, Qian Cai wrote:
> LTP ptrace01 test case triggers a warning below. Looks at ptrace_stop() c=
alls
> cgroup_enter_frozen() there in the cgroup v2 freezer.
>=20
> [ 8373.336330] WARNING: CPU: 56 PID: 67026 at kernel/cgroup/cgroup.c:6008
> cgroup_exit+0x2a9/0x2f0
> [ 8373.345001] Modules linked in: brd ext4 crc16 mbcache jbd2 overlay loo=
p
> nls_iso8859_1 nls_cp437 vfat fat kvm_amd kvm ses enclosure dax_pmem irqby=
pass
> dax_pmem_core efivars ip_tables x_tables xfs sd_mod smartpqi scsi_transpo=
rt_sas
> tg3 mlx5_core libphy firmware_class dm_mirror dm_region_hash dm_log dm_mo=
d
> efivarfs [last unloaded: dummy_del_mod]
> [ 8373.375561] CPU: 56 PID: 67026 Comm: ptrace01 Tainted:
> G=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0O=A0=A0=A0=A0=A0=A05.1.0-next-20190507+=
 #25
> [ 8373.384579] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen=
10,
> BIOS A40 01/25/2019
> [ 8373.393164] RIP: 0010:cgroup_exit+0x2a9/0x2f0
> [ 8373.397556] Code: 0d ff ff ff 4c 89 f7 e8 75 4b 1b 00 4c 8b ab 20 0f 0=
0 00 49
> 8d 7d 50 e8 65 4b 1b 00 49 8b 7d 50 e8 4c 56 00 00 e9 db fe ff ff <0f> 0b=
 e9 3a
> fe ff ff 48 01 f1 0f 82 3b ff ff ff 48 c7 c7 40 83 5b
> [ 8373.416443] RSP: 0018:ffff888bdc9ef9b8 EFLAGS: 00010002
> [ 8373.421709] RAX: 0000000000000000 RBX: ffff888e5cfcc040 RCX: ffffffffa=
b3a8e7d
> [ 8373.428897] RDX: 1ffff111cb9f9875 RSI: dffffc0000000000 RDI: ffff888e5=
cfcc3a8
> [ 8373.436080] RBP: ffff888bdc9efa50 R08: ffffed117b93df25 R09: ffffed117=
b93df24
> [ 8373.443266] R10: ffffed117b93df24 R11: 0000000000000003 R12: ffff888bd=
c9efa28
> [ 8373.450451] R13: ffff888f4c2346c8 R14: ffff888e5cfccf60 R15: ffff888e5=
cfccf68
> [ 8373.457637] FS:=A0=A000007ff1e2e3d5c0(0000) GS:ffff88902f800000(0000)
> knlGS:0000000000000000
> [ 8373.465781] CS:=A0=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8373.471569] CR2: 00007ff1e286fe8a CR3: 000000092c412000 CR4: 000000000=
01406a0
> [ 8373.478750] Call Trace:
> [ 8373.481219]=A0=A0? cgroup_post_fork+0x350/0x350
> [ 8373.485435]=A0=A0? fpu__drop+0x5e/0x230
> [ 8373.488951]=A0=A0? exit_thread+0x10c/0x160
> [ 8373.492736]=A0=A0do_exit+0x5cb/0x1740
> [ 8373.496083]=A0=A0? check_chain_key+0x142/0x200
> [ 8373.500210]=A0=A0? mm_update_next_owner+0x360/0x360
> [ 8373.504775]=A0=A0? map_id_up+0x14c/0x1f0
> [ 8373.508380]=A0=A0? check_chain_key+0x142/0x200
> [ 8373.512512]=A0=A0? get_signal+0x5f1/0xde0
> [ 8373.516206]=A0=A0? lock_downgrade+0x300/0x300
> [ 8373.520246]=A0=A0? lock_downgrade+0x300/0x300
> [ 8373.524287]=A0=A0do_group_exit+0x78/0x160
> [ 8373.527978]=A0=A0get_signal+0x1e8/0xde0
> [ 8373.531498]=A0=A0do_signal+0x9c/0x9d0
> [ 8373.534841]=A0=A0? check_chain_key+0x142/0x200
> [ 8373.538970]=A0=A0? setup_sigcontext+0x280/0x280
> [ 8373.543185]=A0=A0? lock_downgrade+0x300/0x300
> [ 8373.547228]=A0=A0? kill_pid_info+0x2e/0xd0
> [ 8373.551006]=A0=A0? kill_pid_info+0xa4/0xd0
> [ 8373.554788]=A0=A0? __x64_sys_kill+0x262/0x350
> [ 8373.558830]=A0=A0exit_to_usermode_loop+0x9d/0xc0
> [ 8373.563131]=A0=A0do_syscall_64+0x470/0x5d8
> [ 8373.566910]=A0=A0? syscall_return_slowpath+0xf0/0xf0
> [ 8373.571565]=A0=A0? __do_page_fault+0x44d/0x5b0
> [ 8373.575698]=A0=A0entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 8373.580789] RIP: 0033:0x7ff1e2893c3b
> [ 8373.584402] Code: Bad RIP value.
> [ 8373.587653] RSP: 002b:00007ffd8e5efe78 EFLAGS: 00000206 ORIG_RAX:
> 000000000000003e
> [ 8373.595276] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007ff1e=
2893c3b
> [ 8373.602461] RDX: 0000000000000000 RSI: 000000000000000c RDI: 000000000=
00105d2
> [ 8373.609642] RBP: 0000000000000000 R08: 00000000ffffffff R09: 00007ff1e=
2e3d5c0
> [ 8373.616824] R10: fffffffffffff768 R11: 0000000000000206 R12: 00007ffd8=
e5efe98
> [ 8373.624005] R13: 00007ffd8e5f00c0 R14: 0000000000000000 R15: 000000000=
0000000
> [ 8373.631190] ---[ end trace a7169f3366f1d100 ]---

Hello, Qian!

Thank you for the report!

Can you, please, try if the following patch fixes the problem?

Thank you!

Roman

--

diff --git a/kernel/signal.c b/kernel/signal.c
index 16b72f4f14df..bf2f268f1386 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2484,9 +2484,6 @@ bool get_signal(struct ksignal *ksig)
                sigdelset(&current->pending.signal, SIGKILL);
                recalc_sigpending();
                current->jobctl &=3D ~JOBCTL_TRAP_FREEZE;
-               spin_unlock_irq(&sighand->siglock);
-               if (unlikely(cgroup_task_frozen(current)))
-                       cgroup_leave_frozen(true);
                goto fatal;
        }
=20
@@ -2608,8 +2605,10 @@ bool get_signal(struct ksignal *ksig)
                        continue;
                }
=20
-               spin_unlock_irq(&sighand->siglock);
        fatal:
+               spin_unlock_irq(&sighand->siglock);
+               if (unlikely(cgroup_task_frozen(current)))
+                       cgroup_leave_frozen(true);
=20
                /*
                 * Anything else is fatal, maybe with a core dump.
