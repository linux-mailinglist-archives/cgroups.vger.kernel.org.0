Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8A4B5753
	for <lists+cgroups@lfdr.de>; Tue, 17 Sep 2019 23:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfIQVEz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Sep 2019 17:04:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27289 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfIQVEz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Sep 2019 17:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568754295; x=1600290295;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5L/3zDrhBByJdOrBbw28FOeLuhv56OkWr9EyUtoofrc=;
  b=f9apoqKocv6c7IQk9DYAylRWv5slcxrFMM8f3hMblQ5egMjU+JixiW9F
   QG5wPWciRVF+eeb/7HnwR53Xdyxv2FI6ytW7h4KttMbJuGjjy9OJs4y3F
   zwcHw8T1yQZY3/gGUJBJucqTYNrH9nXvZSnz9DWX18ko/K3+xznA/cFeh
   gckxkvqlodE0lMHDs5zOctbX3wPMhYRgtWgm1M0SDuGnsXLexufoYJgQX
   U+zL+UTuxkYEUrsBIBtHJhPATu+YOU0asl8nt6QSqK2mptWhY2F85+epQ
   BYhEteH5216X45+lMIFhcEPiyV5t53XCPzkEeNFghbhk7bz97N8XIIg7C
   g==;
IronPort-SDR: lpxfY41ubL+3slR6P2Hx3oJEMxLvz1NpcUhDKgwagz2u0ic/zLQ90QtJGi8b6XElGMy74S2kEd
 v5eTQLJo5d28l8Lag5Zph//vaue5R+c1le7eHysWAJl2T9yv0tOr9HgQxXdzSGq5At/0qL1UnI
 Kln9kVjOiWbB1t7hZJXfzd8iAkG2oe81MydKZtVd4e7fkool9oa5xKbb4NiMtKFrbLvn6Vekkc
 4LShTlIxChzOCd7Gm72qwPzoOF4p+/bw8nAja824h5c41tpXQx7svEOJ9INIzrjoc6w5o+ZNNQ
 pm8=
X-IronPort-AV: E=Sophos;i="5.64,518,1559491200"; 
   d="scan'208";a="118474731"
