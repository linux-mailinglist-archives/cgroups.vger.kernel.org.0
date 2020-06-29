Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB8420DD42
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgF2Sjy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:39:54 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42845 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgF2Sjb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 14:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593455971; x=1624991971;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=BUfRYnq6d2QtmnijmrdjbeUn7mcWzYHUNtrd2nnEaWTj8bPefi9mjPmW
   afJGKzWEhbIEJHPHhSxXY1iXk9C0QdkU3c26PYs/Whq5sTvUMAovmOQU6
   gxb+Amv8X0x27QELgjV+CUzJMzvWpNDSTGLlw+0EJI3mrNLjELmkFwKzP
   XCuPlVLFnbqdJAgXZrWwaf+yG0QyRPndCjstCF1wbIg9JcQUpfutZayPv
   Ri/ON7n0Mjy4aJ1y8V1T4s/D35/GYjwX+F5Kq1kFuhVFSlhVy5dEyaE/r
   36xeEhywtauCCSpGWxmAw/DlueduqkINAyJY7o2jXeiq4/1NQqghBfBmQ
   Q==;
IronPort-SDR: tAeOKkQlQ2lXTHrk/zkZK3t5fxmPuGbqgjhwweXhYkFlr4Z1jDuiOgbKc+6WXDfm7GIlLnRN1G
 A3EjvGyIoa+mbRJVk5KBLaZ7D0t87pYW9sBf9qpiPFsih2Zmuxt26UlF6ao2sPRybzSe2+vFcz
 oYGCYjzZikOc3dqBEBfXVNRqzRBPmO3XTH0OPHkIsRj8EC3GpMODqZxNUs53A9BitYsHdPdCFF
 C+NvJcGZp/ZrMhucKnOX8tTFM1kCdacx/+ZROBb+vHKOEmz4BMERAKvW+lyB92uxD/4M+9cUgu
 2dY=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="142527849"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 17:31:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN64LNqS2+onHxfglFjA8xHwJ0eoJhWf0+JIZZHRiqtN1HNxa+518GEshNot6xzDRif0bbJzDSltR1dIHEptNcVD0Zg70JD6HXZdMYdCFDFFcrDpqrpTOGgbo4z26IBjdZSRGEZ93t7It26bpDb6OBIyMxrDb+g/Vi93mlEjIvmh5q6RTp47foKTHXU3+rit6VqJhCocbOZBm9/Y+jMs18BOIAUCm11arl8SLJVuoq5RR8SqUHfb3jLAtNrYdKI2tix96jkdSvTdgbRuYvar/byhMvIPxR0E03ROMyHWTH20gCR2zopcM9570hoK298/vQKW1SByBN6CLcLsq3YIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=JrXu4FXBryRptRdqPHhOLjq+hxBQXEE/edbKmGrs5fgwRRt7EqC38f3xW7Gjrf+9iTb3soQ5/+0ujoiEhwuPUqC6Ynfno2qCkQQEC2SzP3uBAz0e2TclQYxZ/cBprvyg/LDgVD9LvylS+pMivkSIcV+D6nYeZCOW4GOaTdtCKttPoMBxYtoxjMig81cHBGzhKYItc51tRRdh3aLQJyuT370ZAKNDydS2Pp2Ig7f8Mx4TeVSpCU3jI4pVNDO7tWWwtXWxpNei5p46pA6n2SPOO1Dhj0b5e9JMILjVCR6XiSaMIGc6NiQ7sSg8FGDt+05fhZQXqMbln0ngNOfowbJjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bqAABlknO4/7Lcokr+Sb0mmDqbA0CCNA8gLwPXze+3hSd4E0tWCILXWHR+i+D0rte6oz4U5wO3LfNOh4kDla9x6qbFEvjce0vOEXsAXENyWlTyjlvW7mOK8Ddl2fOc+0LAgRqoDWj6R35m4ddcsav0bFwoZBLpQ/GR3TaC1coy0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4461.namprd04.prod.outlook.com
 (2603:10b6:805:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 09:31:48 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:31:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>
CC:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 01/14] dm: use bio_uninit instead of bio_disassociate_blkg
Thread-Topic: [PATCH 01/14] dm: use bio_uninit instead of
 bio_disassociate_blkg
Thread-Index: AQHWTFVNhEHhBYRZnECuJQ/imV0vWA==
Date:   Mon, 29 Jun 2020 09:31:48 +0000
Message-ID: <SN4PR0401MB3598E2A437BF7D2E94A1D1C29B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200627073159.2447325-1-hch@lst.de>
 <20200627073159.2447325-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcecde9b-0045-4786-4596-08d81c0f3f66
x-ms-traffictypediagnostic: SN6PR04MB4461:
x-microsoft-antispam-prvs: <SN6PR04MB4461F5165DDFE68C5AB69BCD9B6E0@SN6PR04MB4461.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TYDuIAQuhqe8397xiIBEQXtDjw/zkJbzbl0xJ86yJ4ff0RnVo4Dd5ah9Lv5qM0/OMYJCwv0gWgK9fnQOatoWNu/JVMEbJVQKo//QmZ1mNLaRjR9+kOV/z/vZH5oTzM4yDhbYYrxM92yvWYSM94pg9r0dQl2sFCHdL9RYHgFLIZJNnNqPWc+8idky+rBBy2aT98XUpoVde9SL4jCD+HmmnUMoocg1Q2bNdHDYUBsldgRL9ptaQemQwOnv3DusJYcAxTKMeBr6biCyBKtwoSoXojr5O39SfjSQvtY1lH3grmSKR40kDYR+Y5oVXw6b26QwCvtTgPB00IZ+cZql4E+2aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(316002)(9686003)(7416002)(4326008)(33656002)(5660300002)(54906003)(110136005)(4270600006)(52536014)(71200400001)(8676002)(7696005)(478600001)(55016002)(19618925003)(6506007)(186003)(76116006)(66946007)(558084003)(2906002)(64756008)(66446008)(86362001)(91956017)(66556008)(8936002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SRgU4yZreQpPfwnzKXBLkCL8ogPFvY+ZBNxfkIUcGRRhuQnXX51Ys3KbVWLyjz4GCHyB2gwXcoCmNMp2MuFFiiabw9hqAZokRuV76LEhbiH2mNdlPupaNCogq43TeK1/P1fZDPFuvrTS3Zm8hzJRRfrHPVhdz7vveRjy8j2xwHOS5doud9oXU4TyWwC0qUV3Yczty2N/0bMcviIFrtFKsQGEvXEFeD8y+hjh2BmpKFLSsudh8hCWRIcWgyaZKBIR7bX9sTsqL0TwUVlDxQN5J+VZXySSP1iT4IZemVfvbcuncOcco0p5sw/2gfBq4ThTl4xALn//13a69p/unY01CSzd7kJwHAWAV4bSdmkCEPpiHZFLJcNJlnBFqodLWL9xo2BV0mMqKVvMs4X267B4DOurHO48rl3tSZyOjcmECcyaLPWNZYytAKYklKX1IFY3iRlqGTWNTck6wnjtR3WUyyGM5KqYdo5R07fanmNH2Q1VxnFsmVR6mD4NiqXRxANS+p9l8ndB9pYs/r6Dp1NOmuZnwJ0pdLMYSe3QL/1rSG0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcecde9b-0045-4786-4596-08d81c0f3f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 09:31:48.5620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7yey5SmTbVaZpKtYpXM1BxcDEzN8AxYLOHq1IZWa5RsdPoJmn9Qv53gK8AeMHzmehrs0OfXwymk+1f7mHyRWcifwer+a4L6UZemwIBd4A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4461
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
