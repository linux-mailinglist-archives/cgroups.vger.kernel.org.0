Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314A02D137
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 23:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfE1VxC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 17:53:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49488 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727693AbfE1VxC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 17:53:02 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SLmQJs030310;
        Tue, 28 May 2019 14:52:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2csGm4rlE1Qqi8mXN7Sub2LV7EaIFkK5VMSLrb4jJfc=;
 b=NNmN7x5ePH9+/3PEx9NOhAzPIONn2jMLy72MnqV3NMqQG2JCOFXP+LrtkJuaIZ06nOYA
 fiYdtDRgkV9lpDBsV786Vg6CF1k56vbOKfst9gVSUnhU5+4RDLyKzxLOPQSc1Rb7gMV3
 Ot9qtYNwLfSfsg4DcWfmaPS+3hIPzkZ3PmQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ssac0gprg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 14:52:46 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 28 May 2019 14:52:45 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 28 May 2019 14:52:45 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 28 May 2019 14:52:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2csGm4rlE1Qqi8mXN7Sub2LV7EaIFkK5VMSLrb4jJfc=;
 b=XP/g4gO8xI9CM1osd4/iJcff8D0lgbK1r468C0Ks1SQjacsbtWvenwrKEUMS9XuftI4d1DGlZa2NVcxnu9R+E0tVMEe6WsFZpUgsHKB+9A+INQFYRI3mCUzpD2GmA04kWPF8TmILV6JbJLarRrhMzhaF4K9Hr6iql8avcUa8Kzc=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2984.namprd15.prod.outlook.com (20.178.237.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.16; Tue, 28 May 2019 21:52:42 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 21:52:42 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "Waiman Long" <longman@redhat.com>
Subject: Re: [PATCH v5 6/7] mm: reparent slab memory on cgroup removal
Thread-Topic: [PATCH v5 6/7] mm: reparent slab memory on cgroup removal
Thread-Index: AQHVEBPW5GLT+zCswEKkIpLsH/n20qaA52gA//+icQCAAHjxAIAAHGSA
Date:   Tue, 28 May 2019 21:52:42 +0000
Message-ID: <20190528215238.GD27847@tower.DHCP.thefacebook.com>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-7-guro@fb.com>
 <20190528183302.zv75bsxxblc6v4dt@esperanza>
 <20190528195808.GA27847@tower.DHCP.thefacebook.com>
 <20190528201102.63t6rtsrpq7yac44@esperanza>
In-Reply-To: <20190528201102.63t6rtsrpq7yac44@esperanza>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:300:ee::30) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:3dca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6202f04-bd74-4df8-b3df-08d6e3b6cf92
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2984;
x-ms-traffictypediagnostic: BYAPR15MB2984:
x-microsoft-antispam-prvs: <BYAPR15MB2984262F4AA2CD7361FC87C2BE1E0@BYAPR15MB2984.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(39860400002)(346002)(396003)(51444003)(199004)(189003)(4326008)(478600001)(256004)(5660300002)(6486002)(81166006)(102836004)(71190400001)(8676002)(14454004)(33656002)(6436002)(1076003)(71200400001)(99286004)(53936002)(4744005)(7416002)(54906003)(8936002)(73956011)(305945005)(186003)(7736002)(52116002)(86362001)(81156014)(316002)(46003)(11346002)(446003)(6246003)(6506007)(386003)(476003)(486006)(6916009)(25786009)(9686003)(6512007)(66446008)(76176011)(64756008)(68736007)(66946007)(66476007)(66556008)(229853002)(6116002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2984;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gGHMnNEuXWxVn/RzxruLLfC4cx9UiOwNWZ0wD86SDoXjAdFFPqECBgz36oDqq0Tp0g448PYfaykzkP69pK/l0gXNDu1UyunBfNP2JbTfPo6A/sF9GeLq6Wv+EsTAv7DwRaFzJo/a53ltUe0HOvdmuf4FN9ukgOo034aC5hy087Nxg4xlJFOllAPusM12sk394fjgog3lizuzCgLsT3BoyFUvWR38mLhK1aeqBeqV5qLsFDlhpzpx18sYIPRZ3k7U7SxdREQX1keB5/HigNJJdOggTs1GXvGuHBFmI7zpVyvOB81mucuDjbPda4ROtw2vqGo0sEFv4f+5Ku0yfgQbJ6Lx/54NRtHHf0IiStu4Cu4jLLAcSXlka5QBeeKumgbEd9+9jgDMa9T0bW7BsG56hqya7oJMWBjLMPIYvUCitvc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79BD7F195AE57C48A44E1FC6FE044ED0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d6202f04-bd74-4df8-b3df-08d6e3b6cf92
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 21:52:42.8043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2984
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280136
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 28, 2019 at 11:11:02PM +0300, Vladimir Davydov wrote:
> On Tue, May 28, 2019 at 07:58:17PM +0000, Roman Gushchin wrote:
> > It looks like outstanding questions are:
> > 1) synchronization around the dying flag
> > 2) removing CONFIG_SLOB in 2/7
> > 3) early sysfs_slab_remove()
> > 4) mem_cgroup_from_kmem in 7/7
> >=20
> > Please, let me know if I missed anything.
>=20
> Also, I think that it might be possible to get rid of RCU call in kmem
> cache destructor, because the cgroup subsystem already handles it and
> we could probably piggyback - see my comment to 5/7. Not sure if it's
> really necessary, since we already have RCU in SLUB, but worth looking
> into, I guess, as it might simplify the code a bit.

Added to the list. Thank you!
