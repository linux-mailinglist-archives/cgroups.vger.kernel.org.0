Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2FE20D532
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 21:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbgF2TPg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 15:15:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8610 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbgF2TP0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 15:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593458125; x=1624994125;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ys1E1iNEH+s9I1xO50TimGpjtogkatztTVv/Jem6Dc8=;
  b=jc0SCair4xwLIna6A0f5chV2tBe1Vjasw5aVQm+JxUoa04H7IS2djltI
   R6qdMcpd3WpkzsPROWVFFkCcQuHOpf9kQlewLnHFgGaOWBoNgfbYmW7dx
   /tVkgjsGoel7k2hGtWwdNPn7K8AeyyKLuab4lc1OS9mNSugjNIVuYUbTx
   F7FEWG6upsqaR2Rm4sr9w6DdqBnfAjUjVmSToMnhPhRvtdZQuJDGOfrB2
   jE5OShs9z/NyAD7Rf5upitxDhMQLkUNj/SlEpDY6U9BpIVyszNboWgOp0
   AB+aTKWsgUfvGgjycCAvqoUqLwhO/6w7WVrgA50EMDhbjMq4sWbT01Yzz
   w==;
IronPort-SDR: 0UGPOV2dK3CbSP6xn/1y6/akdyB8d2z+Kw4QG3rmQfnDvOCL4fgGIN01EfdG73nck/neYVS2FD
 dK/IWub0HkrtXq8XngpP2zZie+SUnbhphCzUPWCdsjdByHlYdXP7Mz4whUIr9510xBD0J25oRq
 qmNx71zrv78vl/4O7lIelK82F8DWhy7LrmPMrg63dbagR3/+d6X8yzLEw3+Qff8jeRNdUlkZ+H
 1Xj66Qh2Lm8qb5VjCjMWth6Mf2PI17EFo/x1l2QwCOpO+x5Y7UdnteIt34hOmztdgs9fT+kiVr
 iDo=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="145495340"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 18:08:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgLIUVuVv0e/aSXoH0IpR/mBPhjAySvHC6GnpSF9w61Nj2YjNVsSMfFvtb4cTlmw92W0IJos/o87BzQIWCvhgSUUalmJ7XtZULzWkfOapYR42T8nYk4ZuWQCBBnTV6ZGYn2g686VRdMlCcClA5ZxiSCC7SBJl45uxiuWR+gnq7KBUROMwvKt1CalluMeorwc3r+7hu+Uqq7IEwrrlpaPXuXvOcLE1iJfKdVwZZbIbkGY7KOv3pLkwBYs6oTO+UgX1mLTMhpVyWx+EqOkthrj8azeszu1cYUd5ctKXPOBY/uDpoIJQtLnBYKFZMhafQYJJ0CLjkrc8QKltSb0q6/Tqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys1E1iNEH+s9I1xO50TimGpjtogkatztTVv/Jem6Dc8=;
 b=HIycddnu7WCyVMbLIJqsE5AJzglrPTV2Mz/FMGh1Mt7H7mkxhWW30peAq28EpMpvZDJ7o5xMkal1WpCn26TBNanGFdx2ztQ16R9gMhWhnE4/ntPVRdmt5vOxsG+u2R9CeCcX3ATeDNJuMwQzTapjezlhMRC9nFa5e5lWKx0Osd1Qv8n/uUExgPuqz4l3K5Xi9I2FS+O675cYApJuXNYR7m9zhFUB17snNu+OKw0keS0WUJCyq0PXvzqV4CoPz2p2J8sBu73UQ9llDZjAMe//uMIvqQlrCBctaK4GmcVhKewKDTnIOZE85T2Q2tIyTbLv34optcwKvplxPRTcVIEkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys1E1iNEH+s9I1xO50TimGpjtogkatztTVv/Jem6Dc8=;
 b=XwIcg7UOmYRHljTqa3zyXhouAfYaPeUdqCgsBFX+6a4z/UAEcsRZPtdKmCUH4EQe+woqn9x9UlqLxDiIPGFjQnNdnhBlIgodHv/MyY1wQtGGP7ZSf1vs+baokbTOxiCcAXWJEPsSGCFZSUecutBqVN04DF5VbQKIAxpsF57wtyg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3600.namprd04.prod.outlook.com
 (2603:10b6:803:46::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 10:08:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 10:08:28 +0000
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
Date:   Mon, 29 Jun 2020 10:08:28 +0000
Message-ID: <SN4PR0401MB3598A350166C7B419FA8853F9B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: cc4d6c6b-c75e-471d-f869-08d81c145e90
x-ms-traffictypediagnostic: SN4PR0401MB3600:
x-microsoft-antispam-prvs: <SN4PR0401MB360012D1892D43F1FB1FE8DA9B6E0@SN4PR0401MB3600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLykQdwmCmQ+hRPvhHzV7ITBWV08ZjvCIvOfJZrm44aoMv1o97XZXQluqlClsWotI5DJDd8b2TTFHSQr6KyBCkDoIxS+9v1behyw5m52bRxcLy6d5Oxctgk1jyOfJRtVttVpPoe6X2huJzNMkZyfsizy7Hv6+bxFkA3WhPnwoGrjN9QsQtypdZ/5SH+Z1KnisOvSBB4w5yjucVZataOKAE91X+Mu5Z1+aa3CdQJVU7R/a1a/gjOfi8YDCF0iPRw624qJQUDoKEjB/lwbgxETY65fvfqJbzJOSurtp3yVqLaqWLxE4FYlvI7nNswqVSRq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(55016002)(54906003)(110136005)(316002)(558084003)(4326008)(7696005)(9686003)(53546011)(6506007)(186003)(71200400001)(66556008)(66476007)(64756008)(7416002)(2906002)(5660300002)(52536014)(76116006)(8676002)(8936002)(66446008)(66946007)(478600001)(91956017)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kFztssL6AgodECkMisBYuW5IwRli1aZAKYwXmYD38tUu9C5pyRR1bPeTgkZwezqQqrZIdKXS/gY0KyjixIKowdbCiz75AbX9JFPdMCJnZ9uxqMtliojEez0tBaBWuTVX7ypvpc69Uk0KLoJCa/qODQ7PcDLZBKgag+MTDG1NnEYlMLmaWN7ZpHMdmDZkrDDSSQZuzyLW90r5dO8J9+ktuwKdyJ3ajJrrPoXOu1QK0jsjOowrYtHlRlYw47csJj2sJ6TG8ZBIh04YFc4uqyTgLjmc75oAmqy92VxIsIOXRhZdbck2JR121tbVXk6Cb+Ht8nQHXOhlLINJ9ng+nOAiDRb2oLmjDBvEOSMtpsBjkmvn18/NpRnDnimMFMT1PVDBeH6cIWrWxKSfRXDcp2yb+O4Z4Jw6q69PnmiyDkq1S9KYFyJlbXjyb9ObCwcB+lmXSDWCWGsFY9/8fg9EM5/Ya3tjFmzxDAi/qQyAkrP0vaYUo4XvkDjPX2jq0V4DLrThGW42bA6xdVNnyaVMu53VvUkrX4b7G059vIFqqJBugu1moI2CGlC2mWGO859iDezg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4d6c6b-c75e-471d-f869-08d81c145e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 10:08:28.2858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VAqoNFuK7vz70iEfCoIGcF1+Ha6HDxfv/ZdiQGnWHVgV8qnKFkqCZnTfmRh9+91xs/TKfX2iU0t4fnqNH9+ZLIkb+i5Y6cyaIJXy89xuzHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3600
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 27/06/2020 09:33, Christoph Hellwig wrote:=0A=
> bio_associate_blkg_from_page is a special purpose helper for swap bios=0A=
=0A=
'for swapping' or 'to swap' I think.=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
