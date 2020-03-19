Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF218BED3
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2020 18:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCSR5m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Mar 2020 13:57:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:62746 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727009AbgCSR5m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Mar 2020 13:57:42 -0400
X-Greylist: delayed 1101 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 13:57:42 EDT
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JH8IDV028878;
        Thu, 19 Mar 2020 10:38:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=95/m89MwlSGPpZAOIrtExHR4t9kE7xbWEJqvlYC0Qho=;
 b=rv/e7p3y0sBAg/PYaEpFZ6sWIIOfIl9urt4AmZS+74xb+kq58VFJLCAhdGGGVG8vgoOb
 /YAZR3vd0ChPvIdMboVKBQt8TwKv2llCvMZ8cMXhgtX0e5PMjhmZV5IqZtmMlDftDxdm
 tcDu0BIXt++sKDoqLxoqOCdzJD96MEPXCK0J3qqL+TAOnNXSpM503/ltvnitfyLZXzNa
 gvz4v9tcgH4OgYIw2EydJOr//WqgwqFUctp9xj/nUE5ddwLGPgEfb5udaeFr8yXC1oux
 D/boKrofDl/kP79so6EBGqb1FPjFFhX+yvS5S7rLprj1iiFEJbLEPvIl2NaLMZcs4Nj7 eg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2yu93tcn7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 10:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJoPCU5ihZaxXQ0yhabW+cfESMjS+qtiGcUV8yWvKlEnXafBILjxSXHIuJ4prfKZkXL2VZuFxuFLLjAOi7gpMdGQTXF4WfrRWPgnDeQ1IwTZMbE/8RV9c9iO7ZOGUHlhmy9WUl7iGiN3hLaXC334wTUPgZD7xjtiKncraZ/kOTQn2JUsw3uOXDfjIwI6iYvB/R2UsM3OrOFWAF6ekoZs24P95sDH2W50T5OivuFeBtC8RYj8CJ2Pxff9ZXni9H772BnViRhbrEE0pArn3VuHchZHtYsf1APUa5ja8n2hiBWng2b18A2j5E9Y1ps9twDOkynpxcH8iy1Gsm4UgVtG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95/m89MwlSGPpZAOIrtExHR4t9kE7xbWEJqvlYC0Qho=;
 b=msV3eKGPb1fkmp5bGZ8zq//Lqr33KMvLUgNESHsRLPMAj+VgxrsNZBSAPJAXAuU6r1o53eSF0vzuc9y31oMBCs2HjyMH8nBiJD9TfNfXgxGKAxg7l5FGzoCZXoScHV72bQYqI5H3t+8R+OKo3BHtyn0lZAqH3DihkeC4nkCMJ6OcIHP3w4+56NkdgRDzHFZCOiJlv5f6gqRawYM53cjNi96ensj7g81/WoyJBp57P2LMhBsV09ElltaEulazqc3ypWA/+TxK0ApJ64biIQrtECrf+mpoeWjG89r5Zc+TOaHcGIqjV39vaiJEOHGdawn40F8AfEEW2V6EjfrtG2qdVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB5601.namprd02.prod.outlook.com (2603:10b6:208:88::10)
 by BL0PR02MB4337.namprd02.prod.outlook.com (2603:10b6:208:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19; Thu, 19 Mar
 2020 17:38:30 +0000
Received: from BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c]) by BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c%6]) with mapi id 15.20.2814.025; Thu, 19 Mar 2020
 17:38:30 +0000
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
CC:     "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "guro@fb.com" <guro@fb.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "chris@chrisdown.name" <chris@chrisdown.name>,
        "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "ziqian.lzq@antfin.com" <ziqian.lzq@antfin.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jonathan Davies <jond@nutanix.com>
Subject: [RFC] memcg: fix default behaviour of non-overridden memcg.swappiness
Thread-Topic: [RFC] memcg: fix default behaviour of non-overridden
 memcg.swappiness
