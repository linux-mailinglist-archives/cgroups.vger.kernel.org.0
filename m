Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7912210B
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2019 03:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfERA77 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 20:59:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726200AbfERA77 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 May 2019 20:59:59 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4I0xOOg008031;
        Fri, 17 May 2019 17:59:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7qKsPldQKiOqJbT53B5lYvQu0Xny2wWC1bg1lwvSMV8=;
 b=bL0Fp2IGZVpRpN+z+SEaYK1ZNTKQ+3piBoXDKKa7LmBwXpuSFVwHr80Tu/3vHZ0TrG+l
 +5jy4zy/BuKY+EhamjEcTW6KTbin/K4JHkyPiQZrI6VCPsFggbUXjN96lINoM9+hiniC
 1Fcak6ezMO7lfzWRHtmarfH83dwaKSloEqc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2sj7ggg22d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 17:59:47 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 17 May 2019 17:59:46 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 17 May 2019 17:59:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qKsPldQKiOqJbT53B5lYvQu0Xny2wWC1bg1lwvSMV8=;
 b=EQBUwShtpY7RYKBOdCLPE58QQ/OmVEj7witCilVlDuuT7K4Ehy+j1Zy5zbEMfnQgNcGkNWmGpBbWylmYW+YtSHapMPxlt12Wpj9Kq/Zwj+TOSqeCyzVetBUz0jn0zVGAHkX007eYR9poZtG+isrHYIMlzWUbs6M+4HDGS/udKo0=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2805.namprd15.prod.outlook.com (20.179.158.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Sat, 18 May 2019 00:59:30 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1900.010; Sat, 18 May 2019
 00:59:30 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm, memcg: introduce memory.events.local
Thread-Topic: [PATCH v2] mm, memcg: introduce memory.events.local
Thread-Index: AQHVDQ9AIsql3vtrqUugyovKoP5pDaZwD8OA
Date:   Sat, 18 May 2019 00:59:30 +0000
Message-ID: <20190518005927.GB3431@tower.DHCP.thefacebook.com>
References: <20190518001818.193336-1-shakeelb@google.com>
In-Reply-To: <20190518001818.193336-1-shakeelb@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:d7d0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a97bfa3b-793f-4a1c-6b53-08d6db2c1558
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2805;
x-ms-traffictypediagnostic: BYAPR15MB2805:
x-microsoft-antispam-prvs: <BYAPR15MB280518E3FFFE3988BAEAD750BE040@BYAPR15MB2805.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0041D46242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39850400004)(346002)(54534003)(199004)(189003)(81156014)(81166006)(8676002)(99286004)(73956011)(186003)(6506007)(6116002)(386003)(68736007)(25786009)(5660300002)(478600001)(229853002)(316002)(54906003)(66446008)(2906002)(64756008)(9686003)(6512007)(4326008)(66556008)(14454004)(6246003)(66946007)(86362001)(8936002)(66476007)(102836004)(486006)(6436002)(71190400001)(71200400001)(53936002)(52116002)(76176011)(7736002)(305945005)(33656002)(476003)(14444005)(256004)(1076003)(6486002)(6916009)(46003)(446003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2805;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LDwaK9woaUlRqTZsOGjUGOI0aw8usd5G8QK5aYNipcJqTCtEJB1FDTzyEhf4dx+LnWpeUKuXc0tSeTH1vv5LYaS54pss1F9DOKREBDEPXCd1os0ir/0sW6udIRIUJBk+qMwsgtNlyYh1QGofUNy9ZQRj0HRm6vW5/rIMQhQKP9bAEIZo3IZcey3xgMO+eNyg1Oe94hxUTT6CNESxnpwHfb6EoOeY+E1/iRyG4OXkOGek1l65FmZaBM+7I3tZagEwA1ZK5Ih8eCDeCb9tX/TQ1Adc+pUu+cXCCnF+6UfY5H2a53G6m151gkONCqHWfWXntr6+X1EstI0xtRwyprk9eQlmcdVX4kdsZg98EU7HEfm1dgj3a/i/Ek1KvbXtdXm8EBYoTzzvet5cUVPs5QuyPppovFRHnuYTueO14hxSyf0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4C49EE3FF59984090F0BB32EF187949@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a97bfa3b-793f-4a1c-6b53-08d6db2c1558
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2019 00:59:30.5192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2805
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-17_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 17, 2019 at 05:18:18PM -0700, Shakeel Butt wrote:
> The memory controller in cgroup v2 exposes memory.events file for each
> memcg which shows the number of times events like low, high, max, oom
> and oom_kill have happened for the whole tree rooted at that memcg.
> Users can also poll or register notification to monitor the changes in
> that file. Any event at any level of the tree rooted at memcg will
> notify all the listeners along the path till root_mem_cgroup. There are
> existing users which depend on this behavior.
>=20
> However there are users which are only interested in the events
> happening at a specific level of the memcg tree and not in the events in
> the underlying tree rooted at that memcg. One such use-case is a
> centralized resource monitor which can dynamically adjust the limits of
> the jobs running on a system. The jobs can create their sub-hierarchy
> for their own sub-tasks. The centralized monitor is only interested in
> the events at the top level memcgs of the jobs as it can then act and
> adjust the limits of the jobs. Using the current memory.events for such
> centralized monitor is very inconvenient. The monitor will keep
> receiving events which it is not interested and to find if the received
> event is interesting, it has to read memory.event files of the next
> level and compare it with the top level one. So, let's introduce
> memory.events.local to the memcg which shows and notify for the events
> at the memcg level.
>=20
> Now, does memory.stat and memory.pressure need their local versions.
> IMHO no due to the no internal process contraint of the cgroup v2. The
> memory.stat file of the top level memcg of a job shows the stats and
> vmevents of the whole tree. The local stats or vmevents of the top level
> memcg will only change if there is a process running in that memcg but
> v2 does not allow that. Similarly for memory.pressure there will not be
> any process in the internal nodes and thus no chance of local pressure.
>=20
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> Changelog since v1:
> - refactor memory_events_show to share between events and events.local

Reviewed-by: Roman Gushchin <guro@fb.com>

You also need to add some stuff into cgroup v2 documentation.

Thanks!
