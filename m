Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3050020D30A
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 21:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgF2SzN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:55:13 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57277 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbgF2SzC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 14:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593456903; x=1624992903;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=PUzrMPCvQRgKFPptoGH1iHwrWY4W0MKUEl4I50pJ6RSnYF/Hg36sFsn3
   m3ThVZZHikKTi2Egq8mzNUgC43gUujZ4Ub1eLc+7hcnsRc64dzB+ORlLw
   odJEQfQ1OBFhvv+ddbj8OFT+yqhhzCCfVm2jwdVOj8trIF7Z3CuV81/fi
   yN+rI5IraYGCr7cl+w1VU9m18ACRLV/ye+l9tcjBjiV5O3M30WKAuc3gW
   EpkPA3pHE4Kuo+5T9glzJtsQcgDwcJltfEPupbQiq8ziJ7pUHSYNyikse
   odje5wOYwgmhmPIOAfHCt2B1m2XszmuP8dVOu8j1DzAknjbL+f/lAUmQn
   A==;
IronPort-SDR: KhXGgmHMMb9SG+CtFZQqtGZAxoYN9wrpDFS/2sJYGbEoL6tvuMqS+bdTm5I1ky2XohrMBGpnTy
 CshMSQjiqIJzk5nvZZ031DdGewwyFkQNNv9DxrSWgp79XaqNKGh5EgCaih0O/A3RxMP97drznJ
 KIeghhPAFzB6NBUu8MV0GrroWdXC2l2mV8wwQLsQ4+OooGQbx9Y/8RW2/AAfWFv1i0Lq8r0vwO
 4+AcnTT1kFf5fJKwDDUg4Wz066L3bj2HaowxH8Ek1qJXDTNp9kyMbga4J/+IJ1zV4DYqYk5khq
 Cug=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="244196826"
