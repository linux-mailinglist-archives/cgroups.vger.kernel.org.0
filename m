Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977531F912
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2019 19:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfEORDx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 May 2019 13:03:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40026 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726586AbfEORDx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 May 2019 13:03:53 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FH3UuD001893;
        Wed, 15 May 2019 10:03:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WGtrpn4uBb9EGLpZDs5HrL/cIPxjfRCnE7KbGxNLiak=;
 b=Y+QCpPqB8o6uYbnoiFJNpLpVZRkzrQ/MocuIOxzcEFyFoCfdm5a97a1NE+aYNrvrCAJB
 G7jhIhLkRTGAaEHiiJ5ADGnUO+XRd11laIyycN/QtjwPWHUQT/5S97D1ak/8hV4o3gKr
 jNAyGPgK1l14OUmWHYlZCG5QOmL/4hIk9tE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2sg4chkfku-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 May 2019 10:03:49 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 15 May 2019 10:03:47 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 15 May 2019 10:03:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGtrpn4uBb9EGLpZDs5HrL/cIPxjfRCnE7KbGxNLiak=;
 b=B71MrKUXCheweEspiBtwwaa1FZPqvcXkJfh4P4bR5ocrivkHWlu6reAyUaiAfgtRaLHWxvjOGY6LD95k6FkxRftVeuXX7wacWxwfIQakPaqZuwfP0Ykl+9cHbGNoNJEQVKWaqdqkFBsC/m69hmOUJMIWB4++lpMq5wBd5VtQhFA=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2872.namprd15.prod.outlook.com (20.178.206.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 17:03:44 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 17:03:44 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Alex Xu <alex_y_xu@yahoo.ca>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal: don't always leave task frozen after
 ptrace_stop()
Thread-Topic: [PATCH] signal: don't always leave task frozen after
 ptrace_stop()
Thread-Index: AQHVCcYNSLY5w2Qdtk+XJPFi9yaJA6ZqySyA//+nu4CAAdSygIAAJyOA
Date:   Wed, 15 May 2019 17:03:44 +0000
Message-ID: <20190515170336.GA9307@castle>
References: <20190513195517.2289671-1-guro@fb.com>
 <20190514160158.GB32459@redhat.com>
 <20190514174603.GB12629@tower.DHCP.thefacebook.com>
 <20190515144335.GC18892@redhat.com>
In-Reply-To: <20190515144335.GC18892@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0062.namprd22.prod.outlook.com
 (2603:10b6:300:12a::24) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::779]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6411c321-d095-4aa3-7bb2-08d6d95749da
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2872;
x-ms-traffictypediagnostic: BYAPR15MB2872:
x-microsoft-antispam-prvs: <BYAPR15MB28728671B2F61BB0FACB3E7DBE090@BYAPR15MB2872.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(1076003)(99286004)(4326008)(11346002)(66946007)(86362001)(76176011)(476003)(73956011)(102836004)(14454004)(52116002)(256004)(46003)(2906002)(71190400001)(66476007)(71200400001)(4744005)(64756008)(66556008)(25786009)(66446008)(5660300002)(486006)(6506007)(386003)(53936002)(6246003)(9686003)(110136005)(54906003)(186003)(446003)(6436002)(33656002)(229853002)(33716001)(316002)(6486002)(7736002)(68736007)(8676002)(81156014)(81166006)(8936002)(478600001)(305945005)(6116002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2872;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6S0uMfcBb0fcNkBzzijCYaXj0hBoQDrkPRliWbcPi//mH8XF0fgM7adLuB1bVYhKF9+y+UAnWUBriev3OnXUQKGcfLLq3ObUokVvP2WbEv4NmiRX7A6NGzmBGT8ZhADNsQwP98JaedDqCINkN1C2yyYzSJWTbV31QNWhkDGZCCCFepPYFlylxNCq0zOtKyUSvVk7rD+h1PLgxjTbU/VU06XVaP2k1RHF+aOwXCKgPhc0qw5Pas2UJwAFwg/nS1rMAcYQNZSq/dcU7q6mYPsOrkyUsCYXQXMSxzobkAQENW3azXq1QQBMvFH3g6to81fQt2EZTwKH7TENCZj68fNhUKItnlouTp5fyqXAb9w0xWWTr1syPDi23RIFDL+FPHw+DU9mFNP9vqWA/31w369z6+E8UuvIhcQXiXhL/pdIN+c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <475D50D7C649E9479D82E7B9302981FF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6411c321-d095-4aa3-7bb2-08d6d95749da
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 17:03:44.6789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2872
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=743 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150103
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 15, 2019 at 04:43:35PM +0200, Oleg Nesterov wrote:
> On 05/14, Roman Gushchin wrote:
> >
> > I agree that "may_remain_frozen" adds a lot of ugliness, so let's fix
> > the regression with the unconditional leave_frozen(true). The patch bel=
ow.
> > Please, let me know if it's not what you meant.
>=20
> Yes, thanks, this is what I meant. Feel free to add my ACK.

Thanks!

Tejun, can you, please, pull the patch?

Thank you!

Roman