Received: from mail-co1nam05lp2059.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.59])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2019 05:04:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWn4YlT77SxabL8ft0q+vTld2fGNkiiI4f1qYMHBGr2equBIvg9bIAZcMMfM46WCHWN/AS7Wb7/N5HJA3SIB4nd+XQRmvUbIy29VwECPrkL5m7iBLtk2bODwDv+adUyUYCY9At5JhlBK5+cAv/e3GtUHLY5bcGAC9pmq7BSrjVRX1xh7K3hgnOR6MR8sEVzxMuYtfUUycSaGNllXhEhy/f7lCcQXtCn7WqSvpZxef0dFq9WXWgc8lKEQ+aA+yQxh/RwfRJJYLazUM/YiBm62uLfRGFE/okQcX4xkerr5M4EazSAHKXdOeEPQYT9rXVJIWDuLRszA9qv4DgbQcbW75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L/3zDrhBByJdOrBbw28FOeLuhv56OkWr9EyUtoofrc=;
 b=MaLdvJE5Bk4+gDvqsOXQLvchyxQLjyxc3R+pQ8xx8oyMU8oLWT58v6SLitXc3XLUer/SD7toKm8vkHK7ll6EqulD8f2IxznRn25+e7Jy5lJKyMp+NS4u3+8BYT67bG11ytz9LGnoZqXIyMH0I/gmEvpgh0x7UyoXep4otcp07KbZMxaMMWjjJS/MN9BmfktMiLXrRKsSN5FG8I40SSuBbRKea6o8ngBwiUnpqMv1+5Nizrbm495AE+lms3jH55eXSEwO3ewaJwwYNWewOwLipndDwvB67hjbsVKWyfFjIW6s01ZUoKKBFdpegF5dds2PtwfI3Wfn/X2six71L6jDfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L/3zDrhBByJdOrBbw28FOeLuhv56OkWr9EyUtoofrc=;
 b=R7HwcDApQ6GY/xk7MdMBs/opg4kGGXrspxCiIXLtj+p+LE4qDbrEO0nmOno0w6iqOpGggZEayJSIfUMnrbcwz7TLmKdadKYDCdt6sfUL+nlkZGqibzP3bZkbUXzS8vD8aCliBs3+KMVr9/xmBLJGaS1PbrDI6ltuTr82+iY6Aqs=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB6216.namprd04.prod.outlook.com (20.178.234.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 17 Sep 2019 21:04:52 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 21:04:52 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Angelo Ruocco <angeloruocco90@gmail.com>
Subject: Re: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup filenames
Thread-Topic: [PATCH 2/2] block, bfq: delete "bfq" prefix from cgroup
 filenames
Thread-Index: AQHVbXhIRDo8O6UH10S3vPo5mDVXLQ==
Date:   Tue, 17 Sep 2019 21:04:52 +0000
Message-ID: <BYAPR04MB57492FC0194EFB7506147533868F0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190917165148.19146-1-paolo.valente@linaro.org>
 <20190917165148.19146-3-paolo.valente@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d20145ee-48e7-4755-cffd-08d73bb2af34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6216;
x-ms-traffictypediagnostic: BYAPR04MB6216:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB6216933DE6886986199B743E868F0@BYAPR04MB6216.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(66946007)(186003)(66556008)(76116006)(66476007)(26005)(6506007)(25786009)(102836004)(66066001)(74316002)(99286004)(486006)(476003)(6436002)(229853002)(7696005)(478600001)(6246003)(33656002)(9686003)(64756008)(7416002)(446003)(4326008)(6306002)(55016002)(76176011)(66446008)(8676002)(81166006)(81156014)(8936002)(110136005)(256004)(3846002)(6116002)(71200400001)(86362001)(7736002)(2906002)(53546011)(54906003)(14454004)(52536014)(71190400001)(316002)(5660300002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6216;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EECgID9fFL4aqcMASpNR4T+wgpiWBb1q9OMkBuEEambn63C5rJPzLld0oKn9Mb6rbnSHAvOTBr/G9YpVDHFR3ZZKm4qKQ0NP7TBBjOVZt9tP3f2tmuZT+ZPjDhuW+S1T4CQiIWHDiykL/uzlpdDSUwuWI6DQnELQyBSHCH2Chl77j0xZXfV30RvGJ0XswuQFFO0fGjcd+iaM/TkruW+72JtEmpDS6STKNKL/cg2o05ZsQtGOHfImvIQ5yAtuKBeoibwfdjfL3qMMndROtjK2fkuctggWCsxxZZOCKWNE8dEChm4x/hutIYpsu5KLLmu/5M+QDNmQ5Qoj8g/zuoOJVVkMPa4fUSsHb/eAu9jBGJOt6Nfi+T2vwoodS1ZgCLi1buYf97GfakxVgR8zOe/ALM10XuSyLMfUSpju94jHbYo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20145ee-48e7-4755-cffd-08d73bb2af34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 21:04:52.4126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRMCC33MjTh3mmGZZS+9dh7tcD6rthzRhjJzp/CfM1/iFLe18ylbbHygWDIKVB6AYDT+czGVyQWpncSlVkgjQGj5jT0D02G5lQwvy441M+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6216
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
On 09/17/2019 09:52 AM, Paolo Valente wrote:=0A=
> From: Angelo Ruocco<angeloruocco90@gmail.com>=0A=
>=0A=
> When bfq was merged into mainline, there were two I/O schedulers that=0A=
> implemented the proportional-share policy: bfq for blk-mq and cfq for=0A=
> legacy blk. bfq's interface files in the blkio/io controller have the=0A=
> same names as cfq. But the cgroups interface doesn't allow two=0A=
> entities to use the same name for their files, so for bfq we had to=0A=
> prepend the "bfq" prefix to each of its files. However no legacy code=0A=
> uses these modified file names. This naming also causes confusion, as,=0A=
> e.g., in [1].=0A=
>=0A=
> Now cfq has gone with legacy blk, so there is no need any longer for=0A=
> these prefixes in (the never used) bfq names. In view of this fact, this=
=0A=
> commit removes these prefixes, thereby enabling legacy code to truly=0A=
> use the proportional share policy in blk-mq.=0A=
>=0A=
> [1]https://github.com/systemd/systemd/issues/7057=0A=
>=0A=
> Signed-off-by: Angelo Ruocco<angeloruocco90@gmail.com>=0A=
> Signed-off-by: Paolo Valente<paolo.valente@linaro.org>=0A=
=0A=
