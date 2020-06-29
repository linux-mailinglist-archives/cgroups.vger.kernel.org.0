Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1061D20D13E
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgF2Sjx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:39:53 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42831 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgF2Sjb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 14:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593455971; x=1624991971;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=v20Num5+LA8LLGqK6Qo5cwz7zHNT/D+YHiGXKwkGqFg=;
  b=W0LlcvRm7Vvrdo3giKp2ky3vFPEyO0poqSDW+1//hrJeZU/CWVyTKeNm
   2McFBooJAl4ZRmGXSHGslzArA0mlFDgX7xz/KT7Gd3dcKXS2+8Sp8+3dj
   73RVe5L1TjvrsngMAOnx9A1xlC3ySYJ1iB6yDaOIb+itoAen5W7WJLkZI
   B19I6Mi65rfwTMnBkpzL1TFc3JnkIJW/aubru+ygizty+KWNVSuhU9oNB
   T6k+HeJVYKp8BeNoOwwhIpq1lFJn4SxK/s8aR1tMjRNuCwJMRUuxdmqzS
   mDNjaii7KCFx30rtjrotjLnFlh/+KHa6SF/H9D/TgvwqhN6YeAcSznmot
   Q==;
IronPort-SDR: yYoSB/bajzvprRL+QGL9WS5l1QePdYN+tE8/Vc3XmYSkLSKHQbR8UvWy1SOJNk8YulCFgtUz0e
 3dM/gxtf26S+e5NxR7Y9tlmKZVtV8oM3fDnoFOEGhQ/dsI2gmzC83MPncn5FVyeRXhxMZP0KFM
 J9HH3BX1gHHjAFZtxCU1KELeuSQLjP+qM9Sca5nCgCO9peGiunyOa8Hhg2nFs6msNOipatWUDA
 rqZ59z3LnJsLWUDmzx0EGKYVj3wGwd08hCzGI39ZRtKBE/bx3/3g3PiVJDYjYGYcP+X3Emk5Am
 sx4=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="142522624"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 16:12:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPV/Kq2BP9HaIgaeKaBl1Ql/SaBAODM2PTcAh1YtJ87SFDnW2JfAgVoWnDNPCxbOscomkV1F/vCmTNTnx7zln9C7gbwXgVaH1JlNVl39uPztZz0r2N0naY+r0ymQ7AoQ9IC6qhzmGW4fOrDsvOiQZWSwdhFxXStwpVuMwGLfsSE7tpSCVQYtcQoEAfytGp0Yh8WvMxDFE6nO9Ct85K8gELbycFjB/TlsTH/AAKv8IlHaB1vIXrGez2j9oyxen9fK94lyGq49BlTFKepPp/0rqMyQqUQ/P1ltQDnPRDvEgVGHbZ8RpxNfWxdMkDjCzQywzITD5vFbskrdeyaJ5Je3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr2r6a0L+bOFnoUwDXtlMP3VgBEV5AflST+t88Eqg6I=;
 b=gWYkq+oMzxJWC13J5DkxUN4an4/c+Ggu5Z5mgx9ogcHB3VOCyqffw0ZMXBzlQef254vG+/HJ5FU9CJ4kdzhTSE+3ADU+rY03RK0bM6P7HizuKWxbFU8bdSZ7J3DQnNBFkRU6dR/tzbALy9lSTkyO+ivo57n/IptEwbJIdJdeyR8rnMgJZna0CI+SiP2805miBVSYiHIjHZo/sShuefmBtmJ2XQwxkid8Qhz88QxkBLLPP6cwRgMuetfHB3iAFCEYKAENv/nu480ji/Ws6NuqiVIKAsyVvT8tPVjdOU4DyKY8v84ZZ4fg+IF6x41e36aaCL/ttTykQ/wyNYlWbSQHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr2r6a0L+bOFnoUwDXtlMP3VgBEV5AflST+t88Eqg6I=;
 b=neC+KDwkitL7f6rGG2+Bi8lX1CYkKZOLrm/irsNSQKjcyQ8STocHrEBm0IW5Gs8SMR1Hw3raaQuEm+g97Ad/UoboCIXMVeEoCSR/DjEt5TyJvGNADFJGDaTpKZBTpwBIFJpBQIeUlgVwhZylI0is4i6X0dOqAsL9RLJZt/Ga8dM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN6PR04MB4240.namprd04.prod.outlook.com (52.135.77.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.24; Mon, 29 Jun 2020 08:12:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 08:12:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: drive-by blk-cgroup cleanups
Thread-Topic: drive-by blk-cgroup cleanups
Thread-Index: AQHWTFVNUm1R45WD7UqFEU0lzIn8zQ==
Date:   Mon, 29 Jun 2020 08:12:53 +0000
Message-ID: <SN4PR0401MB359875B144AC724CCFD539219B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200627073159.2447325-1-hch@lst.de>
 <SN4PR0401MB3598A198ACA6126D96E949B59B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200629080831.GA32117@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c1f63d6-b151-4989-edc9-08d81c04391c
x-ms-traffictypediagnostic: SN6PR04MB4240:
x-microsoft-antispam-prvs: <SN6PR04MB424069E6001243465B2857909B6E0@SN6PR04MB4240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6BLWbCUWkYEfXy1divzZAy4AoFgLogOJDEYkU+j4KwS0ZQVv3EsR69b0MpPD7CoZehnNLf0IRcXhanRKvO4klLW1FsZpNhVgZUCVFE0snlWaMVNREBupOWZmgOMTqkHQhGKEUigjUaRWjnThZQ3+VOg2DcbBSfaTGDxEY2qJSn4PpTedOBn8dzNzqSA3tgwbpzRkg9uKDsLx/bCCklPGQ1gmzDHX5+irqEAFdljgHZW5g32qhOtkewM9yh1UVYPu2El+708riQ0mFJCejR/pgwUZbbkkOXG2iYpuD5aVOvc4B12UcbvbpKHYVHaaDrwq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(86362001)(55016002)(9686003)(71200400001)(478600001)(53546011)(8936002)(8676002)(186003)(6506007)(7416002)(76116006)(91956017)(66556008)(66476007)(66446008)(64756008)(316002)(7696005)(54906003)(4744005)(6916009)(3480700007)(52536014)(66946007)(2906002)(4326008)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4IUkFNfsqgWS6Q5k81jfQ1xBbOIhstp6Rm/4LcjYMHBseMl2QGFjbPqhvKEGGUZ6uWuMXu1gi2/v4+vf3FPvZV87NTnx7XV76ul79WCZ6T4X5LOECWSqzxiVRX+JvXz4kyj9mw5m//z8Q1vRHWOqA9SMC+/m+d5dD4mxiC0jB24tXkCNXgjP3pKYOU1rjf6mNr5mg3p/5y2dMOqCK64AW4tTD5c3EV3plKyDNUyYiiivvQCOJUNmlEIHOD+C6JXRx2Iwqn/lRmRSruzXr5t8QOvsJFlIzdRmrNvQtQBKwzib87FFo/LnFVpiPKoseTfslmy8KCYg1bKPi+Wb79tid0jJlOfFLNyWDcByBjfBZyrwR3q1+5HZE81hkcFahYaFXbiVMGJsy46Z2BObvjPT6hX7sAN2kr81T3Nbnt6+izhj1l3xJwtIeCEUOoJ3YsiP0dgo0RnUjml4uWnLp8MWXGl+3Pdf1yF8jPeZqdmkn8ySI56C2UmkITG3Ni724yw4UID9pHp34QGKTi+yZLc1ZAMv+NwfqODsMI1L1xB85wU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1f63d6-b151-4989-edc9-08d81c04391c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 08:12:53.5599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJEfDprF4ERK5ytTKHmX9/boynSSfsD7jxfPgoCKSpKSrxEMbXu1Np6syIYpghSjxrAC0DhAHdB7pAGs7Hdxl/H7k1NXiUqI8L1D+hv0uD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4240
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 29/06/2020 10:08, Christoph Hellwig wrote:=0A=
> You'll have to ask Jens :)  Note that your patch 2 overlaps with this=0A=
> series.  =0A=
=0A=
Should have removed you from the To: field, sorry.=0A=
=0A=
> I thik my version is a little nicer, given that=0A=
> blkcg_bio_issue_check is a very strange function doing multiple things=0A=
> as-is.=0A=
> =0A=
> =0A=
=0A=
Agreed, I'll go through your series later today. Patches 1 and 3 are still =
=0A=
applicable though I think. =0A=
