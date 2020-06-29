Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F720D24F
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgF2SsV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:48:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56660 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgF2SsN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 14:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593456493; x=1624992493;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=HkpozrdrY8HhN/Y9QvYyoACy15PTr+1dtT06dWnk5oda/4NiX+TK3GKh
   a510LZ7zlbE7BhEi5VycnAD+humYzVm0OoSOB9eK7ew5CIw2DodpKXL1u
   OS3B5aDPbiP+Nqp3UQ+3vQRB+6nfgJCuxagHAQhvLIBMBKj786PhcnS+9
   cCNY++isfeZ1iohGxGgyzdwB8NSRz9ATVvQUdLb5UPS6Y6kyl3xQ70e86
   wD5BIfgMwFd5HtpJtkdNzp9XEPPxounWIXMcK22UvxljVGgM2qUOIKHIg
   rQ0DyM+SeHbXXGB7QjgRp2PM4MqGjhm5QUnCGe0h3OPqpdSaLjwsIb4bu
   g==;
IronPort-SDR: TaWoHCCSw8Sj2dBnnq++sA+PiI3ES4zi6OvW3asKAnPDUx3YJWmSvQfn4GKWAdHoJ7nuo9r9r8
 VNwjExQlDN3yTO7OS1Y+yjctPkZiaWYKRmHFEHG/VHWFZ0aJawqMzGXKPG2UbT7TpaBTcF42GB
 EvUnG1jhr95HBPMopy/ZBAK4ZvqYuUolh7t5Ib9ugwwC7pElR5ZCrc531pMbZclCdIRnuTN/lu
 9NPSykRPrCCrLMSMKub1VRLtHngHtcyhmvV6tYis+UsYUU142GaLnLyH9uKbd8/12duEz+6WLz
 BFk=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="141385459"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 17:59:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICOsoMW9DXXQV+XrzJzr4B59u8lYQFH1sQBk1dYUys3kCNn3dgBkt1rTI+Ozj5WkiY/ygen3Htyq2Ad3aTgVoaSEYu1I9STh1kVs1l+TVcRvZByYyctTpbZ2VTfSdRi63pZmSTcDHDX560sVhCUK8ap5yORqG3hk2QrUEmXUdU0tQgrN1T9m+3juctP+bwdiz/v/8v9PjxOKIRcQWEdFfhOm8KVQIuy6oZfP2Tcqd1cJdlRlGV16Gd1j58i2AQt7tmmPVO2dTWggQtuUw7oRfQcem57+ID/+y7FNZP++qagCBq+XXSRBzdEi9jh9kVc2btZm0YQpbicaAE1EYU64kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=n5WcWGfUCSVQ0UPsvaYxvTPXjomQFfGyz7MuY/T2AvUD0nceUEikoGwvOJAIhfPmnkAIbMdoRxo0iqBnge0Ekxm3dCqWE0Li5s6AincVbhPtBb4hjmOYY6SqOlpomTAygfUaFyPqnS5qghbeSoxMPYMOJ3CW36iiB1jQpV42jxDUWyWaS+xOpxOEZc56OU0+m3Wegfz+ROIEtKg9C9WLDSbVPxQTucjhHswchMqDFrEUkZaTw4Qh9fezSuvPmxmZTOoRSHNTxQQdkPwJXuycHiF7n/shXAUxx6GTwBrPDdAT5Ckm8/mvItk5KmUIL/gKtf62pCKAzNC1m1GNHmP5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WmsWnxIaDq3vxNzK6sQybXQMjX5iDEmnQ6lADSm7BO7wgoTAIppS/ln1x1DCLl4UZGVUu+dCTGi8EJ9isglSvZoYVeC2e/aJG1BHFkR+//HkrvC5GdMHGzkq8WfoJDigAGRcx/34APXUMU1uNxk48NJBF5DkpFnkGiq+6WixZlI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5007.namprd04.prod.outlook.com
 (2603:10b6:805:9e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 09:59:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:59:06 +0000
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
Subject: Re: [PATCH 05/14] block: move bio_associate_blkg_from_page to
 mm/page_io.c
Thread-Topic: [PATCH 05/14] block: move bio_associate_blkg_from_page to
 mm/page_io.c
Thread-Index: AQHWTFVJvbniMUYqRE62LRQB5ELYuA==
Date:   Mon, 29 Jun 2020 09:59:05 +0000
Message-ID: <SN4PR0401MB3598BAA43FFB5271003CA34B9B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200627073159.2447325-1-hch@lst.de>
 <20200627073159.2447325-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c693e8a7-c875-4b21-e8ee-08d81c130f56
x-ms-traffictypediagnostic: SN6PR04MB5007:
x-microsoft-antispam-prvs: <SN6PR04MB5007E1F86191C4018568CA5B9B6E0@SN6PR04MB5007.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4LlsQdkh11NzZg+J3vvFUPMSPkIBLi+c9zqIbZIErgDkTCYTG8EsJhDSzN0CTFmbqY5VBBJImlWfKQYM1UhNa/QWamtsr1jLkYkCThIhRUDe2iBEi19PDZ2E+xX/2H/+sanupPnzcIDZ7zyzC4Jp0/jF7RGSKfml3SFUA7kTtAMYE9Ip0HTY9ZvSiaCtCGDx/DPfpvMStAjcoc9UE6RGowlCBeUA5cfK/uvE9Au86vDgU/3KEzx7d0+2fK3avcQ4E532PkdgYARfomlG+cTl2yOk0B6j5H6yc4Vj4Pj5iinxl3/Qn5xSyDDVxvqea2sLtG1tz1MvPXrTu94gWvJQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(19618925003)(71200400001)(558084003)(33656002)(478600001)(316002)(9686003)(2906002)(52536014)(55016002)(6506007)(7696005)(91956017)(76116006)(8936002)(7416002)(4270600006)(5660300002)(8676002)(54906003)(86362001)(186003)(4326008)(66476007)(66556008)(64756008)(66946007)(66446008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HnlWYtELagfByzNfsz0LN6YKHn7C51txHWmMbC+as7COZ3Vw1r2Tc4zdenm9d8M3Adz0RxJEBl9TLh+30ye3gzY4PTAQKhM2ldxEbGGPnybhhXPzCmjXP8jKXnIJQyyAXAe9hhC7QEffl3eCmJNNDrQmiotIy+FtSJ0DHx20+utGJy0ZvOblZAd9TmNwo+JELUkxbfnZ2XV14mWiv9GKQGWtlVLev7m3319damrg1/HZCMCyJGB8QkI6Fk6hU8wmWE6cfpgbawcyLuOOnauRCL6KiNRC9oB4Dq/nn5l0vIMIGCMvq/MSBApKnMGCWWy9PHmFdEVwvHW0+3SgxSnkki40hofymO/AOf4objTE1eyov5sGUmUySPBLUFmC1wIbwxeRi6N1OXWnz23yl+S8AnoXhhpsnxWgsy3xc8TCL1UboGNtZ5QJCgBu8SHOy1fdPfJBGOdTlZlKWPOtiYglnW68bXtaR6kCV9pVS6A4aySeFxpSEj1D16Mzqnu9121CTEVvMPQlG3YA3tlggnCty8AZUw6DmzQAxSv/Bg26letxLDvAicxIDLQ6C9QERrvZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c693e8a7-c875-4b21-e8ee-08d81c130f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 09:59:05.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnv610Sogw/DLPLaxW8X7JJLewBYVzqsAwEXvwyh4wd62a+ScOq0/FjeZ1MgzEfq+jMDfdmZVeXR7b3rRTFv8moYl9x6YxFKzob/7gQPaWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5007
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
