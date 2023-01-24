Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C18678C95
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 01:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjAXAJh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Jan 2023 19:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjAXAJd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Jan 2023 19:09:33 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27FC3C2B;
        Mon, 23 Jan 2023 16:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674518969; x=1706054969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HuWMV4ZQUcsxiaasaJMrNYOD8MZEWm7fDBH40ZxIv4k=;
  b=h03QDIQpRg4kLrdy/I+q/mjP3BcsIM1siUuaj8vzOSacwkO+QbJkKyEX
   r0F8MTfGzUOVfbn0k+niqNKbMl4zRuDyiFdkWFU95nTMwZsQXJmX3lRYw
   Sr9Z2P+4lMiaKMQ3clfIdLK0A9lST1y/iWWls+WYnZQWRFf0WiFcHRJek
   KG/vYbnQ2BXkYWPSKUPz8joDF7fTLyA+zKZe45LWeOVzEQ1gIpdauRBN2
   DqtkOK8lLwqh2lOeLy+jSFHdnUNqF0KIVDjeYqwJyiWitZJAxMkaX8cSu
   rxfPXSQ6M2UocopkNv3YzmPcCod6qArb9fEGL0wYBJXznGnHLqpz4+XJ6
   g==;
X-IronPort-AV: E=Sophos;i="5.97,240,1669046400"; 
   d="scan'208";a="325891853"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 08:09:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhrN3lmxvbsLmYAGHCssD149VNNmTGMSEH/66BQbAQt4h+a+Q4Kccf7t9q0hcehJBdD+9UT+Lisx3eG8gtBBlwh46aVbyzV31tTDAJ1QNGcEkLidzApQbVPQpQPlekERP4LtZHW6PTo6MZSSe7s96io2o7en6xAwhL6yveLyktgJ7YJwe4FLRy8dEls1p8kEwj+7sYdLm2Aap/WFRgoUi0zY4Hjj0jSod6hlkOT7keSUe/EyuzSetB0f/pScJNc9TGQDmUjkQIBxFjqiyxs88Z7YsZPAXmobB9LZMcy06QT8tgpwG3QDdYzzFo/B15sj9s8oAOmQvLbC0zj8soFcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/tipZoAlpuQrHapEU0k7KITm6Ygr1oWSQQAtecTwt4=;
 b=DF8tY7koqiMC2Av9zaGKWEA1NxD9wOeXmndAnpJk/0P8MqRhNMoPUtrFyfwM3NsNXq18bmg6hmPqX3ULrJGhbUcxr4LTSE04biAq/EAmb3RrYIVWc4Wk4ZDm3f8iwrJ6XgivxVKI54S8v9fYUObyTlYyfisUnRf4YFTTdIkViueUB8dYWUSb/omHBIEzYDwtgt2Eot9jfcl+NDSTmB2LN88r8hgHfAKy8+x3O8uQ6kKKc56oGc2/dAosq4hxScP+K2mz8BKAdQe3aeVfUSE194CjqraxP1RGaZ6tqSGlC4ncWFlUxkTdOekaG2XQ+gHKzzJLddKLxtQf8uMOj3PUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/tipZoAlpuQrHapEU0k7KITm6Ygr1oWSQQAtecTwt4=;
 b=klr5Ncqs6zEnEurci1Dqz6UK8xcVoAQlVba3rQktVE9jBYtlGtAj4o+3Kjc3x2d1GM7ZV5Vtnecq3n3923ZPlpWNuX6bbzyLkc+W9YbcgQvq+LlcnIRKzhHVu8yQi7kXY7V0/TmjQujVbegl79JRszsRFP2W6fJ49NXZ6+G04f8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7043.namprd04.prod.outlook.com (2603:10b6:a03:223::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Tue, 24 Jan 2023 00:09:26 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%9]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 00:09:25 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yu Kuai <yukuai3@huawei.com>
