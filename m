Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C890E20D54
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfEPQsT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 12:48:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49864 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728671AbfEPQsS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 12:48:18 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GGiEAh001856;
        Thu, 16 May 2019 09:46:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=meyixBdJT5sbOY7q/JV/C8tS201nko8sLpewEA+zInM=;
 b=n+h/INa/nn2wbOiGFZ+YBGB6xvLYWt0VrnSUF+F6u8kssKke1gdptfs9L7F9rrI4UX0A
 RQ496XY525zkA47EDH11/Xc6kOWAdFhWZoipzR1s3/V4HEBomUrfbdoQFLHV8w2rB+Wu
 vTrgtMunNYI4YbQ/KG02eJlCNGZkB+TKrTI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2shb4pr46t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 16 May 2019 09:46:45 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 16 May 2019 09:46:44 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 16 May 2019 09:46:43 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 16 May 2019 09:46:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meyixBdJT5sbOY7q/JV/C8tS201nko8sLpewEA+zInM=;
 b=EqLqrWlWW4I/ZBV/mAYF8bM5BAqwcsN48BH4LI3xDx+/7YP1J6+HhwfJ7BuKPdMtr50CrkUushflSXU7vI0ifLAfbNI4qLrh23O4FGikEz7XZtcmw2oOzZvC2E3R47c0ctErC3TI6kZWaPyKd+DEJkS6Zsg/byiLvz1ETRkzdIY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2791.namprd15.prod.outlook.com (20.179.158.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Thu, 16 May 2019 16:46:41 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Thu, 16 May 2019
 16:46:41 +0000
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
Thread-Index: AQHVC9OmgOU0Jmtzzk+sDHdbgUmMIKZtaVaAgAB2cQCAABZsgA==
Date:   Thu, 16 May 2019 16:46:41 +0000
Message-ID: <20190516164634.GA23922@tower.DHCP.thefacebook.com>
References: <20190516103915.GB27421@krava>
 <20190516152224.GA7163@castle.DHCP.thefacebook.com>
 <20190516152622.GA20592@krava>
In-Reply-To: <20190516152622.GA20592@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0001.prod.exchangelabs.com (2603:10b6:a02:80::14)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:138e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79496a72-4ee1-4f7e-7ace-08d6da1e1243
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2791;
x-ms-traffictypediagnostic: BYAPR15MB2791:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB27919DF5BBB6635D4280137CBE0A0@BYAPR15MB2791.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(396003)(136003)(189003)(199004)(4744005)(71190400001)(7736002)(81156014)(4326008)(14454004)(966005)(5660300002)(1076003)(6506007)(256004)(305945005)(5024004)(6116002)(81166006)(102836004)(386003)(8936002)(76176011)(86362001)(71200400001)(6246003)(478600001)(8676002)(52116002)(25786009)(66946007)(316002)(9686003)(99286004)(2906002)(6306002)(6916009)(6512007)(446003)(486006)(6486002)(54906003)(33656002)(11346002)(73956011)(66446008)(64756008)(66556008)(66476007)(53936002)(186003)(229853002)(6436002)(476003)(7416002)(68736007)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2791;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W3WX+ILAECbLkreBnsRxmUfHBFq2FRKLUx0463sEgaU3C+3mbWO1VILQf7ktaaAmUrwZAzDmGo923jZObLh5pZ6dzIL01XcQSTUT6ju6hyINTA0s4UTkDtMTx0BsS4EUS7vz0ZGVk+JD5QyLhN5mzLXJDa1nQH76HcwDaMHMsE8aAzR6XSACjylxZTrtWBrnb1uo4gZ4OJ72jMaV1PWnMbz0PWRqvfMktUHKGxiCFbeET6e4SAHQL1p/6X86EmsfaqZqWs60a/B5qj6awWoePSpXGLJaBrvD74WzlrYUO7kNIixpRdEPGQheAmSmSAneRSi29W65ANbcEQjkUuixrCcjUA4HwWgzqosEW0z8dRtwGDRUlJ0UvqIAO9R/ehX1xoY3ot0d28b7jGPbg5YzyOgFZuVCpmVA/M203gWbSuM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E70596A10248F34D91DEF79064EDE240@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 79496a72-4ee1-4f7e-7ace-08d6da1e1243
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 16:46:41.2428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2791
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 05:26:22PM +0200, Jiri Olsa wrote:
> On Thu, May 16, 2019 at 03:22:33PM +0000, Roman Gushchin wrote:
> > On Thu, May 16, 2019 at 12:39:15PM +0200, Jiri Olsa wrote:
> > > hi,
> > > Pavel reported an issue with bpf programs (attached to cgroup)
> > > not being released at the time when the cgroup is removed and
> > > are still visible in 'bpftool prog' list afterwards.
> >=20
> > Hi Jiri!
> >=20
> > Can you, please, try the patch from
> > https://github.com/rgushchin/linux/commit/f77afa1952d81a1afa6c4872d342b=
f6721e148e2 ?
> >=20
> > It should solve the problem, and I'm about to post it upstream.
>=20
> awesome, could you please cc me on the post?

Sure.

Thanks!
