Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69EE2FBCF7
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 17:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbhASQwb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 11:52:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3724 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389525AbhASQsN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 11:48:13 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10JGXm0H006625;
        Tue, 19 Jan 2021 08:46:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=My85n9gAnslKDRKKwaErn0o9lUBJOk3+wcNS9dC0CKA=;
 b=EZ2HVGcz7tRC9Aq51cishSr5in8FOaYh14rq05LW/xVQrqGzY/KdW2DB3WzO50Iilc/H
 6K454dHU69lI/bngMFXAsBMvIgFQhriMkDD2Z1kkHJi8OPQldq5nGMdfr3snGATLgT+x
 txgU8k4u7KvabmGXqfd1DnzihVPaRoYdx+4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 363xunvgqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 Jan 2021 08:46:46 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 19 Jan 2021 08:46:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAQF2azMI8ccQAwD661ZVEl31QwWjZ7PAFHO2z3z2utUoid7uHIDqx+Ujqge8JyYQYEfFw99c1JpaXKSP3kgsxNuDKoOKY3Yexgm7DRgYtkTKDnM03Z+ewd/+OedL3zs4w2FOuO7p6vfDQoWhwhWLRiWgB1YWz8WPqPXoNJw66Nq8avlqzKuOsCjh08diOsmxvGzz7GklYrqDp3/LMN4W0M+rYLu9kQq0iGQizUOPhlO4GTofFTqjciRRRVjMTcwIDQyfWqu6Xjii0fwb3R4kscFDi95h8g7Dmbvn9lfEUJSQa/+2DnglnJ8icn7hpL8HK0hdOktKs8DVcfzDQcoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My85n9gAnslKDRKKwaErn0o9lUBJOk3+wcNS9dC0CKA=;
 b=CtVu0NsM5ShCnPD4JJ0pIkCYF6aLkKBAXTD2HhcEaGRakw/kx+pwIKoFAqa4+8GAY4w2U3+ATes1jplq32JYimaVrv7n6uKZ2oYz8UYGAJer0wc6p0rdAL18Nct6FgHNBg7uVQ51O5avKzyCX+Qi6JxetJRNHv3zy4yHyUoPfA1izmg8NvSt59FiGrDKuOYWHpmYyKexurnzIGuWNcD2epwrwTVPAOgBDzQwqfDdU0DYH2oj6aVnDw55E6Azqo7QJScchpOctnTqZi9/X2MDJQYap3Nwfte9LgHjc9kWbTiaKa1wrcd+OGToVW+vkKJDyvioFex1faeGjDUxyPusPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My85n9gAnslKDRKKwaErn0o9lUBJOk3+wcNS9dC0CKA=;
 b=BaLHQMf0zTvqEIZCW2r1nsFLRY5cJ+TlhYGBOOLwYv8WaY8zxChdE1qzbP8AVdRcciiBvQ9bR1osavPxW0wWYTvtjiafrNDwDqx5Mdfg8TyBpgMEUOvo3qE/Mut22c5qO7QwJFVHw7x2x/iLnPvJ2RYEZr8G3hGiNr/CGGAs7jo=
