Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D662620D133
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 20:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgF2Sjb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:39:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42842 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgF2Sj3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 14:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593455969; x=1624991969;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ufvHmkBs8pz3Y1gQXakeSKcUD8FsxafBA+OmlJ1FVSA=;
  b=e4PqTWd42D2kF40u4d3gvGvQJqYQRuHFlbz1Aud/hh0IEMzkKZy16YUZ
   sC1aHu1Ddw31jlqKMqkINb0ymp21jqoU2hF0G3VOU7rKcBNRs46yXfS9P
   J/8MVvuLQLrq91CLwY7GvN5T/qKqqI18O/xWBbk7bBMrAyXvrVLOb2L+5
   z9T3MWun5Fj4rL8oNgLFRbJyvHEg2TI00Wo8ALXimc/bmxlfLWVGMvBCi
   xInK2MRqVrZffSGSQziT8B2QfQCrGmgcRlxv5YR1AtbZudrq7At4mFOZu
   /BrEil2Tyqevzwnzc9PkecbnFLc+zcPyxg+6sw+qi9cZgJW2by09cQ9Ef
   A==;
IronPort-SDR: guItr0tdOhbzWYn71HMAJknGWcKdvKyoGK/n8E16jMllqaFsQracCFdv14OOAMQ1vPYS94Y9sC
 GQ5fimlQmJfOnWHrjvzBQ/4+uJovWQlUddvwdPf9KPEv4VqdqiZnlmUGR8ndY8OXvYoikvkYuO
 c0TLT366VEqfivsfZoaie7jIXSnTfxlKnKsEerEpS83n0OgN4hb3ywOUz/GoUeopMYQwOlECv0
 yDbD+yEVPXHjkH3t3DbpwKPl058OqGe+3LyZ9Vj0+doZYewNJYF9hbKt34YRBMNizmk6rWXXUM
 piI=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="142522030"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 16:05:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn13cswQXXj32QyuVDIB/R661MGyfjco8G+cH7+1ShEnrVzFT5K6M1gO1Any/RYbzRAnqWbEx0PGYiO3zWxY1gzfHHEWB4/Cu+JGZvZGuSCacyhLCjgnTU8UC9DbhqnluwMjQ9mSABXrFVyxIQkUIb8IyGu9E7a209FSC+Z7pKVvvtIV/ouqab1pIw3pUVeNemwekGL6R7kT53wBAoTryow8i3ABAgPOgFsO7kywuQr6OPoodrOklr3nSv65kAt6JybraplomeoNBINMpbv3I5SRXMgZ4R5uOiqm0l6+Jr4bz89FdidgLMOogpTP0PJehG/kaqTs0cc8X1MfT/FV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl+5qs5ibMTApcnlXmtwu8TEgRz1VAIl5aDiKXv764k=;
 b=n0+7BO9EDsWOoI+TzR+NNwA1eBMH9Tqu3rzpsaf4FUzSUudK9RMhXKrArWTWmICtxYjpEZEPuoAmGgbjzsHTeXvcMm/FR6qgn22TcNBqtusFIzBgtjSJvUH+LnZxVoNIEsYScBv4eRU6EFAN1BrbGXYAuQjZIib8wFbHQkGtwFBxy++CUInn+FaMN1rphIdMm+xY4YKmFxRcuz3uIF1ZknCtRjTrYUx9TpYdlE59c7dYvEwT/z7OskA3kh+HIpj9x+MSA9vT+LLG+KPgUBN44e3K4CpFFG46rtdFrnaFIy606nt4FjmQXUJmwrTtNwyNiBGvnURHUsfhYnztudErHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl+5qs5ibMTApcnlXmtwu8TEgRz1VAIl5aDiKXv764k=;
 b=R5pP28WSu3Hf+ZzHWmiytT6mcZPAP2qXojql9icbibwY9c+p6yIndcSrWRaqNGTNx83XPqDBAiGpI1myPk+2xm/MdFlCm2pR3MIfMd8CNodKxipkmqSx6yZ86rmkR7CgDZgqZcokkK1lUjjr+KS+3HX+Z6LG/0EJh7mOiI9NTss=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 08:05:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 08:05:07 +0000
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
Subject: Re: drive-by blk-cgroup cleanups
Thread-Topic: drive-by blk-cgroup cleanups
Thread-Index: AQHWTFVNUm1R45WD7UqFEU0lzIn8zQ==
Date:   Mon, 29 Jun 2020 08:05:07 +0000
Message-ID: <SN4PR0401MB3598A198ACA6126D96E949B59B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200627073159.2447325-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b954eda-16d9-4b32-f514-08d81c032314
x-ms-traffictypediagnostic: SN6PR04MB4543:
x-microsoft-antispam-prvs: <SN6PR04MB4543D6D08D25104EB56280919B6E0@SN6PR04MB4543.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBtHp69HFt5t5P6wMyVoqOCIxVMhWHBWlj3FNyIjXtM9up73OGB1Nzzt/RNwFcp2wcNaHjuCieX/7s1cRNYVUVzZsntlNyQsAOckauH5mfTNpJiYFVyfFa4u8z4R4AqcN/+ALBxCSNYV2gtQ4sQDoTJcmlk4MtmRGnQqHwPam9NxTOTdCw/+MgJX4/R+DaozX2W+qRAKu8XB+CzdMo28jmcWmxpRsIF4wkCp6gq9kcpuZBEfWmyLMLpTl5N338SpbqYKTNSB2vh5h/g8vIYb352/u34ojKnuBrr7ybDYL6oqt5n/CHhyrk9UZmdUr7ukK3nFTaConMRq3CtQ5hlwPvl5xHXdxOQ/1bXZGJQXfwWTIixl+bUF2KpmKrxZeNYiYGdssOzpgEo2NQcnGy0eKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(3480700007)(186003)(966005)(71200400001)(66476007)(7416002)(66946007)(91956017)(110136005)(76116006)(83380400001)(66446008)(64756008)(66556008)(8676002)(52536014)(478600001)(5660300002)(316002)(86362001)(33656002)(55016002)(4326008)(2906002)(8936002)(7696005)(54906003)(53546011)(6506007)(9686003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7KYnjZLq0IBsQAXlYk9BeKhOMIXLCbQ0GDojzQ3lz+2jAP2pYMGoUzpyVn+kDub8BVWvzK/rlTR4BK4r485v8Lm9MrnewmgaZisBdWVhKjWvAtUzvYno5bsIaVkYYgzgfMcLdTc9u1IoZjFQm4Z9BlAnMBGyp2A37iCCgplShNQJ/3wSyXDnIXNb/IjJPdibs1KbHPqSA+VhmzOV1smDAWQl9q2bW9FM8j2aGQWSrQfqPa6G9SJdunMpQufBi6rmSWV9FRhvdVvJHUsSZUQyHw/V6DZ4KT/QN2Ysv3e0eYeYBadnR7RzhwTHhMQ1n8MMCAsgwBzB2cvh3/+4eodFk1rSZ6F/awI78G2f4Hg8EESFOCHUiXn/kMR0XKUKV3G/Xxbdq/CNau5IZdVA61wLlwvndL3mskVyEQu/hZCvTR8lWqW4kfA9GWbofQD+MjDeg6TP88RZfEcfuZam2dhc/HONk7uKgHxUC1rsuHmKdwV3B805iPkPMTXilAxhG9NeZcLVAn9rkjQ2Fh/ealCg2NHiQSp3q4qdLx8hEZZBBhw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b954eda-16d9-4b32-f514-08d81c032314
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 08:05:07.0401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxsMyNQWQSSYwSeXGlGvUOzxeP4WOaoaSIWIDpwwMmIZm0QbPEkvYRt/dNwOy8lydGK1JcSaBJCIMGYl12vhjt+ngJ0Rct7V9CruZQWIVpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4543
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 27/06/2020 09:33, Christoph Hellwig wrote:=0A=
> Hi all,=0A=
> =0A=
> while looking into another "project" I ended up wading through the=0A=
> blkcq code for research and found a bunch of lose ends.  So here is=0A=
> a bunch of drive-by cleanups for the code.=0A=
> =0A=
> Diffstat:=0A=
>  block/bio.c                |  143 +----------------------------------=0A=
>  block/blk-cgroup.c         |  182 +++++++++++++++++++++++++++++++++++++-=
-------=0A=
>  block/blk-core.c           |    7 +=0A=
>  block/blk-throttle.c       |   10 +-=0A=
>  block/blk.h                |    2 =0A=
>  drivers/md/dm.c            |    5 -=0A=
>  include/linux/bio.h        |    9 --=0A=
>  include/linux/blk-cgroup.h |  101 ------------------------=0A=
>  kernel/cgroup/rstat.c      |    1 =0A=
>  mm/page_io.c               |   17 ++++=0A=
>  10 files changed, 192 insertions(+), 285 deletions(-)=0A=
> =0A=
=0A=
Btw what ever happened to https://lore.kernel.org/r/20200430150356.35691-1-=
johannes.thumshirn@wdc.com?=0A=
