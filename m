Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF191298EF
	for <lists+cgroups@lfdr.de>; Mon, 23 Dec 2019 17:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLWQxQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Dec 2019 11:53:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50452 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfLWQxP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Dec 2019 11:53:15 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNGqTHI004547;
        Mon, 23 Dec 2019 08:53:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=T+kbjh6xeyy+Crl7Knla8mWgd3Mb9hGkERGIxPeqK6I=;
 b=bRTXFm700qt+DDi9tLXYhafg+V8PZEVm0dKeeh/Sd+p0yGIP21mE93DLJ/IwH1dY6bp7
 tveqYKder4inrF625hht2LJe7zU7DInxv9Cbi5vYDrJeQm33mCXhBn1elyd9hS8V1eMr
 90eNlcKrlwss+2K7xDfI0ei1UnbUkCzWT2c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2x2410d2p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Dec 2019 08:53:02 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 23 Dec 2019 08:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmrrC1dfnVc5H0IS5k+8i3AhHYEdOKeUanScZF46pgUPRNsgVAdR4YMrkAqXHHmAGiSBQU0W9PlTLRacxpfRyQ5P1o3thvlFe7s+RwTLlZejejcBIzjNpU3BOzaKXKZbd9BQxLvwSvGbPCJOpAxRdHEwr6hbId4xg6x1nPFE01oLTIvJIFQrxd1bMynfSn+6lydaA2w8XynAulxFU2ujPKrPbTcjW1WeSsLupHctqL31oRIAyBi9dIlNnCUAlK6tWWgGIzqTLionAvEPxFAO0tW/tBupUx8yi+4Uw/+HZdiblgCEadrewAz2/kXIG7W8JDHNG72gDXqqF9yKU+shMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+kbjh6xeyy+Crl7Knla8mWgd3Mb9hGkERGIxPeqK6I=;
 b=eQp5LQZUaQ5H0N5UgPSH4ibY54QcTSS0j+7PqdByr0E6C3ZmcKaO780MgQlGCZmZdrXSg/dItPH9He6YY/JVzGa8EM+OSz3fj4o1uhn1n+EGQDIL7SYXsyUG5E5m1Z4ZBBB+puKe0HTsZHo0VwPERj3IFpnKj/pHnB0HKGRXihpHZLHS0ccOKSjrgpJSpjpbKqtpFgTNNEn8th7czA+n/VBebzrGuDbPFIaJbjwYA/TDMHk6RYE+2I7/RPERV1l/nINJ2gky/5q+RjDoTqZdxTL85oMMbQcQCVWLkGy/9zlNoU56Zk4CuHLvdW24hoGVJnCmj0A6ixRsFHGMD1k1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+kbjh6xeyy+Crl7Knla8mWgd3Mb9hGkERGIxPeqK6I=;
 b=LUXYcgOmBn11gf9y50xhdRBSh5Y1N2sbR5WGmh+EnfRXjFOQI5JAj+0XOFU8gsGPz8gWPFU8YcPKzJ4helT33mlQ2rLesDwNZtkwSq0s6ztTsI4pGKouDr5w+w+S9ef/aAx7rhHSZthONM0IpClWUoKv+yjdtzckhyc19iAd6sM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2773.namprd15.prod.outlook.com (20.179.155.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Mon, 23 Dec 2019 16:52:59 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8cc8:bdb1:a9c7:7f60%3]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 16:52:59 +0000
Received: from localhost.localdomain (2620:10d:c090:180::2b12) by CO2PR04CA0176.namprd04.prod.outlook.com (2603:10b6:104:4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15 via Frontend Transport; Mon, 23 Dec 2019 16:52:58 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Xu Yu <xuyu@linux.alibaba.com>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm, memcg: fix comment error about memory.low usage
Thread-Topic: [PATCH] mm, memcg: fix comment error about memory.low usage
Thread-Index: AQHVuW72rRuWvr8dd0ev0KoK/2c/uqfH7/gA
Date:   Mon, 23 Dec 2019 16:52:59 +0000
Message-ID: <20191223165254.GA17129@localhost.localdomain>
References: <0505ec19cc077cf32d7175ffea121e2130c64590.1577090923.git.xuyu@linux.alibaba.com>
In-Reply-To: <0505ec19cc077cf32d7175ffea121e2130c64590.1577090923.git.xuyu@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:104:4::30) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::2b12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06cd798c-cf11-4ebf-dd07-08d787c890d2
x-ms-traffictypediagnostic: BYAPR15MB2773:
x-microsoft-antispam-prvs: <BYAPR15MB27730A2861F2CEF795FFDF89BE2E0@BYAPR15MB2773.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(2906002)(8936002)(33656002)(55016002)(186003)(6506007)(16526019)(86362001)(52116002)(1076003)(7696005)(6916009)(4744005)(81166006)(81156014)(8676002)(9686003)(316002)(5660300002)(66476007)(54906003)(71200400001)(64756008)(66556008)(69590400006)(478600001)(4326008)(66446008)(966005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2773;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eEOnawo1f4FTcQ62UciyKPgGcYOT68H3IKk38GeOAt+YzGwdjd2832dWf/VCt0MAkdCJCzdQFZPqxdV+FUo0OttCAhEEw9kXrPXgmqiaVusjqz0FuGedr6lhdwxBn+uv3WkB7mJ9ln38Rnb5Rn/wxOoZv9ZcUsFHKMSDa4PTqDLycMhMN8o0T6mJEUHnaOz1oE0uOHWTKlR37HhiA3woWDPnl4tjKUZ72K3/Bl4kdb6Gh6KVX7cqna6EOpw4xMT6kos1eWcXFe3qzLALOKZRkXZgzhq7QPsdYFxNKJUshWf+5bVRpczZ7m1I2ZEQxHfGMZ5OVfgpiRgTmB9utBzOCFKbVuEPHL07TeXoKgjtpgULHwO11G6TXaaRqt1JLcjIk+ZmjKDtkg4s6YROF7sPLTxkmeA6Xgiy9U5fL8uoiDvK6WxSE20XGk1NsYxozPZ5aXRFhX2DXHxKvqnbbaTFEvPIMKUypgPjl3++yM7X/naAT7fdhLKx7JPTQQpPAD297506ZxIZSvjIS2S1mSyitElGxT2xYSLlzWYLy8KSCt4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E053D7BA3F92E4F8A0553272D245D1E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cd798c-cf11-4ebf-dd07-08d787c890d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 16:52:59.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FZuPQz+wUWPJ5ZuHCRYpW9PDoZnczBA28P9qi0NmQJuIv7ytpeJ92PsYmd7GI+U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2773
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_07:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 phishscore=0
 mlxlogscore=627 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912230143
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 23, 2019 at 04:56:56PM +0800, Xu Yu wrote:
> When memory.current > memory.low, the usage of memory.low should be the
> value of memory.low, not 0.
>=20
> Fix and simplify the equation in comments.

Hello, Xu!

There is a pending patchset from Johannes, which performs a significant rew=
ork
of this code: https://lkml.org/lkml/2019/12/19/1272 .

Please, take a look.

Thanks!