Received: from MN2PR15MB3293.namprd15.prod.outlook.com (2603:10b6:208:ff::16)
 by MN2PR15MB2591.namprd15.prod.outlook.com (2603:10b6:208:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Tue, 19 Jan
 2021 16:46:44 +0000
Received: from MN2PR15MB3293.namprd15.prod.outlook.com
 ([fe80::7826:ceb6:2eda:10b4]) by MN2PR15MB3293.namprd15.prod.outlook.com
 ([fe80::7826:ceb6:2eda:10b4%7]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 16:46:44 +0000
From:   Dan Schatzberg <dschatzberg@fb.com>
To:     Odin Ugedal <odin@uged.al>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>
Subject: Re: [PATCH v2 0/2] cgroup: fix psi monitor for root cgroup
Thread-Topic: [PATCH v2 0/2] cgroup: fix psi monitor for root cgroup
Thread-Index: AQHW7C5KNSuQnXXXUEuP0zOBreZ6oqovLFtd
Date:   Tue, 19 Jan 2021 16:46:44 +0000
Message-ID: <MN2PR15MB32937C185D521E6AEEFB4095D0A30@MN2PR15MB3293.namprd15.prod.outlook.com>
References: <20210116173634.1615875-1-odin@uged.al>
In-Reply-To: <20210116173634.1615875-1-odin@uged.al>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: uged.al; dkim=none (message not signed)
 header.d=none;uged.al; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c091:480::1:8ff3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe14d8c6-4bee-4204-b213-08d8bc99cdfe
x-ms-traffictypediagnostic: MN2PR15MB2591:
x-microsoft-antispam-prvs: <MN2PR15MB2591CED5BD8E4A466FE6BA10D0A30@MN2PR15MB2591.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 07MPwtEijmryOlBN2M5JqlN8DHgbskF4jAao+uVXsP8d7SGysEkRAMw+U6cp7KgcQzq2NbhkYmlAmVCAtamQov+XERfQ8j24o7+Q4tD1kQcqFvQMbgvOgAaLa2fxc2YBEgBIvGEwTZRK0vUPE3ES0J0DbtlzzNrLxNU4XHLIDVlrplZhKsrKTP9g/dmL3ecL7Rj9rDUFbFyWpTB5YTu7XJ5Xhdfv+h7DXr+AqhyBP+rYA2A//aCoeK4jh6u98pIv28G4NDBxPBQL3nqm9sj4YX5gNOUXpTCHjxqEklGg05KOFfsnN02sZBlHuTgO4RqOie9bHonZp5o3otQkKSWjV8Wq3kDv+qHHbiLbMmwUsnpVnEQQhookh1ng8okBi+KJiuodcr0jXcpzVZ5JjJzL0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3293.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(396003)(366004)(346002)(76116006)(54906003)(66476007)(55016002)(478600001)(33656002)(4326008)(64756008)(66946007)(86362001)(66446008)(66556008)(71200400001)(6916009)(8676002)(2906002)(8936002)(316002)(52536014)(6506007)(4744005)(9686003)(83380400001)(186003)(7696005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?+bO5U8paN41EzBDZ1a2yLd/pBr4iR1lZD2WYzFjSGcabpBuqhBHSj/Q8xr?=
 =?iso-8859-1?Q?sOg/JBTtZVSuRhrPevvj23dcN1pju+xVAVyr8RDWrUcBEduK/DCJrfV2wV?=
 =?iso-8859-1?Q?4UbFIMXK3MTXzNK+a/1UwamuEOhKslnDVbnPu8oFpjQuz7yxQEqMPAYktW?=
 =?iso-8859-1?Q?Pmg46+uSzmmqYkMqVxNUDIVejrv5DBGKyrUVoLsQLRf6mM82IOk3IUAQEn?=
 =?iso-8859-1?Q?co7ECUndffYZ38ymXKDhELgdvv7XzBlXUOS2OLvlH4ZLlV021XKYB6rxyL?=
 =?iso-8859-1?Q?EGcIYaOhuinVJWuNRAvGjWMpQYkRSE663wJ/D11rwMPPtTQqS4Ky3f1g2B?=
 =?iso-8859-1?Q?FjJMkT0Sn8pADau0iy6QUZ3/PAvKg8tQdhxigWCApm5QLsluEgO7f/hLCD?=
 =?iso-8859-1?Q?4BxfKE0n8lz8EzzIls1arb9jyfc3ibodAEplj7Mf+ul5BmcUECNvLuCHUG?=
 =?iso-8859-1?Q?OVMZGqUatbkNrvteQ0yk18S+Wi/i1DgmS0v4Vu4BxgnvXssnqlr/7gbaYx?=
 =?iso-8859-1?Q?/CevhLxn4xT8JpkQdaXCxzJjVHZWa95k37XQnkpbCCHyrVvVcT9+BlPhPq?=
 =?iso-8859-1?Q?jPQyzpX0FG782wVVxDkvB7eKrKnScwVP1bolFKsNG7nvQInDGjRDdID0XW?=
 =?iso-8859-1?Q?pAotmZn+1huUSdBdHjFgYQxv5dqGZwTpSFfD8DKJT+rdy04M504rjL6nFe?=
 =?iso-8859-1?Q?pQYvp8CsPXsxjh856AV2f3lMY2K5UISql6I+T9F0/AGu3wHg6YozHbd/QQ?=
 =?iso-8859-1?Q?phU42+7HfT51f9dgdy6ABWs6EnL6xTfzDbHjCyE9z7X5+88QOnhG447fHL?=
 =?iso-8859-1?Q?NHJSwcbCB8VWMQepmhL1Ql4AjUaNOZCZwKIVjlm22ROns44X0MGpbfTaVq?=
 =?iso-8859-1?Q?wC6WqphNkPSnqfW9i71pe4rbN0+ouVugfaIqTG/3FY3vWFlYsdb5XgEWBC?=
 =?iso-8859-1?Q?z/XW/x2HGFhexBynDjEbQ4/uT1KjRSQa+H/EirWQ54gKQeeznrZPYpst8q?=
 =?iso-8859-1?Q?Klyj9ZKccXs725s1ac6aiUUYlwvUZq61MJohYaoPaczG77pdpxBeoxvcgD?=
 =?iso-8859-1?Q?DQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3293.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe14d8c6-4bee-4204-b213-08d8bc99cdfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 16:46:44.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwlzHVTOsNFdve6WKHzmrAwTb7InJn3lpGhj33L+fLqM5ZpVYfHi8iwtDFzbr+ZW73v54XDilRokTBWbjc5sNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2591
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_05:2021-01-18,2021-01-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> This patchset fixes PSI monitors on the root cgroup, as they currently=0A=
> only works on the non-root cgroups. Reading works for all, since that=0A=
> was fixed when adding support for the root PSI files. It also contains=0A=
> a doc update to reflect the current implementation.=0A=
> =0A=
> Changes since v1:=0A=
>=A0- Added Reviewed-by tag on the original patch (Suren)=0A=
>=A0- Updated patch title=0A=
>=A0- Added a separate patch to update doc=0A=
>=0A=
>=0A=
> Odin Ugedal (2):=0A=
>=A0 cgroup: fix psi monitor for root cgroup=0A=
>=A0 cgroup: update PSI file description in docs=0A=
>=0A=
>=A0Documentation/admin-guide/cgroup-v2.rst | 6 +++---=0A=
>=A0kernel/cgroup/cgroup.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | 4 +++-=0A=
>=A02 files changed, 6 insertions(+), 4 deletions(-)=0A=
=0A=
Both patches look good.=0A=
=0A=
Acked-by: Dan Schatzberg <dschatzberg@fb.com>=
