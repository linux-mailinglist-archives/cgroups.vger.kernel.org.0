Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF6BB6DD2
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2019 22:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfIRUia (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Sep 2019 16:38:30 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:54832 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbfIRUia (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Sep 2019 16:38:30 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Sep 2019 16:38:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4743; q=dns/txt; s=iport;
  t=1568839108; x=1570048708;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=LxnNVUVCz0IPdS9jM9xgtwfqdBc09223wZEccBl4BYk=;
  b=aX2PJX2u23E/euJm4pJO5iE17dt2mV1SpSQ6hV/oJD9R1wPeXvIEWFZC
   Qiqae1yOzuOwId9s1o9YqY62ZjAK6C4J3Y5iD2N/DVuQ0GLbNGhkmF534
   ZDv6I67+5zAAbgDp5g0r3/2cdG81S5g29TVTkv1l0PlMLHaWsnIMbOBBf
   U=;
IronPort-PHdr: =?us-ascii?q?9a23=3AjGSm/x3z0EXg08PmsmDT+zVfbzU7u7jyIg8e44?=
 =?us-ascii?q?YmjLQLaKm44pD+JxKGt+51ggrPWoPWo7JfhuzavrqoeFRI4I3J8RVgOIdJSw?=
 =?us-ascii?q?dDjMwXmwI6B8vQEk7yNv/vZiYSF8VZX1gj9Ha+YgBY?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BIAAC1koJd/4UNJK1jAxwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVMHAQELAYFEJAUnA21WIAQLKgqHXwOEUoYomk+BLoEkA1QJAQEBDAE?=
 =?us-ascii?q?BIwoCAQGBS4J0AoMDIzQJDgIDCQEBBAEBAQIBBQRthS0MhU0WLgEBNwERARZ?=
 =?us-ascii?q?qJgEEAQ0NGoMBgWoDHQECDKVYAoE4iGGCJYF7gQIBAQWBBgEBg3sYghcDBhS?=
 =?us-ascii?q?BIAGMCBiBQD+BEUaFawKBOyhFgnaCJoxziC9elwEKgiKHBY4amSGOEIgPkHs?=
 =?us-ascii?q?CBAIEBQIOAQEFgVI4gVhwFYMnUBAUgU6BJwEIgkKKHAE2c4EpjHqBMAGBIgE?=
 =?us-ascii?q?B?=
X-IronPort-AV: E=Sophos;i="5.64,522,1559520000"; 
   d="scan'208";a="545866695"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 18 Sep 2019 20:31:21 +0000
Received: from XCH-ALN-018.cisco.com (xch-aln-018.cisco.com [173.36.7.28])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id x8IKVLBE027715
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <cgroups@vger.kernel.org>; Wed, 18 Sep 2019 20:31:22 GMT
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by XCH-ALN-018.cisco.com
 (173.36.7.28) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Sep
 2019 15:31:21 -0500
Received: from xhs-aln-002.cisco.com (173.37.135.119) by xhs-rcd-001.cisco.com
 (173.37.227.246) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Sep
 2019 15:31:20 -0500
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-002.cisco.com (173.37.135.119) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 18 Sep 2019 15:31:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRz7kpwuzrIbgDdJ5bhJuZPn48h2REMSImNyYRceRLWQz+65S8jpve7vqdRZa8/5KtaYmW8qDuVbN/+0FoEGyI4GdW4osCi/jG7zAjjX+FhbmvmkJYXyDMO0RHae/WumrYeOEFTkWEGiObgli8A04St2JAeqiBci/d7qzVvXdzWcE72cHo0FCdBeYza6rHJO0ND6jxmdLDgdepjMzErk78+gK7Ha6ZFSMihCSYFUZblRpdKSFDSeE0molWoBwRRMClz4GmzXgHgH5m+GZGm4A0nXm7OYy4sVUZ2qPgtAKUJ3LtQ5xnzz50I3wS46RTd3XHQZxiOYweDiYA2K5/whzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moEkA7k1mqq/7L8BFws/Gd/FMO/o8Xo4Sf0FoV4RrFs=;
 b=eg+nwhHtEdNFQXJ3xEC7bjoWt02bFtmItJa5Eeslmk+U2+LPuAzxc2jYV0KC3TIfVtotp+3LNH1nOV12rvl9OB7thSHXfZq6ibwxZigW7i4vaVc6GErtCmU2Tg9NDqfWmukO07n6ifZtT20aH25bCmtv1CvPPiZw3vSc42OaQBDKa8PW0/sglyNrV/9QU6a45HGEnsRDjTpUYApHfe4lA629qOgw7WnIibhZGSG3kyGua3j5zIJ2eQqh1XdhB67/5lsVfmSWSyk1cJAdIM/h5uW5KApCICDR7uPIniK9ERahjtsOt4G4GoeEMuZic89Am2u361+0PAU6DonP52DiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moEkA7k1mqq/7L8BFws/Gd/FMO/o8Xo4Sf0FoV4RrFs=;
 b=l5fpJ8+C5bcjkP0/rAsj0Eagi1DilDedjSKXsISyVJNOWu3juSXBP1TNxD7oW6IeVV0OtWzfXD7pskcvKAQwC9UaF7t/izJzRySmwdJktWv0hFapU7W3aAvJ4NRooZUvTFBlTeDeTlDqFo9A4oc8uXZYK0E59eapb4iGzkCPA6E=
Received: from BYAPR11MB2582.namprd11.prod.outlook.com (52.135.229.149) by
 BYAPR11MB3815.namprd11.prod.outlook.com (20.178.239.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 20:31:18 +0000
Received: from BYAPR11MB2582.namprd11.prod.outlook.com
 ([fe80::29b5:ea68:50:df31]) by BYAPR11MB2582.namprd11.prod.outlook.com
 ([fe80::29b5:ea68:50:df31%7]) with mapi id 15.20.2284.009; Wed, 18 Sep 2019
 20:31:18 +0000
From:   "Saeed Karimabadi (skarimab)" <skarimab@cisco.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: CGroup unused allocated slab objects will not get released 
Thread-Topic: CGroup unused allocated slab objects will not get released 
Thread-Index: AdVuYAXsyqrfLm5yRGqVq9iRkUoA5Q==
Date:   Wed, 18 Sep 2019 20:31:18 +0000
Message-ID: <BYAPR11MB2582482E28ACA901B35AF777CC8E0@BYAPR11MB2582.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skarimab@cisco.com; 
x-originating-ip: [128.107.241.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea6e79d9-1b7a-4885-6ac6-08d73c772949
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR11MB3815;
x-ms-traffictypediagnostic: BYAPR11MB3815:
x-ms-exchange-purlcount: 1
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3815426EDABDC0EDC3D65517CC8E0@BYAPR11MB3815.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(186003)(6506007)(102836004)(4743002)(86362001)(476003)(2501003)(33656002)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(8936002)(81166006)(81156014)(8676002)(3846002)(52536014)(486006)(5660300002)(316002)(2906002)(99286004)(7696005)(110136005)(6116002)(7736002)(6436002)(25786009)(256004)(478600001)(14454004)(66066001)(26005)(9686003)(966005)(74316002)(107886003)(4326008)(55016002)(6306002)(71200400001)(71190400001)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3815;H:BYAPR11MB2582.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2ZzXuo06nsr3c/9v7jTsAwFiS1AIHubofvXH5B7U7COgMSpIBgnKq4ivtNqnBPippskOD/erjFcUptn11fm/VTE4j5QQ0ghmfUBqoYyZEj0ECQiPaA1Cyyps83oxwJkb0YUYe0liNpnzb8+nj1OvEBktzEOnrKqCPtdcrhPJJdTr8IDGPczDXMCXgS1vqm9k/4hMC98hcQpGdcYP9XNPb0JSyOqro8myJwfb7XR+rwcUSOTiJOufSlwPkjSPbuDyMY0OJb1lRsh48EFV4x2BCk8bex4d2GRpqu7tb0nVoTlqyYkLM3s6H7eGzB1NNYJ7ZeILw0U4P9lootTPrBcMMewQHDxwqOmeVL+FHdV9iMxcmuGs4yrZd50YwP4SsiPjJlOVjYznATLwO793rVfiGS1slIcAd/++RK9HYnNfPOs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6e79d9-1b7a-4885-6ac6-08d73c772949
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 20:31:18.5737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byUh7KmPcGeJbzNLCT5BBMlTGey/A6veApT4G+/WnxUQLFVQC17xF/taW1YZ/96aFRTW96fopdV5nZASTEh1Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3815
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.28, xch-aln-018.cisco.com
X-Outbound-Node: alln-core-11.cisco.com
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi =A0Kernel Maintainers,

We are chasing an issue where slab allocator is not releasing task_struct s=
lab objects allocated by cgroups=20
and we are wondering if this is a known issue or an expected behavior ?
If we stress test the system and spawn multiple tasks with different cgroup=
s, number of active allocated=20
task_struct objects will increase but kernel will never release those memor=
y later on, even though if system=20
goes to the idle state with lower number of the running processes.
To test this, we have prepared a bash script that would create 1000 cgroups=
 and it will spawn 100,000 bash=20
tasks. The full script and its test result is available on github :
=A0=A0=20
https://github.com/saeedsk/slab-allocator-test

Here is a quick snapshot of the test result before and after running multip=
le concurrent tasks with different cgroups:

------------- system initial statistics -------------
Slab:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 419196 kB
SReclaimable:=A0=A0=A0=A0 123788 kB
SUnreclaim:=A0=A0=A0=A0=A0=A0 295,408 kB
# name=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <active_objs> <num_objs> <objsize> =
<objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor>=
=20
		: slabdata <active_slabs> <num_slabs> <sharedavail>
task_struct=A0=A0=A0=A0=A0=A0=A0=A0=A0 735=A0=A0=A0 990=A0=A0 5888=A0=A0=A0=
 5=A0=A0=A0 8 : tunables=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0 0 : slabdata=A0=A0=
=A0 198=A0=A0=A0 198=A0=A0=A0=A0=A0 0
Number of running processes before starting the test : 334

...... loading 100,000 time bounded tasks with 1000 mem cgroups ...........=
...=20
..... wait until are tasks are complete , normally within next 5 seconds ..=
......

------------- after tasks are loaded and completed running  -------------
Slab:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 948932 kB
SReclaimable:=A0=A0=A0=A0 125816 kB
SUnreclaim:=A0=A0=A0=A0=A0=A0 823,116 kB
# name=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <active_objs> <num_objs> <objsize> =
<objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor>=
=20
		: slabdata <active_slabs> <num_slabs> <sharedavail>
task_struct=A0=A0=A0=A0=A0=A0=A0 11404=A0 11665=A0=A0 5888=A0=A0=A0 5=A0=A0=
=A0 8 : tunables=A0=A0=A0 0=A0=A0=A0 0=A0=A0=A0 0 : slabdata=A0=A0 2333=A0=
=A0 2333=A0=A0=A0=A0=A0 0
Number of running processes when the test is completed : 334

As it is shown above, number of active task_struct slabs has been increased=
 from 736 to 11404 objects=20
during the test. System keeps 11404 task_struct objects in the idle time wh=
ere only 334 tasks is running.=20
This huge number of active task_struct slabs it is not normal and a huge fr=
action of that memory can be -
released to system memory pool. If we write to slab's shrink systf entry, t=
hen kernel will release deactivated
objects and it will free up the related memory, but it is not happening aut=
omatically by kernel as it was=20
expected.

Following line is the command that would release those zombie objects:
# for file in /sys/kernel/slab/*; do echo 1 > $file/shrink; done

We know that some of slab caches are supposed to remain allocated until sys=
tem really need that memory.=20
So in one test we tried to consume all available system memory in a hope th=
at kernel would release the above=20
Memory but it didn't happened and "out of memory killer" started killing pr=
ocesses and no memory got released=20
by kernel slab allocator.

In recent systemd releases, CGroup memory accounting has been enabled by de=
fault and systemd will=20
create multiple cgroups to run different software daemons. Although we have=
 called this test as=20
an stress test but this situation may happen in normal system boot time whe=
re systemd is trying
to load and run multiple instances of programs daemons with different cgrou=
ps.
This issue only manifest itself when cgroup are actively in use. I've confi=
rmed that this issue is present
 in Kernel V4.19.66, Kernel V5.0.0 (Ubuntu 19.04) and latest Kernel Release=
 V5.3.0.
Any comment and or hint would be greatly appreciated.
Here is some related kernel configuration while this test were done:

$ grep SLAB  .config
# CONFIG_SLAB is not set
CONFIG_SLAB_MERGE_DEFAULT=3Dy
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set

#grep SLUB  .config
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
CONFIG_SLUB=3Dy
CONFIG_SLUB_CPU_PARTIAL=3Dy
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set

$ grep KMEM  .config
CONFIG_MEMCG_KMEM=3Dy
# CONFIG_DEVKMEM is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
# CONFIG_DEBUG_KMEMLEAK is not set

Thanks,
Saeed Karimabadi
Cisco Systems Inc.



