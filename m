Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D162F4C0E6
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2019 20:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfFSShi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Jun 2019 14:37:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25856 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFSShh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Jun 2019 14:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560969455; x=1592505455;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UbLfPL7gqbucZe14NK1e/NjeWhMQlLLf1tBaC2YD8sM=;
  b=cv9ALwQTHnK7r1c8ET/p8bxx3oOBW9YHopdW239PGd3Kl/SwLyGx3Cyh
   3GkmXPuajF5JwXM6s6mCHNkO8xsINQxLpK+pJGqLg+P5oEnhYEr4Q907n
   xXCJiBX/6Wyv7eQ3h5PVguCtn6afAAfvpkN1l2mV95cr/IRVqPAgKEKVc
   K694v4qJ8ijlIfgaC5ifeP07kQARNU+u9+fcLILN8gUY3D9yGnuMjbsZK
   Vh83HFgvALjUiAYHejNg1ZKd8TeS6BOrmzRh8SsmPh4BdbJkE5TF/PAmL
   KRxg1wTokSpmCAjGmzbjys1gQnsEbAupiN3JJrNJJTC45wAjLrGxSw3Sb
   g==;
X-IronPort-AV: E=Sophos;i="5.63,393,1557158400"; 
   d="scan'208";a="110980989"
Received: from mail-dm3nam03lp2059.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.59])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 02:37:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb4FiMJwPzSPXhglNwB/oKnJaCucFnKvKPy+oce7Hqk=;
 b=PJWCTo7dpp0NovEOveR6vctuzzMGDX/Uc5Z4WpM0grZLAQh8q7QhFO99eRyGaS6ZAJ3iapMugkKx/NEBsV2dbRy5ptRb0Rsku8GazwUFEr4hNKiWNvgguHCeKXBIkeNztgPTAwRB0h5j3dHMCWWJ4dK+EpkxPEoydjJHSDylKnE=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB6493.namprd04.prod.outlook.com (20.179.226.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Wed, 19 Jun 2019 18:37:32 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::a07d:d226:c10f:7211]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::a07d:d226:c10f:7211%6]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 18:37:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Weiping Zhang <zhangweiping@didiglobal.com>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] nvme: add support weighted round robin queue
Thread-Topic: [PATCH v2 4/4] nvme: add support weighted round robin queue
Thread-Index: AQHVJCyCjqzfRA2lCEG4+YNW0h0Yog==
Date:   Wed, 19 Jun 2019 18:37:32 +0000
Message-ID: <DM6PR04MB575412D32736A04F245EB40186E50@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <cover.1560679439.git.zhangweiping@didiglobal.com>
 <0b0fa12a337f97a8cc878b58673b3eb619539174.1560679439.git.zhangweiping@didiglobal.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c29b06f0-8db0-4d6a-6bf6-08d6f4e530df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB6493;