CC:     "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH] block, bfq: fix uaf for bfqq in bic_set_bfqq()
Thread-Topic: [PATCH] block, bfq: fix uaf for bfqq in bic_set_bfqq()
Thread-Index: AQHZJzA0qxnUmy4g8k267BQ5n6rMJa6swduA
Date:   Tue, 24 Jan 2023 00:09:25 +0000
Message-ID: <20230124000925.pfosl6pfuhjyggbp@shindev>
References: <20230113094410.2907223-1-yukuai3@huawei.com>
In-Reply-To: <20230113094410.2907223-1-yukuai3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7043:EE_
x-ms-office365-filtering-correlation-id: 6352303a-6f62-4f2a-458c-08dafd9f40ec
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hE90u2niqicGZNn/FlLuOltOZceuh+zSGJGx1mYcYcFI0yWqW+iLQ9GfqXmv8xtANLBj3swt2J/eZqzZrjNoX/NNL5IB/JZM8pJvnN57GJBDiW7ajPqtFaZob+wkl/j8EZpxTIZFimX/Ugmh7uNhjY2+ZdTPCwmlVuv/CzFIvyd3oRKCi7D6SzWTBymWGa7oHzObIvcjU6QOHMXxwtyqNXpqpnb4JXXmT4CsFY5qnnacHBq5yCou7cowhH/ozOuJe58KFvn59GpEY42mrB8O6XFnrphMG1rGz9V4y+Mo0ANeb6yvWsJ9oL05uYlW7z8HPmr4yYkKzQ0sbOF70dp4fy6OV8t6lcAey+HvZUvIDO6QbS2G7yg7r8wjuB5G0FE89gQ21lNqF2uepV13FDcWg7SM7sCCvz4qoEYErUNVfqYN/vhSgBIhB0/8VEOsKvYZnbo33KC9ZI9pJ92Jjobu4aW9eYGsRD1x8WC/yB1lFB1yYTyt+JPco6w3ipdV4vYxeBe2qqSVekS2ufau2QfavSUmuJASK+S6QHzZdhkTP6aDBRUVMsY/NkSe6sGfhgn/5TXexUrUa95cUcC4B170UqvnnfoWgd0Hu7my1rAfduy3ZSSBSe3eojtF+9T5p6/guU7jLEEAa3902321I66TRHK6XEsdXDigfWiImEvPDy7IIxOMe3JZMXSAAuC+qkJdG3t7YRS7WNyqo/DoqbBLyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(122000001)(38100700002)(82960400001)(38070700005)(54906003)(86362001)(33716001)(26005)(186003)(6506007)(1076003)(83380400001)(91956017)(66446008)(4326008)(64756008)(8676002)(6916009)(316002)(66556008)(76116006)(66476007)(66946007)(6486002)(6512007)(478600001)(71200400001)(9686003)(2906002)(7416002)(44832011)(5660300002)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kfaMqeaASTXjS3Z2hz8rT7kJm9oqYRG7o4w0C+8r1XPxeBNlJZkE3cCLosW3?=
 =?us-ascii?Q?BuB8sziKgCzBXwrwJG6ITq3NU9+Y1yxDlPJdEmew4v+Un757r3GgFPZkOeSl?=
 =?us-ascii?Q?6UPdtBBk5MqiBCCNCJrVlCLdqE6fwuHs0jf1o7eRCNVGp53Q5+5BCf1Qq3OZ?=
 =?us-ascii?Q?b9n1ae7xssomXEP7IfjNsnB89IRjdRBK9N543Zem89QLuKfTgAMBDmM0dB68?=
 =?us-ascii?Q?QgAXVccBIR1bBo+ixAPBXiVqqwApgXI+5/hmsKv8kpoSGjUTaMpgk4Ad/swl?=
 =?us-ascii?Q?w/gRpIsdzI6E3Dx75K0bLX51635kE6TxjDzJLMsI0wlaWD9VybywUNYkDzQo?=
 =?us-ascii?Q?MiKE75VzUTRFoEIoulkls57INA8TP5GeG64f2nOkKJfJ75tiZxfJdxZ9KbN7?=
 =?us-ascii?Q?35f0Aeur4+uWoZchp/VwAoS17wG2Pek4nelxut8o4fpnhXb9FsCJ7lEQwnh2?=
 =?us-ascii?Q?Z9OnC4LJayszjf3EH42PAmUS/9hWgwGUc/W8Q+GbZWpdJgTlK2k3lAsl77oo?=
 =?us-ascii?Q?WwieYESQ4s4GMqNyhLvA6xGmQ1vNirY6MxkXkQBciMcdGNeZvO7zgQCimcc8?=
 =?us-ascii?Q?6/RGrLl3r59PQvpPEwMNxfrAhb8sqNGxzqzu183d45QVuwcKw17lc6zC7Pnw?=
 =?us-ascii?Q?cnvhxJdlWSTPX1oae1KBwISyAlklCHh9G3ueNPFGp0nRJBEbB42idcNPDaXJ?=
 =?us-ascii?Q?fjKbX4L+q6OV+uUHewfCBrEInZ0iC/PTvbCfnoDf/FT3CS9pTa3EorNy8uKf?=
 =?us-ascii?Q?22pC8eFI8BTvQfAav1upQYiSdYpzWsHbNsDBhQIKGwC7Ep45OKpSTAlz/wIy?=
 =?us-ascii?Q?9uuoDQGqu/nw8uN0EtQMKCEnaU1nWpTXN24P9W52g2FEQQxBJ5BnJhTJqiAo?=
 =?us-ascii?Q?idRLn1NdO7YOcJBs3pjtScmemQAHjwt6j1TebtSViU2oP+4SKsADXGpmKKzE?=
 =?us-ascii?Q?RHVYKkWfxJ3sNvnEzFvwctOnUWU2W1dyGZ16SZL+TkmS9elWDx9FRD3dtt2t?=
 =?us-ascii?Q?Dg/NU2VK4GTYq8mJAwc4ZUbfos4RC3ilAaPGB61SXvFTHw3ay+2vusMIi5mi?=
 =?us-ascii?Q?//j928viGbPinjmQicJ+zGG/47IVY/PfTBGSZeTe+aHP3FaN9nebCHWF8jij?=
 =?us-ascii?Q?qGlOpxAdeHQYFlSoI/PfGfO7pWXufKEBLDjeL79eVErRKWztW52Tncy/AOam?=
 =?us-ascii?Q?EMpSeXy3RXBF0A1l/EBiQBUttPei86xI2LoOmx2mrw0MN3C1MBg5okxJspeo?=
 =?us-ascii?Q?GBj/5z5nl0mXXK/JhceXAEAH2Xbn3U3Bqh3OcYkBEBebngD3Cx0mpvo0OYMi?=
 =?us-ascii?Q?KFIQiiaiw+XL2QdCldd575ZmDMVtHSkEEEylCSjZZryMO3iWD/52CEK3rSHz?=
 =?us-ascii?Q?3UDqYuQq+TrwVyLW2LJ332Bto9Vn8Ftig2NKB9fCiSAsc4fuxnw9+IQ3KRzY?=
 =?us-ascii?Q?qYsuaZysxeUw3cDyrTdM71f99ZsyNtHG+IaU5wrkAze0jJQV1U0VWTSSkyT0?=
 =?us-ascii?Q?2gfOcppCZMWA8eMai0mvVYTO8fxn+ZISKK3IC5uRP6UP4wH7kq75WJ2XM7kg?=
 =?us-ascii?Q?wqBNuSC4AV+8ATjZ8Ie6FS5PKSTHWqjbPIHjwGAMlwxru9vC6j1ZDg/ttaLf?=
 =?us-ascii?Q?yHG6Vdzu5CrY2dcGQYCU3q4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C91E2F8801FB64D86D91C3DA08A2915@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?65mHBDWMGIfJP7UfFRYFOfx0aWpZ8Srv8OcT1JoY37p7OT4oQNhOhk012NyJ?=
 =?us-ascii?Q?660mBhcvKD0xNSJwva9Z5DMo7MGB4hXY3jfOnVaWwgPCRPkAeFToFrMHfg9j?=
 =?us-ascii?Q?526hr7blFMhMDZS1nD0lZhPJOT31r6S5UmIGLgZ/wbiw4eTYsE3hemPG2tHp?=
 =?us-ascii?Q?SGrHX8K4NXclAYEDOwRMX8HVetJmN/Oq2AJQ1D5Qd/RwsvqorU25qHZv37PT?=
 =?us-ascii?Q?+BUlYFqB/5iBmDY+3X4CsmpeJz1/DiTBSh1Gs8cQKV0PHswxCLmnHgKe1l5r?=
 =?us-ascii?Q?TvPZHVyFg8vCg2+842OXbFRAnNT/g8k+CeNc897tGK2St+8Z3ON870pFqTJs?=
 =?us-ascii?Q?sDrLqQAx00d04xmdZEpIBj57dgkgiN7W7im+DFNhLDzvSUPlMEVNS+SXgrH/?=
 =?us-ascii?Q?fVUPr4MmXZ47N9ZABJF+lV7hY6CWfoWEhmV2UKWkJd+GLH9LT5kzxVCGzjQI?=
 =?us-ascii?Q?kcYh84XwP8vuRsfnQ8335gopAQv0Pw47arEfYe3yMEaxtGXb4DRtKVlyOGsX?=
 =?us-ascii?Q?TMIWhXRuBuKxKDXSHhDD8+pSAdeJlM/6SSreOk0R90d7KdI0Dxc/XijDi6lf?=
 =?us-ascii?Q?cKfNe6ASvXTyug1OgDQClkeJln/bYaCmWS+ASb8I/c1NcTTpMLGS3yYE43Q5?=
 =?us-ascii?Q?xdzCmmagVxJLP3043/jOGJtz496vq/BkY5IvGn0XneMNKPl4STviJ414iYLf?=
 =?us-ascii?Q?0k2x+owJoC01zDC/7d+VEoO4vMCaWSD1/fwnqCRn2ivxH4Jp6XFNzDGGa5Pd?=
 =?us-ascii?Q?W8ZoBF0e0/x6zzL4K6g6aqbZsZWU6JAzzEKrxFWQq1ZjjlB2USe3++RE1yf9?=
 =?us-ascii?Q?q/jKXG1UoDQ+D1z/fUFelsspk5WegG57IaxD1Ib6EcEOLnO8BdPzLBbd1Gks?=
 =?us-ascii?Q?Dpd8Fas/b0gTUbCfbvDaRG5cM4SWLRZIj83xAYzBmylWjBJc8pHAYdJkzVty?=
 =?us-ascii?Q?JFS8SypZnWLQzZ4okBbHaBxN2Uh+EWNK/cacBB8mGJAjbDdlnqpj1iRWkbRa?=
 =?us-ascii?Q?b2WT?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6352303a-6f62-4f2a-458c-08dafd9f40ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 00:09:25.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZNKIsbDfvHyHrUNOzeJ1YFmDpeWbSv9oRc7oNmlv8jwQjQeWlu2r7UqcMypCwUGNtgQzXF8PWtmhOoOi2wbohbTki4BM9vR3H4HX9FqPmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7043
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Jan 13, 2023 / 17:44, Yu Kuai wrote:
> After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'"=
),
> bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
> bic->bfqq will be freed first, and bic_set_bfqq() is called with the free=
d
> bic->bfqq.
>=20
> Fix the problem by always freeing bfqq after bic_set_bfqq().
>=20
> Fixes: 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
> Reported-and-tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-cgroup.c  | 2 +-
>  block/bfq-iosched.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index a6e8da5f5cfd..feb13ac25557 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -749,8 +749,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>  		 * old cgroup.
>  		 */
>  		bfq_put_cooperator(sync_bfqq);
> -		bfq_release_process_ref(bfqd, sync_bfqq);
>  		bic_set_bfqq(bic, NULL, true, act_idx);
> +		bfq_release_process_ref(bfqd, sync_bfqq);
>  	}
>  }
> =20

Yu, thanks for posting this fix, but it can not be applied to v6.2-rc5. The
hunk above looks different from the patch I tested. Could you take a look?

--=20
Shin'ichiro Kawasaki=
