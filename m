Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D94C20B0D
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 17:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEPPX5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 11:23:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbfEPPX4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 11:23:56 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GFM8l3006447;
        Thu, 16 May 2019 08:22:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Azl9CH2lGbT1m0pFjAiL0R/ldo19+TYEYXkzgFU7kdo=;
 b=GY8aLKyNDPnyvLAn+xIputznqtTskbPLMoJfkF9qexHEng8H0h4sODRshCfZM9+ekW3P
 7nFqI58orV+pDzGEdBQIALr4vAJ7cpGna67hk54vCG+0CQL+rTargPK/lPr2xrbXcyoO
 wbhvyqUTT1onfiNlLsMQduBMvb2hjMZFIg0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2shaep802k-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 May 2019 08:22:45 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 May 2019 08:22:36 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 May 2019 08:22:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Azl9CH2lGbT1m0pFjAiL0R/ldo19+TYEYXkzgFU7kdo=;
 b=iITAl8NpNiPEXMyqxGNulJvk41AfjXfHEIvnJX0AOKYUa9tPCYrK3SX7AXk4uOvUS2wt31zP3A7ofBT85HTLQBPIslz2uKTZ0z1GFnSqw1UqXWPvrw4UG9fmQeJsKAzsNhq8CLUn26wQJrsTumwx/3bugU20WyTJ2Gh89HkGLig=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2199.namprd15.prod.outlook.com (52.135.196.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Thu, 16 May 2019 15:22:33 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Thu, 16 May 2019
 15:22:33 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Daniel Mack <daniel@zonque.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Pavel Hrdina <phrdina@redhat.com>
Subject: Re: [RFC] cgroup gets release after long time
Thread-Topic: [RFC] cgroup gets release after long time
Thread-Index: AQHVC9OmgOU0Jmtzzk+sDHdbgUmMIKZt3rAA
Date:   Thu, 16 May 2019 15:22:33 +0000
Message-ID: <20190516152224.GA7163@castle.DHCP.thefacebook.com>
References: <20190516103915.GB27421@krava>
In-Reply-To: <20190516103915.GB27421@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:300:117::33) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::474]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ee0d86b-3dbd-47b1-d4c4-08d6da125168
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2199;
x-ms-traffictypediagnostic: BYAPR15MB2199:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB2199215033079A0CD86E232DBE0A0@BYAPR15MB2199.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(305945005)(229853002)(316002)(6486002)(7736002)(8676002)(99286004)(54906003)(966005)(478600001)(2906002)(14454004)(68736007)(4326008)(25786009)(81156014)(6916009)(1076003)(5660300002)(86362001)(66556008)(53936002)(186003)(11346002)(6306002)(71190400001)(6512007)(8936002)(33656002)(256004)(71200400001)(6436002)(46003)(9686003)(6246003)(52116002)(66446008)(66476007)(73956011)(476003)(66946007)(102836004)(7416002)(64756008)(386003)(6506007)(76176011)(446003)(81166006)(486006)(6116002)(14444005)(5024004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2199;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l8ESdXliwUprMJVph5Az/KPFjAMzYfYCFgyszJaGF71fT4hd13Td5CLK5V8q8XqvJyjcF3WBTL4zqTcmV8Q5f5qHxwUYpj7AyQPPkB5Gq4StjwhL23+MUU1meDSbox9K0MFMhpMUVhC/6EAsK5m0HOl0GsfbFpGwKI0Q1tl6vfrFdiDm4rzB1DAXMcv1lsVIPx5jvlDZBPk0PxroIIAQoe5Wmldpch+mpcjvGmrsaPetpK6p/J9WidaoZnHHAtTuIgffKPoqa8F2ZF7y4nXZrBLoq/YohCmIs1hZW0zwPrbAp0TWWe3h4qEIr//PI6lwoI0sMsI5qow1Zw/d8Rk4iZcZX33nxWs4b3H/GJWxe0DNKZvy/a6fs7U2JqHpwsr6xtxdZclHnvNDZT7ziffWwQqgG3S9RVRV3+7kEeBjgSo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D08384E6A8EDF04F846683242B5971C1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee0d86b-3dbd-47b1-d4c4-08d6da125168
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 15:22:33.3602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2199
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160097
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> hi,
> Pavel reported an issue with bpf programs (attached to cgroup)
> not being released at the time when the cgroup is removed and
> are still visible in 'bpftool prog' list afterwards.

Hi Jiri!

Can you, please, try the patch from
https://github.com/rgushchin/linux/commit/f77afa1952d81a1afa6c4872d342bf672=
1e148e2 ?

It should solve the problem, and I'm about to post it upstream.

Thanks!

>=20
> It seems like this is not bpf specific, because I was able
> to cut the bpf code from his example and still see delayed
> release of cgroup.
>=20
> It happens only on cgroup2 fs (booted with systemd.unified_cgroup_hierarc=
hy=3D1
> kernel command line option), please check the attached program
> below and following scenario:
>=20
> TERM 1
> # gcc -o test test.c
>=20
> 			TERM 2
> 			# cd /sys/kernel/debug/tracing
> 			# echo 1 > events/cgroup/cgroup_release/enable
>=20
> TERM 1 -> create and remove cgroup1
> # ./test group1
> qemu-system-x86_64: terminating on signal 15 from pid 1775 (./test)
>=20
> 			TERM 2
> 			# cat trace_pipe
> 			<nothing>
>=20
> TERM 1 -> create and remove cgroup2
> # ./test group2
> qemu-system-x86_64: terminating on signal 15 from pid 1783 (./test)
>=20
> 			TERM 2  - group1 being released
> 			# cat trace_pipe
> 			kworker/22:2-1135  [022] ....  2947.375526: cgroup_release: root=3D0 i=
d=3D78 level=3D1 path=3D/group1
>=20
> TERM 1 -> create and remove cgroup3
> # ./test group3
> qemu-system-x86_64: terminating on signal 15 from pid 1798 (./test)
>=20
> 			TERM 2 - group2 being released
> 			# cat trace_pipe
> 			kworker/22:2-1135  [022] ....  2947.375526: cgroup_release: root=3D0 i=
d=3D78 level=3D1 path=3D/group1
> 			kworker/22:0-1787  [022] ....  2961.501261: cgroup_release: root=3D0 i=
d=3D78 level=3D1 path=3D/group2
>=20
>=20
> Looks like the previous cgroup release is triggered by creating
> another cgroup.  If I don't do anything the cgroup is released
> (tracepoint shows) in about 90 seconds.
>=20
> The cgroup_release tracepoint is triggered in css_release_work_fn,
> the same function where the cgroup_bpf_put is called, hence the
> delay in releasing of the bpf programs.
>=20
> Is this expected or somehow configurable? It's confusing seeing
> all the bpf programs from removed cgroups being around. In Pavel's
> setup it's about 100 of them.
>=20
> Note, I could reproduce this only with qemu-kvm being run in child
> process in the example below.
>=20
> thoughts? thanks,
> jirka
>=20
>=20
> ---
> #include <fcntl.h>
> #include <signal.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <unistd.h>
>=20
> #define CGROUP_PATH "/sys/fs/cgroup"
>=20
> int
> main(int argc, char **argv)
> {
> 	pid_t pid =3D -1;
> 	char path[1024];
> 	int rc;
>=20
> 	pid =3D fork();
>=20
> 	if (pid =3D=3D 0) {
> 		execl("/usr/bin/qemu-kvm",
> 		      "/usr/bin/qemu-kvm",
> 		      "-display", "none",
> 		      NULL);
> 		fprintf(stderr, "failed to start qemu process\n");
> 		_exit(-1);
> 	} else {
> 		int filefd =3D -1;
> 		char proc[1024];
>=20
> 		snprintf(path, 1024, "%s/%s", CGROUP_PATH, argv[1]);
>=20
> 		sleep(1);
>=20
> 		if (mkdir(path, 0755) < 0) {
> 			fprintf(stderr, "failed to create cgroup '%s'\n", path);
> 			return -1;
> 		}
>=20
> 		snprintf(proc, 1024, "%s/cgroup.procs", path);
>=20
> 		filefd =3D open(proc, O_WRONLY|O_TRUNC);
> 		if (filefd > 0) {
> 			dprintf(filefd, "%u", pid);
> 			close(filefd);
> 		}
>=20
> 		sleep(1);
> 	}
>=20
> 	if (pid > 0)
> 		kill(pid, SIGTERM);
> 	do {
> 		rc =3D rmdir(path);
> 	} while (rc !=3D 0);
>=20
> 	return 0;
> }
