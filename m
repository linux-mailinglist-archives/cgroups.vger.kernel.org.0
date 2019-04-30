Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985FFF90C
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2019 14:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfD3MjM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Apr 2019 08:39:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43010 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728137AbfD3MjJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Apr 2019 08:39:09 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3UCX5An017094;
        Tue, 30 Apr 2019 05:38:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WNYThkU1o6AKntKyZZHwm2Y4MxPJJoBEpIAuv8a9shU=;
 b=bs2pziZbNhviHljxbQKkCyR0SHwm3sfTb6euxKNgaVAwhIVevhAbaJoB8gEgzkxF9MpU
 DK/Y1GKRqTrKb2wvFZxcAuykzVbiBQTJ0GQOCVAoO4SDTg8hjwtCxK/69dBReuTxUGt8
 SnlVbGCzOn4Io9Y1H6i4jjbE9e9mlikN6Do= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s6pffg0dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 30 Apr 2019 05:38:20 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 30 Apr 2019 05:38:19 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 30 Apr 2019 05:38:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNYThkU1o6AKntKyZZHwm2Y4MxPJJoBEpIAuv8a9shU=;
 b=SasgdPpMDdMz2smVXkPXbhH5DhiM3LYKiJQrERtOnhPw0J7cxY5z+qZrSrBMsB/Osuxti83u3KlQcYhKbxcIaPNmYuFK3aECckU2vPQM1903GZDUoxgsS9J+GS5ud9Y0Vq7Bv/Aes51ZTaAFaFjhMmYzbmkRu2ikvIwQNMyS+Vo=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3174.namprd15.prod.outlook.com (20.179.56.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 30 Apr 2019 12:37:58 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1835.010; Tue, 30 Apr 2019
 12:37:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -next] cgroup: Remove unused cgrp variable
Thread-Topic: [PATCH -next] cgroup: Remove unused cgrp variable
Thread-Index: AQHU/ztY6K6bxp4Ah06bYKBqj+CtdaZUpJiA
Date:   Tue, 30 Apr 2019 12:37:58 +0000
Message-ID: <20190430123749.GA6300@castle.DHCP.thefacebook.com>
References: <1556618249-56304-1-git-send-email-zhangshaokun@hisilicon.com>
In-Reply-To: <1556618249-56304-1-git-send-email-zhangshaokun@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1001CA0029.namprd10.prod.outlook.com
 (2603:10b6:405:28::42) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::39a4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 436aba67-77c7-4704-a6b7-08d6cd68acab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3174;
x-ms-traffictypediagnostic: BYAPR15MB3174:
x-microsoft-antispam-prvs: <BYAPR15MB31744DD996A7A1E8B169AC0BBE3A0@BYAPR15MB3174.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(396003)(366004)(346002)(189003)(199004)(476003)(6486002)(33656002)(68736007)(386003)(305945005)(486006)(6506007)(99286004)(46003)(8676002)(2906002)(6436002)(8936002)(81156014)(81166006)(6116002)(4744005)(229853002)(52116002)(76176011)(97736004)(11346002)(446003)(6916009)(1076003)(256004)(25786009)(14444005)(86362001)(64756008)(66446008)(66556008)(66476007)(66946007)(73956011)(4326008)(9686003)(6512007)(53936002)(186003)(102836004)(478600001)(6246003)(7736002)(5660300002)(316002)(71190400001)(71200400001)(54906003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3174;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V3o6rqVVQaiE71Ly2s6sOgfaxTwhm4grA9s3Cnxte0IrGOiFvHEPJKswYSiovfvGOtpUV9vNGSeRplDzwIkPX9tqqTDk91XOlqA5fxZh2Qd6OMxF9LB3pIvYA5a3aucbbybGyGrHagTK72cebJocdTkiGuZP/M+xG1/ZwFCF4FJz3O3Ykx8YzYCtUxXGYix1UpGZ9xy3KC2kWcixyT0kDVl6Q9YiXahVgYLWjYUxR69t8RQlDxKqXHuqknDsmXrh5zxKI6+Qp9tjXIcQ57cOQsU5Ru8xvSQvhqdx/TBjfkJ4hF8hf+CXbWJR2RR0lXzCCL+bDfpIi6fH56pBYkoUZbl6jIcOab/LKCZipCjmWtZfzKCTszMTqnT27hOShCBt39+ZMBzZkoOgPu27H6IFCceK1Sr4NFvtoLKOfSRwVSE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F99C6B93E88E37408CFFAEF76F6AF53D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 436aba67-77c7-4704-a6b7-08d6cd68acab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 12:37:58.0369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3174
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 30, 2019 at 05:57:29PM +0800, Shaokun Zhang wrote:
> The 'cgrp' is set but not used in commit <76f969e8948d8>
> ("cgroup: cgroup v2 freezer").
> Remove it to avoid [-Wunused-but-set-variable] warning.
>=20
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Hi Shaokun!

There is a cgroup_update_frozen(cgrp) call just below,
so the variable is in use.

Thanks!
