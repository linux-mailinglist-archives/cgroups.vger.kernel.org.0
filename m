Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9437754
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2019 17:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfFFPDH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jun 2019 11:03:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3871 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfFFPDH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jun 2019 11:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559833387; x=1591369387;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=77O/NUdT38XGfrjDff5NjM8zU6sT8Poj32urvyyH9LQ=;
  b=B/tcjmMrHZ5gmZeQQqjDoCI7K4JXDC9CoarbYmaOBsxzSvOjf7iwL9uq
   0lZSY8Qu/Pf0UkACqzUiKRKNXU6Eg6F/nKns2sE2YDI1GaGSiVu2PVahB
   Cb5FQE9PJhOaSQ8t23SsRXrnxAwUFTJEPayQo3aTwa3PL9V8juLvj3uWn
   kC4/AfCgUr7qpEkCHUEfEe/FmpFMUstsdE52bkcOcHq6yPfHEIMixvtyA
   1itwDyQ9eHcZ7CQE2kGWHaYvHHefYXQ2jVqEa01rIUGVKKrBTTb/Uk+e8
   loOZJLjCZwhDCpUSN865Socvw1JQyWGjazU2tEZjBDJVjoK87jwNJ/ii8
   g==;
X-IronPort-AV: E=Sophos;i="5.63,559,1557158400"; 
   d="scan'208";a="114906567"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2019 23:03:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq6dkQ6VWPE4D4SL5rvWUtzAf/9p6ITXPkC1UBHgNgU=;
 b=yhA3It6xG3t93OUc0A3zRwuR5cWTNMir7mYoH3YckjJh+9OvUP176bWe1KM+Z2O6Dxk4Sg+JWlDi5Hluz0qHnaSEw2XrELsqd71roJdphOlhQ5Ca1PT8cRTp30ZcL3+uQB/E78vHr1EfXLnCDnDZ1ma/O0vbYOFW+j4wuGCMECk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4984.namprd04.prod.outlook.com (52.135.233.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 15:03:04 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 15:03:04 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Paolo Valente <paolo.valente@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] blk-cgroup: factor out a helper to read rwstat
 counter
Thread-Topic: [PATCH 1/6] blk-cgroup: factor out a helper to read rwstat
 counter
Thread-Index: AQHVHFJhZ4VKgpaKE06JKCLjPSf8gQ==
Date:   Thu, 6 Jun 2019 15:03:04 +0000
Message-ID: <BYAPR04MB5749DB3E6C0307980F32A80886170@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190606102624.3847-1-hch@lst.de>
 <20190606102624.3847-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b41e927-1bd2-4288-5dbb-08d6ea901382
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4984;
x-ms-traffictypediagnostic: BYAPR04MB4984:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4984E92356A6DC8E28A02FA986170@BYAPR04MB4984.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(446003)(74316002)(6436002)(71200400001)(14444005)(256004)(76116006)(66946007)(91956017)(66476007)(71190400001)(66556008)(64756008)(66446008)(73956011)(33656002)(186003)(9686003)(26005)(68736007)(6246003)(110136005)(54906003)(316002)(7696005)(478600001)(76176011)(53936002)(6116002)(3846002)(72206003)(25786009)(4326008)(81166006)(229853002)(99286004)(81156014)(52536014)(66066001)(8676002)(2906002)(5660300002)(102836004)(8936002)(86362001)(7736002)(305945005)(14454004)(486006)(55016002)(476003)(53546011)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4984;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rkSE0LkJP/uFX7Z/nfNmizq2fPas7HyE1GHESkShk3l+58zJ+1aC3Hscf2dtq2DPRDVbSW8MEj+2kHh0/okuASugJzUNpLW6yiKO0ZtLKiEKXSYb1+TEz6TP1kIsE/uxGpQmf8YLziuuuyOoJ8aCKFc3zPwenMClymazTr0BmV3dZLLqdxVNmjef0MkJd8LTPrBau0ILo2YCObDuocwoq0oUSUn+E/Ja7DdRQFq7c8RSKeHZZdp5mjMizGOpguBFyUJa/Pni717TRPksCm/q1USD9yMS2UOVLPb3koQrewdEtoiZ/Ri0fpflNFCEwT7O0mldVOKLxufWpFsWVtPMHH0A0EqF6HAVfzpq47t5WnAXBWUEnK6jjorvDf+wkD/p/zp7GV15UIUWO1sxmZcO4vRmviBI4I1PDsrsjJD1+Bg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b41e927-1bd2-4288-5dbb-08d6ea901382
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 15:03:04.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4984
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 06/06/2019 03:27 AM, Christoph Hellwig wrote:=0A=
> Trying to break up the crazy statements to something readable.=0A=
> Also switch to an unsigned counter as it can't ever turn negative.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/blk-cgroup.c         | 5 ++---=0A=
>   include/linux/blk-cgroup.h | 7 +++++++=0A=
>   2 files changed, 9 insertions(+), 3 deletions(-)=0A=
>=0A=
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c=0A=
> index b97b479e4f64..6f79ace02be4 100644=0A=
> --- a/block/blk-cgroup.c=0A=
> +++ b/block/blk-cgroup.c=0A=
> @@ -750,7 +750,7 @@ struct blkg_rwstat blkg_rwstat_recursive_sum(struct b=
lkcg_gq *blkg,=0A=
>   	struct blkcg_gq *pos_blkg;=0A=
>   	struct cgroup_subsys_state *pos_css;=0A=
>   	struct blkg_rwstat sum =3D { };=0A=
> -	int i;=0A=
> +	unsigned int i;=0A=
>=0A=
>   	lockdep_assert_held(&blkg->q->queue_lock);=0A=
>=0A=
> @@ -767,8 +767,7 @@ struct blkg_rwstat blkg_rwstat_recursive_sum(struct b=
lkcg_gq *blkg,=0A=
>   			rwstat =3D (void *)pos_blkg + off;=0A=
>=0A=
>   		for (i =3D 0; i < BLKG_RWSTAT_NR; i++)=0A=
> -			atomic64_add(atomic64_read(&rwstat->aux_cnt[i]) +=0A=
> -				percpu_counter_sum_positive(&rwstat->cpu_cnt[i]),=0A=
> +			atomic64_add(blkg_rwstat_read_counter(rwstat, i),=0A=
>   				&sum.aux_cnt[i]);=0A=
>   	}=0A=
>   	rcu_read_unlock();=0A=
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h=0A=
> index 76c61318fda5..06236f56a840 100644=0A=
> --- a/include/linux/blk-cgroup.h=0A=
> +++ b/include/linux/blk-cgroup.h=0A=
> @@ -198,6 +198,13 @@ int blkcg_activate_policy(struct request_queue *q,=
=0A=
>   void blkcg_deactivate_policy(struct request_queue *q,=0A=
>   			     const struct blkcg_policy *pol);=0A=
>=0A=
> +static inline u64 blkg_rwstat_read_counter(struct blkg_rwstat *rwstat,=
=0A=
> +		unsigned int idx)=0A=
> +{=0A=
> +	return atomic64_read(&rwstat->aux_cnt[idx]) +=0A=
> +		percpu_counter_sum_positive(&rwstat->cpu_cnt[idx]);=0A=
> +}=0A=
> +=0A=
>   const char *blkg_dev_name(struct blkcg_gq *blkg);=0A=
>   void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,=0A=
>   		       u64 (*prfill)(struct seq_file *,=0A=
>=0A=
=0A=