x-ms-traffictypediagnostic: DM6PR04MB6493:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB6493D3282F9F39CB6C37BCC386E50@DM6PR04MB6493.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(396003)(366004)(346002)(199004)(189003)(51234002)(72206003)(73956011)(86362001)(316002)(102836004)(5660300002)(52536014)(99286004)(6506007)(7696005)(68736007)(76176011)(2906002)(478600001)(6436002)(54906003)(14444005)(8936002)(3846002)(6116002)(110136005)(33656002)(2501003)(14454004)(81166006)(81156014)(2201001)(71190400001)(8676002)(7736002)(305945005)(71200400001)(30864003)(256004)(9686003)(53546011)(229853002)(74316002)(25786009)(53936002)(446003)(6246003)(66476007)(26005)(476003)(486006)(66446008)(64756008)(4326008)(76116006)(91956017)(66556008)(66946007)(55016002)(66066001)(186003)(16393002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB6493;H:DM6PR04MB5754.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YUpR/6Sv4cdVIbNbvNqYqCrfmUUsHa2NDAtuQTbobi9gmF3YB18oOq5IcW7To4joKMY0TwMo5H2BbFhN93asomfdB63vYO1OZlsrDl6MEK2TffjCpAoZ7gQ1x7KwOXYffCz4ALsUErYPqestKjOv4nXqN8HTzC91VkRL657bWCoKwpAxk2K0m7RcwPGa1TapVTbMV7Ex6H0FSZei6lEskcd1RajaCnViDI7W8jqgDHWK8FgwPpi1It7uioca4FbYFQqnVaavTdEUmO4TRlmlNIO2zX1RsjIAa9VUolr/KL6yoA1NYiJAqPiyW+VrNWTMxTSVwxKwO6/Z/Y37TF7NgTTZSsBg9mJ78w6uPqNCZxfx0ICxWy0IX7Tn5Ae/kt5Hj/5C71Hvmqbr6aIdoHxLYA9Cp4g06KNkKL210KsxEfs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29b06f0-8db0-4d6a-6bf6-08d6f4e530df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 18:37:32.1991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6493
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Please add linux-nvme@lists.infradead.org to this list=0A=
and Cc maintainers of NVMe subsystems.=0A=
=0A=
Also do you have performance numbers for WRR ?=0A=
=0A=
On 06/16/2019 03:16 AM, Weiping Zhang wrote:=0A=
> Now nvme support five types hardware queue:=0A=
> poll:		if io was marked for poll=0A=
> wrr_low:	weighted round robin low=0A=
> wrr_medium:	weighted round robin medium=0A=
> wrr_high:	weighted round robin high=0A=
> read:		for read, if blkcg's wrr is none and is not poll=0A=
> defaut:		for write/flush, if blkcg's wrr is none and is not poll=0A=
>=0A=
> for read, default and poll those submission queue's priority is medium by=
 default;=0A=
>=0A=
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>=0A=
> ---=0A=
>   drivers/nvme/host/pci.c   | 195 +++++++++++++++++++++++++++++++++------=
-------=0A=
>   include/linux/interrupt.h |   2 +-=0A=
>   2 files changed, 144 insertions(+), 53 deletions(-)=0A=
>=0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index f562154551ce..ee9f3239f3e7 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -73,16 +73,28 @@ static const struct kernel_param_ops queue_count_ops =
=3D {=0A=
>   	.get =3D param_get_int,=0A=
>   };=0A=
>=0A=
> -static int write_queues;=0A=
> -module_param_cb(write_queues, &queue_count_ops, &write_queues, 0644);=0A=
> -MODULE_PARM_DESC(write_queues,=0A=
> -	"Number of queues to use for writes. If not set, reads and writes "=0A=
> +static int read_queues;=0A=
> +module_param_cb(read_queues, &queue_count_ops, &read_queues, 0644);=0A=
> +MODULE_PARM_DESC(read_queues,=0A=
> +	"Number of queues to use for reads. If not set, reads and writes "=0A=
>   	"will share a queue set.");=0A=
>=0A=
>   static int poll_queues =3D 0;=0A=
>   module_param_cb(poll_queues, &queue_count_ops, &poll_queues, 0644);=0A=
>   MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.")=
;=0A=
>=0A=
> +static int wrr_high_queues =3D 0;=0A=
> +module_param_cb(wrr_high_queues, &queue_count_ops, &wrr_high_queues, 064=
4);=0A=
> +MODULE_PARM_DESC(wrr_high_queues, "Number of queues to use for WRR high.=
");=0A=
> +=0A=
> +static int wrr_medium_queues =3D 0;=0A=
> +module_param_cb(wrr_medium_queues, &queue_count_ops, &wrr_medium_queues,=
 0644);=0A=
> +MODULE_PARM_DESC(wrr_medium_queues, "Number of queues to use for WRR med=
ium.");=0A=
> +=0A=
> +static int wrr_low_queues =3D 0;=0A=
> +module_param_cb(wrr_low_queues, &queue_count_ops, &wrr_low_queues, 0644)=
;=0A=
> +MODULE_PARM_DESC(wrr_low_queues, "Number of queues to use for WRR low.")=
;=0A=
> +=0A=
>   struct nvme_dev;=0A=
>   struct nvme_queue;=0A=
>=0A=
> @@ -226,9 +238,17 @@ struct nvme_iod {=0A=
>   	struct scatterlist *sg;=0A=
>   };=0A=
>=0A=
> +static inline bool nvme_is_enable_wrr(struct nvme_dev *dev)=0A=
> +{=0A=
> +	return dev->io_queues[HCTX_TYPE_WRR_LOW] +=0A=
> +		dev->io_queues[HCTX_TYPE_WRR_MEDIUM] +=0A=
> +		dev->io_queues[HCTX_TYPE_WRR_HIGH] > 0;=0A=
> +}=0A=
> +=0A=
>   static unsigned int max_io_queues(void)=0A=
>   {=0A=
> -	return num_possible_cpus() + write_queues + poll_queues;=0A=
> +	return num_possible_cpus() + read_queues + poll_queues +=0A=
> +		wrr_high_queues + wrr_medium_queues + wrr_low_queues;=0A=
>   }=0A=
>=0A=
>   static unsigned int max_queue_count(void)=0A=
> @@ -1156,19 +1176,23 @@ static int adapter_alloc_cq(struct nvme_dev *dev,=
 u16 qid,=0A=
>   }=0A=
>=0A=
>   static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,=0A=
> -						struct nvme_queue *nvmeq)=0A=
> +					struct nvme_queue *nvmeq, int wrr)=0A=
>   {=0A=
>   	struct nvme_ctrl *ctrl =3D &dev->ctrl;=0A=
>   	struct nvme_command c;=0A=
>   	int flags =3D NVME_QUEUE_PHYS_CONTIG;=0A=
>=0A=
> -	/*=0A=
> -	 * Some drives have a bug that auto-enables WRRU if MEDIUM isn't=0A=
> -	 * set. Since URGENT priority is zeroes, it makes all queues=0A=
> -	 * URGENT.=0A=
> -	 */=0A=
> -	if (ctrl->quirks & NVME_QUIRK_MEDIUM_PRIO_SQ)=0A=
> -		flags |=3D NVME_SQ_PRIO_MEDIUM;=0A=
> +	if (!nvme_is_enable_wrr(dev)) {=0A=
> +		/*=0A=
> +		 * Some drives have a bug that auto-enables WRRU if MEDIUM isn't=0A=
> +		 * set. Since URGENT priority is zeroes, it makes all queues=0A=
> +		 * URGENT.=0A=
> +		 */=0A=
> +		if (ctrl->quirks & NVME_QUIRK_MEDIUM_PRIO_SQ)=0A=
> +			flags |=3D NVME_SQ_PRIO_MEDIUM;=0A=
> +	} else {=0A=
> +		flags |=3D wrr;=0A=
> +	}=0A=
>=0A=
>   	/*=0A=
>   	 * Note: we (ab)use the fact that the prp fields survive if no data=0A=
> @@ -1534,11 +1558,46 @@ static void nvme_init_queue(struct nvme_queue *nv=
meq, u16 qid)=0A=
>   	wmb(); /* ensure the first interrupt sees the initialization */=0A=
>   }=0A=
>=0A=
> -static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool pol=
led)=0A=
> +static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)=0A=
>   {=0A=
>   	struct nvme_dev *dev =3D nvmeq->dev;=0A=
> -	int result;=0A=
> +	int start, end, result, wrr;=0A=
> +	bool polled =3D false;=0A=
>   	u16 vector =3D 0;=0A=
> +	enum hctx_type type;=0A=
> +=0A=
> +	/* 0 for admain queue, io queue index >=3D 1 */=0A=
> +	start =3D 1;=0A=
> +	/* get hardware context type base on qid */=0A=
> +	for (type =3D HCTX_TYPE_DEFAULT; type < HCTX_MAX_TYPES; type++) {=0A=
> +		end =3D start + dev->io_queues[type] - 1;=0A=
> +		if (qid >=3D start && qid <=3D end)=0A=
> +			break;=0A=
> +		start =3D end + 1;=0A=
> +	}=0A=
> +=0A=
> +	if (nvme_is_enable_wrr(dev)) {=0A=
> +		/* set read,poll,default to medium by default */=0A=
> +		switch (type) {=0A=
> +		case HCTX_TYPE_POLL:=0A=
> +			polled =3D true;=0A=
> +		case HCTX_TYPE_DEFAULT:=0A=
> +		case HCTX_TYPE_READ:=0A=
> +		case HCTX_TYPE_WRR_MEDIUM:=0A=
> +			wrr =3D NVME_SQ_PRIO_MEDIUM;=0A=
> +			break;=0A=
> +		case HCTX_TYPE_WRR_LOW:=0A=
> +			wrr =3D NVME_SQ_PRIO_LOW;=0A=
> +			break;=0A=
> +		case HCTX_TYPE_WRR_HIGH:=0A=
> +			wrr =3D NVME_SQ_PRIO_HIGH;=0A=
> +			break;=0A=
> +		default:=0A=
> +			return -EINVAL;=0A=
> +		}=0A=
> +	} else {=0A=
> +		wrr =3D 0;=0A=
> +	}=0A=
>=0A=
>   	clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);=0A=
>=0A=
> @@ -1555,7 +1614,7 @@ static int nvme_create_queue(struct nvme_queue *nvm=
eq, int qid, bool polled)=0A=
>   	if (result)=0A=
>   		return result;=0A=
>=0A=
> -	result =3D adapter_alloc_sq(dev, qid, nvmeq);=0A=
> +	result =3D adapter_alloc_sq(dev, qid, nvmeq, wrr);=0A=
>   	if (result < 0)=0A=
>   		return result;=0A=
>   	else if (result)=0A=
> @@ -1726,7 +1785,7 @@ static int nvme_pci_configure_admin_queue(struct nv=
me_dev *dev)=0A=
>=0A=
>   static int nvme_create_io_queues(struct nvme_dev *dev)=0A=
>   {=0A=
> -	unsigned i, max, rw_queues;=0A=
> +	unsigned i, max;=0A=
>   	int ret =3D 0;=0A=
>=0A=
>   	for (i =3D dev->ctrl.queue_count; i <=3D dev->max_qid; i++) {=0A=
> @@ -1737,17 +1796,9 @@ static int nvme_create_io_queues(struct nvme_dev *=
dev)=0A=
>   	}=0A=
>=0A=
>   	max =3D min(dev->max_qid, dev->ctrl.queue_count - 1);=0A=
> -	if (max !=3D 1 && dev->io_queues[HCTX_TYPE_POLL]) {=0A=
> -		rw_queues =3D dev->io_queues[HCTX_TYPE_DEFAULT] +=0A=
> -				dev->io_queues[HCTX_TYPE_READ];=0A=
> -	} else {=0A=
> -		rw_queues =3D max;=0A=
> -	}=0A=
>=0A=
>   	for (i =3D dev->online_queues; i <=3D max; i++) {=0A=
> -		bool polled =3D i > rw_queues;=0A=
> -=0A=
> -		ret =3D nvme_create_queue(&dev->queues[i], i, polled);=0A=
> +		ret =3D nvme_create_queue(&dev->queues[i], i);=0A=
>   		if (ret)=0A=
>   			break;=0A=
>   	}=0A=
> @@ -2028,35 +2079,73 @@ static int nvme_setup_host_mem(struct nvme_dev *d=
ev)=0A=
>   static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int =
nrirqs)=0A=
>   {=0A=
>   	struct nvme_dev *dev =3D affd->priv;=0A=
> -	unsigned int nr_read_queues;=0A=
> +	unsigned int nr_total, nr, nr_read, nr_default;=0A=
> +	unsigned int nr_wrr_high, nr_wrr_medium, nr_wrr_low;=0A=
> +	unsigned int nr_sets;=0A=
>=0A=
>   	/*=0A=
>   	 * If there is no interupt available for queues, ensure that=0A=
>   	 * the default queue is set to 1. The affinity set size is=0A=
>   	 * also set to one, but the irq core ignores it for this case.=0A=
> -	 *=0A=
> -	 * If only one interrupt is available or 'write_queue' =3D=3D 0, combin=
e=0A=
> -	 * write and read queues.=0A=
> -	 *=0A=
> -	 * If 'write_queues' > 0, ensure it leaves room for at least one read=
=0A=
> -	 * queue.=0A=
>   	 */=0A=
> -	if (!nrirqs) {=0A=
> +	if (!nrirqs)=0A=
>   		nrirqs =3D 1;=0A=
> -		nr_read_queues =3D 0;=0A=
> -	} else if (nrirqs =3D=3D 1 || !write_queues) {=0A=
> -		nr_read_queues =3D 0;=0A=
> -	} else if (write_queues >=3D nrirqs) {=0A=
> -		nr_read_queues =3D 1;=0A=
> -	} else {=0A=
> -		nr_read_queues =3D nrirqs - write_queues;=0A=
> -	}=0A=
>=0A=
> -	dev->io_queues[HCTX_TYPE_DEFAULT] =3D nrirqs - nr_read_queues;=0A=
> -	affd->set_size[HCTX_TYPE_DEFAULT] =3D nrirqs - nr_read_queues;=0A=
> -	dev->io_queues[HCTX_TYPE_READ] =3D nr_read_queues;=0A=
> -	affd->set_size[HCTX_TYPE_READ] =3D nr_read_queues;=0A=
> -	affd->nr_sets =3D nr_read_queues ? 2 : 1;=0A=
> +	nr_total =3D nrirqs;=0A=
> +=0A=
> +	nr_read =3D nr_wrr_high =3D nr_wrr_medium =3D nr_wrr_low =3D 0;=0A=
> +=0A=
> +	/* set default to 1, add all the rest queue to default at last */=0A=
> +	nr =3D nr_default =3D 1;=0A=
> +	nr_sets =3D 1;=0A=
> +=0A=
> +	nr_total -=3D nr;=0A=
> +	if (!nr_total)=0A=
> +		goto done;=0A=
> +=0A=
> +	/* read queues */=0A=
> +	nr_sets++;=0A=
> +	nr_read =3D nr =3D read_queues > nr_total ? nr_total : read_queues;=0A=
> +	nr_total -=3D nr;=0A=
> +	if (!nr_total)=0A=
> +		goto done;=0A=
> +=0A=
> +	/* wrr low queues */=0A=
> +	nr_sets++;=0A=
> +	nr_wrr_low =3D nr =3D wrr_low_queues > nr_total ? nr_total : wrr_low_qu=
eues;=0A=
> +	nr_total -=3D nr;=0A=
> +	if (!nr_total)=0A=
> +		goto done;=0A=
> +=0A=
> +	/* wrr medium queues */=0A=
> +	nr_sets++;=0A=
> +	nr_wrr_medium =3D nr =3D wrr_medium_queues > nr_total ? nr_total : wrr_=
medium_queues;=0A=
> +	nr_total -=3D nr;=0A=
> +	if (!nr_total)=0A=
> +		goto done;=0A=
> +=0A=
> +	/* wrr high queues */=0A=
> +	nr_sets++;=0A=
> +	nr_wrr_high =3D nr =3D wrr_high_queues > nr_total ? nr_total : wrr_high=
_queues;=0A=
> +	nr_total -=3D nr;=0A=
> +	if (!nr_total)=0A=
> +		goto done;=0A=
> +=0A=
> +	/* set all the rest queue to default */=0A=
> +	nr_default +=3D nr_total;=0A=
> +=0A=
> +done:=0A=
> +	dev->io_queues[HCTX_TYPE_DEFAULT] =3D nr_default;=0A=
> +	affd->set_size[HCTX_TYPE_DEFAULT] =3D nr_default;=0A=
> +	dev->io_queues[HCTX_TYPE_READ] =3D nr_read;=0A=
> +	affd->set_size[HCTX_TYPE_READ] =3D nr_read;=0A=
> +	dev->io_queues[HCTX_TYPE_WRR_LOW] =3D nr_wrr_low;=0A=
> +	affd->set_size[HCTX_TYPE_WRR_LOW] =3D nr_wrr_low;=0A=
> +	dev->io_queues[HCTX_TYPE_WRR_MEDIUM] =3D nr_wrr_medium;=0A=
> +	affd->set_size[HCTX_TYPE_WRR_MEDIUM] =3D nr_wrr_medium;=0A=
> +	dev->io_queues[HCTX_TYPE_WRR_HIGH] =3D nr_wrr_high;=0A=
> +	affd->set_size[HCTX_TYPE_WRR_HIGH] =3D nr_wrr_high;=0A=
> +	affd->nr_sets =3D nr_sets;=0A=
>   }=0A=
>=0A=
>   static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_que=
ues)=0A=
> @@ -2171,10 +2260,14 @@ static int nvme_setup_io_queues(struct nvme_dev *=
dev)=0A=
>   		nvme_suspend_io_queues(dev);=0A=
>   		goto retry;=0A=
>   	}=0A=
> -	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",=0A=
> +	dev_info(dev->ctrl.device, "%d/%d/%d/%d/%d/%d "=0A=
> +			"default/read/poll/wrr_low/wrr_medium/wrr_high queues\n",=0A=
>   					dev->io_queues[HCTX_TYPE_DEFAULT],=0A=
>   					dev->io_queues[HCTX_TYPE_READ],=0A=
> -					dev->io_queues[HCTX_TYPE_POLL]);=0A=
> +					dev->io_queues[HCTX_TYPE_POLL],=0A=
> +					dev->io_queues[HCTX_TYPE_WRR_LOW],=0A=
> +					dev->io_queues[HCTX_TYPE_WRR_MEDIUM],=0A=
> +					dev->io_queues[HCTX_TYPE_WRR_HIGH]);=0A=
>   	return 0;=0A=
>   }=0A=
>=0A=
> @@ -2263,9 +2356,7 @@ static int nvme_dev_add(struct nvme_dev *dev)=0A=
>   	if (!dev->ctrl.tagset) {=0A=
>   		dev->tagset.ops =3D &nvme_mq_ops;=0A=
>   		dev->tagset.nr_hw_queues =3D dev->online_queues - 1;=0A=
> -		dev->tagset.nr_maps =3D 2; /* default + read */=0A=
> -		if (dev->io_queues[HCTX_TYPE_POLL])=0A=
> -			dev->tagset.nr_maps++;=0A=
> +		dev->tagset.nr_maps =3D HCTX_MAX_TYPES;=0A=
>   		dev->tagset.timeout =3D NVME_IO_TIMEOUT;=0A=
>   		dev->tagset.numa_node =3D dev_to_node(dev->dev);=0A=
>   		dev->tagset.queue_depth =3D=0A=
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h=0A=
> index c7eef32e7739..ea726c2f95cc 100644=0A=
> --- a/include/linux/interrupt.h=0A=
> +++ b/include/linux/interrupt.h=0A=
> @@ -259,7 +259,7 @@ struct irq_affinity_notify {=0A=
>   	void (*release)(struct kref *ref);=0A=
>   };=0A=
>=0A=
> -#define	IRQ_AFFINITY_MAX_SETS  4=0A=
> +#define	IRQ_AFFINITY_MAX_SETS  7=0A=
>=0A=
>   /**=0A=
>    * struct irq_affinity - Description for automatic irq affinity assigne=
ments=0A=
>=0A=
=0A=
