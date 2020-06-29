Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2378E20D30C
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 21:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgF2SzO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:55:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57271 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgF2SzC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 14:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593456903; x=1624992903;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4pBUNMg3VFjKVrGwnC4ohdxyekxz+h1fNlIksMD4IBU=;
  b=KprmURFraijooqVsxMSS1ETsBW8JmoQtfEmc/w0PDp5yFQcOOeX8EBFV
   PmEmCOabewLt7Ll06C0nr4irC6Bl0ZUzOYRrNh3TbnQQ2tH2ftq4M8ti2
   IAnfwFy1+Hfg95baI+8cJLFP2SGzse4SXnABmfqp87mjys5WHMHiisHzk
   82okW5eqZdw6Yo73TT7RgzeJXfiAenjwMBpX3oT1CN3QtolH449spN8AC
   UNKN0cnCIvbefHTKAxM2EM4EivK39YPSYNr3jAm5Gel3nZ4X1uZcoX25g
   Ff6kDusXS9qZG73m8ngTuvssa/TPTAOhgFS+joTP6L+vUJrUJnqc2LFmj
   w==;
IronPort-SDR: Y7XBPpzYqRBmjA2WuilWFhefGY//XoUNsVX7FCqQEs99gdk5eEYDjBz3kLAqvb+V2AhSIE+w0u
 VtwdGn7OewaY7Ufsv7SmX0C8rvjYJFVphToFBvZUx0oEyJRJAIVuNwz4Xm+XZhQEKA/Q44XN9K
 M/hVxa6Iy6o4D7yVJtbCLDAlDCPfAIbkTiHXH4jjL545h2xa6E8eK1fZTGaVJQ0GCJJbFj0tMu
 JJAdb3qQ1mCwpDTTY61u5VkZUwXa7qC/Wd2ON34cZA2nNfdPL6Hz2gIY2KG9tn6K0ZZBTYQ9YS
 gD4=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="244189572"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 17:33:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2LUkd7YtlzLq/TDLbk71wbGyfyIwOBNwkKR3F/th2ae8KgOV+vt9YN91mYg/vB2hA8rglWc50n5Y43Px4NgG7zEj5DxV73NNU8DVNohevvzdIghDH6LLLeIRLPtzDgn/dkQ0VaSD+6VLG1jtoWKC4ay55C55CHvF3oJ45qokGSMEWriRVh/wbvkaoc132tdsdlnA4RseTZExLLukuFOO8NcysDophpU6UL0klDL1EHHh5nh69M9nHrvTq+ylNSjarKdTD/KaE9259g8wsDlJkMMV3w0TWuJTsTvMSz0Zav0na8CedTQdofECVX6ZL6HBcuexZoSu9bjybN4FbFFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Rj6BoradiiHIAF1i9yj5Mq+a5UnPuCDyOKbOdKynlM=;
 b=WF/KBPhjzD3HMeL1f7GMk8evRhK1YzE4wyV0UQXvwF5a3Fa3MIe+gsLRPzATME3projR87hs9XJYghMxVKMd4XnPiK4trQPdyzOHS7u2fjuXBsdFxFOajFfiE50fwaqoZEIuPOwiABx3ktOKRlHwgH+BTHfATOp3iq2obAPpeIIJmGWEDqwyDGGGVgIQkWfdt/SmMoqyIZt14cv4m32r6eLh1O3wefcfU+ID3A/74yoF92MyObiIzHtIFYcZQcM54Q9GC/sKz7F2e12Ok0IqygOjieOcZTdLfgjqSpMos51+Q5CMMtU40MdsIzeYom5S0XIvtv+LSp9qL/qakwpvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Rj6BoradiiHIAF1i9yj5Mq+a5UnPuCDyOKbOdKynlM=;
 b=lgBD7eWE7qSUT9CKSz3LyXjiusjPNdOWq7nx3ekEaozwHDQkA2pOTyOSMUeD3/PQ/hN3p5JrAMwaFTme5yablz84eZQHxWRlp/OSieiwopihhWSTpZXOZhg/EhuBfshg5p75W3tnDlagvXkf1VLlsYxlc54Ssc4v/KIKLrRgrwc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4461.namprd04.prod.outlook.com
 (2603:10b6:805:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 09:33:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:33:37 +0000
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
Subject: Re: [PATCH 02/14] block: remove bio_disassociate_blkg
Thread-Topic: [PATCH 02/14] block: remove bio_disassociate_blkg
Thread-Index: AQHWTFVNaIwLRIH5Bka8FkGqn1pzlA==
Date:   Mon, 29 Jun 2020 09:33:37 +0000
Message-ID: <SN4PR0401MB359848B55D6E3BE7ECE717B99B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200627073159.2447325-1-hch@lst.de>
 <20200627073159.2447325-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61009f67-2e6b-4c0f-29ee-08d81c0f8022
x-ms-traffictypediagnostic: SN6PR04MB4461:
x-microsoft-antispam-prvs: <SN6PR04MB44613963613469B46E20D5859B6E0@SN6PR04MB4461.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q28bZ07EpmhnVTmqajiSWKV2ZPJCBU5sys/g5xcvbKHSuLrTJVGyGuNIFWRCmQD/coPZBpfM0p7nSgOPaIr0GpCqdovcj0gvomRKXHGq01EbK/mWCCm2oURXXVk0YuSfxJVJg3mlKxUWjF1ztc3ZVKff7r7uzHJNlYg4/2JWTdvEag0DItoD5X95htTu0vOJQ2OxQkJoQazeULvT8nvnLe4fJC/5iEKWOfSF+pViphPs6FSDuJ1L6uzw6nStZzovXbDeIlpHWq94TZPeCsWVxRwplJTfzZ1HTO2U12v81or3RBbnfwppbIGReeXDbT5p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(316002)(9686003)(7416002)(4326008)(33656002)(5660300002)(54906003)(110136005)(53546011)(52536014)(71200400001)(8676002)(7696005)(478600001)(55016002)(6506007)(186003)(76116006)(66946007)(558084003)(2906002)(64756008)(66446008)(86362001)(91956017)(66556008)(8936002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jkRI+nSY0ywkRiEmQHGKO+qoboZtdUYeqT4RX+K07a2sg2VAHa9Bq0P34qjQ19a+xusPMCKLkh/bg66Qg8zh7JM8y4xGTw6u5NcgojBBbRrqMgC+Y7g+AaL7LsuT4ucm35lg77cxAV4+rJZvagLjr4H2zGV9cezU1DgULfu7LV+lb2mPLO5FWa06lHuZkwd3saZkCy71Lm8hGqUztiV2wBPF6BG0juHEYPiwGVGQLLS+SoNftt28DMIRtc42DRBRl2uUQdDXihL7kA1X2XagUlmcCo8Efa0S8vGWGT6OUZL8wuhyvgnMMAjZBiGPB9wKEy1Lf8tNplgaKVPqUETwPbQVfqEIk8qnHTuDBKaUV0Pn070bBN5kAUDX5sn3tgtDkEns79RckQRGtMDoSLpH9l7tle7u0rK7g4czNQi5yxSMOqijvOw2sibbg71e4aj6k5/dP6hQ3G3iWODt1m5LvM3jmvI8KycORZNqrivl2LoWOnGKL4qYLcGH0H9TagA8dFLeVXfNr9bv/k4hCdqWXc+nZdeOI/xnecgAFniQOOc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61009f67-2e6b-4c0f-29ee-08d81c0f8022
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 09:33:37.1945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uidjJ+d+6CG7WoHL246qLqZmvVBYx/676I6F4ZXGDDNa6wsSx5IW5zr682ewwfuiWwpUTGvgnyu+d30uFvB9e5r1H0mGaMJpy6AxR8CxmGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4461
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 27/06/2020 09:33, Christoph Hellwig wrote:=0A=
> a new value to >bi_blkg.  Just open code the function in the two callers.=
=0A=
Nit: ->bi_blkg=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