Received: from mail-bn3nam04lp2057.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.57])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 19:52:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeRxOost6a/NHDB7o56bl1df/Zv6JHcM9C0Na8qOgLGs5ssrPp2az0zqDxxhMidDSBFtyTxD8x8gXCybU6MG9SwB/VreUJ4LvCETVcxuSxb4E7u8fJdG9dHgH/TyD1Trr+evTTiOw1/aygV+i/7u7A3rtHxgYbGsB7dX7aQDw1vmEW7bTpOfz0q97kFnAas3USi0X9T4JP0UgiZBYrKwggmtw5+kJvO7f5aCihmORiFAxJ1P0BKHs1cIiVEpUHWR7v4j4AOZZpikIGJ4Pvlqm1aECe8Kx0mxbNax/XtuhsMa7WEmhMrC8xg+ePGGEKHLATTYk8bI3Q3/B1kipOkakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZzdpcuBTlzrG6QAQClmf8Rur3gc3YK3ZlYzCfWftUUY/pzQfj7fnwl9KlY+6Rm6bfYFUrNCnIZqdC/+e6vT7s01unwHn8OH0+5osxF7eKWiquplJaF6EPtKE2oTVXA0c25HSuSUp8fUT02pyeTLjC6lKJYCfTqkegv89L3ScekYU/EuKKhbF/f7OWoGFfExK7ZqhyRRldL9hjdbkIBAwyYZsc3Jzvve3Y1kaciu+Zgbd0PIstJsa382rzRViMInD08oiJYjM/qljXxPyrcavHmuM3cEac5ZkXoWRaVv3MhrpZwKS65UwdLnk2tH4G6FXoA7eTHcLPrBeCWW2OACj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ahuB1EArBr0OakjXg/kmgKkHlShI6WADXeGdzgxl/Bc9y5KRLRFuKPFECh5H71wrjcFgq6ZQhg9SxncVhJSGGUsZbuZCHNPLWHA/gJ0NU18gnrMiPZPIQcb7ZxAbrvO0Gtxx2B1UhhY2rJGbspbqyhkHgP4ozlB8qPezIpkP4oU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2141.namprd04.prod.outlook.com
 (2603:10b6:804:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 11:51:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 11:51:53 +0000
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
Subject: Re: [PATCH 06/14] block: move the bio cgroup associatation helpers to
 blk-cgroup.c
Thread-Topic: [PATCH 06/14] block: move the bio cgroup associatation helpers
 to blk-cgroup.c
Thread-Index: AQHWTFUu08pVkN1Cw0KGAMSZ5Pm71w==
Date:   Mon, 29 Jun 2020 11:51:53 +0000
Message-ID: <SN4PR0401MB3598CB2CD25407E4E2C036299B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200627073159.2447325-1-hch@lst.de>
 <20200627073159.2447325-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ae21004-5992-4af0-edbe-08d81c22d108
x-ms-traffictypediagnostic: SN2PR04MB2141:
x-microsoft-antispam-prvs: <SN2PR04MB2141FB87E3D46E1561FDC7D89B6E0@SN2PR04MB2141.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 69At67BcIfvYdTKT0TLkseflVB2srWWRyGF+x2DVR09iqaX8hzsn6oXipDu2dZj4B9bNZFPTfwmn9yLdASzLiDtLcN7BAhiYIWZejcBJIexjYUp0nFO9cM1bo3DTuz2Zf19ZnEtwf70pvkvtiLsTdzGVWBls0UZnlm82qEyn+Lvs3zLf0oHe2wOpZotvIDMHzIY5o7lgdJiSjJ4JtsSZgTtWQtpTmq7D4mZqCjkRoZdkFaF011QH/0wfc/LboAUy5pi9KN7xVMnzit1OznPC63qBG8CSydIW3v/S4AGRonft2mw+WeSQFSJEuHL6TAZVJTF+lnF8zqEEYaHPAHuHhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(2906002)(55016002)(8676002)(9686003)(4270600006)(478600001)(7416002)(52536014)(33656002)(86362001)(5660300002)(71200400001)(186003)(6506007)(316002)(8936002)(66946007)(76116006)(66446008)(558084003)(91956017)(19618925003)(7696005)(66556008)(64756008)(4326008)(66476007)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RGPjjeMEQ3C3Wu/hVRjcsUVGvY8r1u3Zd8G4YTEsD5HNhDvqZFgkVnHp3q0rcXKpgaO0mwPRu2LRI4SNTCP/2F0XBl3VzX1arPyTc7wYFKAygNVcWoP2l3r6vRDzzygdIU1pn+yRq4hTmwrcPNa04g2Ty1yXU7aV5LBhnXZu8oy8Hv3W6AXolXmDhjlNdYuCnibChKTOIPBC5fnAGW0juI835vEkSnlfYmGgvKVIZCJ5KwZTSW2ODuUQCox81o1wJ1xkWJFTPCh1Ry3cSMP7yxlxW1FefSENvA7+YXdvzPA0BEOYhjRI1uVuC1AsNniWCpLzZE/pAINXohE8kJqFwoygOiMV5La0wEjAq4ORdAgYWikNza1cgDvqQrmWaXCRZ3Nlp/D9E2qs7+zGjUX1gXdR11ZNCTfPSWMCIrJO3MxzZmd0YrmLjMsrvc/xRFmG1SHizqrZ5+T5hy1u5sXf8VCRd1I1Eru5P2GCgkLddYnj27owP7e74fj27ddmiHY4GSgo12db35dZTGBS8BkEMZL7uDt02aNxwoDchlaxYYOulq5ylLD3U/mLrD1xPxB0
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae21004-5992-4af0-edbe-08d81c22d108
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 11:51:53.3005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1bvhzTli5C8EXlrDuPw7lYmef1F1zxqjOuLwDzWBqoWpsemymXP6oUBUAq87Ul9Ylzj6Hb0GpVALLm0oE7aPvNChpyybnwIjORJ9Eknwvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2141
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