Thread-Index: AdX+Dc7TuUU65jcsTmmN9pfGvp9AeQ==
Date:   Thu, 19 Mar 2020 17:38:30 +0000
Message-ID: <BL0PR02MB560170CD4D4245D4B89BC22EE9F40@BL0PR02MB5601.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.125.170.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e31a03f-97db-4f03-7ef9-08d7cc2c571b
x-ms-traffictypediagnostic: BL0PR02MB4337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR02MB4337331CC2DC3799579026C1E9F40@BL0PR02MB4337.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(4326008)(66946007)(5660300002)(26005)(76116006)(109986005)(52536014)(2906002)(64756008)(55016002)(66476007)(81156014)(66556008)(71200400001)(81166006)(186003)(54906003)(7696005)(9686003)(66446008)(6506007)(33656002)(107886003)(8936002)(478600001)(966005)(8676002)(44832011)(316002)(7416002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB4337;H:BL0PR02MB5601.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L1k5n0a8Uw/I+1DdOlGIyVbC7V/H8+BsWFAYCFI6J5mxf2TsVQQ76mJRpXgd/Isu3rYPHmUeOVaL/bacz/z2S0Er7252jicROpQGxGzlgYkaUxJOhGB+QDrkYmPVp5m7zHzvXMK6kZnJR6spmW2OIKuAWT9MMnDurjO62dKXQ/NZg0+zjd0Qu2bz/yDe0ASruoMg0x6TBS5E64hoD1o3Ea+uO1C1wvPkMKLMdbtlDcPN3wOWfnQoed0sK5ytEjl4fh4H4wgECmLNipGafwz59zMPsyzRxjWaRuR3B2R8wdzGQrVlr84Kqy6SR5KSDsCv8pxov7bCJ04nhxUMKoGLnj4FraYxDq38L+k/fTCpUon7tkNph0eSYKO0S1q6gFAuOhHG90zsCFmL7LDbHT6bTO+0ZZ4RhaF2XJJycEWdqYDZTq73JFQnN3J77f9+M+6cZ/prJNIGfNroURfL3paVH2HsRWd33Xw+3z1hQdCXmhHr6nhbW2fZp5klZYrFqcrsch4cCyenUkbn+RTA/J8AeA==
x-ms-exchange-antispam-messagedata: N0qakj4z4Gv9KkFzVx6S5pen1DjJZAzLkjosmjeUG7tMUyyezndFNRIUINdvGnJ+itFGoS2OXuRU1+sGpBKPWBm4EWBbcoi7g7LlD9BpuZCvMKRQ7Z8piYKW5YTLcIVh7BKteWxF+tGHH1VI8Rh+BA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e31a03f-97db-4f03-7ef9-08d7cc2c571b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 17:38:30.6522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFvKisq+1YKw77aoOEXhFqh9O03u7l3ZOhWyQ9u9ktuanF+Cwr5c7JrCRY574uCk8SiX97UYMASECsJyCu/g5AYxK6IwCiQXif6mP8ClFXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4337
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_06:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Reason: safe
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch tries to resolve uncertainty around the memcg.swappiness when
it's not overridden by the user: shall there be the latest vm_swappiness
or the value captured at the moment when the cgroup was created?

I'm sitting on the fence with regards to this patch because cgroup v1 is
considered legacy nowadays and the semantics of "swappiness" is already
overwhelmed. However, the patch might be considered as a "fix" because
looking at the documentation [1] one might have the impression that it's
the latest /proc/sys/vm/swappiness value that should be found in the
memcg.swappiness unless it's overridden or inherited from a cgroup where
it was overridden when the given cgroup was created.

Also, shall this magic -1 be exposed to the user? I think it's a "no",
but what if the user wants to un-override the memcg.swappiness...

What do you reckon?

[1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v1/memory.htm=
l#swappiness

-------------------------------- %< --------------------------------

This patch makes the memcg with the non-overridden swappiness
use the latest value found in /proc/sys/vm/swappiness instead
of one captured at the time when the memcg was created.

Signed-off-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |  7 +++++--
 include/linux/memcontrol.h                     | 15 +++++++++++++++
 include/linux/swap.h                           |  4 ++++
 mm/memcontrol.c                                |  4 +++-
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation=
/admin-guide/cgroup-v1/memory.rst
index 0ae4f564c2d6..ccb4046c0aa3 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -610,8 +610,11 @@ Note:
 5.3 swappiness
 --------------
=20
-Overrides /proc/sys/vm/swappiness for the particular group. The tunable
-in the root cgroup corresponds to the global swappiness setting.
+Overrides /proc/sys/vm/swappiness for the particular cgroup. The overridde=
n
+memory.swappiness in the non-root cgroup is inherited by new child cgroups=
.
+The tunable in the root cgroup corresponds to the global swappiness settin=
g;
+changes made there are also applied to the non-overridden memory.swappines=
s
+of the non-root cgroups.
=20
 Please note that unlike during the global reclaim, limit reclaim
 enforces that 0 swappiness really prevents from any swapping even if
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5c8d5..b5d69648be88 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -240,7 +240,22 @@ struct mem_cgroup {
 	bool		oom_lock;
 	int		under_oom;
=20
+	/*
+	 * Overrides the global vm_swappiness, unless there's a special case:
+	 *
+	 * - The swappiness in the root cgroup always corresponds to the global
+	 *   vm_swappiness and the value below is ignored.
+	 *
+	 * - The default value -1 means the cgroup uses the global
+	 *   vm_swappiness.
+	 *
+	 * - The value 0 prevents any swapping in the cgroup.
+	 *
+	 * Otherwise, any integer from 1 to 100 overrides the vm_swappiness
+	 * and is inherited by new child cgroups.
+	 */
 	int	swappiness;
+
 	/* OOM-Killer disable */
 	int		oom_kill_disable;
=20
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1e99f7ac1d7e..d4c65ebcae61 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -636,6 +636,10 @@ static inline int mem_cgroup_swappiness(struct mem_cgr=
oup *memcg)
 	if (mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
 		return vm_swappiness;
=20
+	/* Not overridden? */
+	if (memcg->swappiness =3D=3D -1)
+		return vm_swappiness;
+
 	return memcg->swappiness;
 }
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2058b8da18db..a95a7df46442 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4980,8 +4980,10 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *par=
ent_css)
 	memcg->high =3D PAGE_COUNTER_MAX;
 	memcg->soft_limit =3D PAGE_COUNTER_MAX;
 	if (parent) {
-		memcg->swappiness =3D mem_cgroup_swappiness(parent);
+		memcg->swappiness =3D parent->swappiness;
 		memcg->oom_kill_disable =3D parent->oom_kill_disable;
+	} else {
+		memcg->swappiness =3D -1;
 	}
 	if (parent && parent->use_hierarchy) {
 		memcg->use_hierarchy =3D true;
--=20
2.25.0

