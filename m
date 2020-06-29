Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623A920D249
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgF2SsN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:48:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56654 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgF2SsM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 14:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593456492; x=1624992492;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Uw7Izt6162iIBwbdjjRe1P3eZvZmktbJVYB1oeO228NYTLV5v8xXl5vx
   mRAMIspayKFSpJb3/oOQSTQoPZdIkcilseEEVIHQVoq63VvAyFuxuQ1vC
   OgywiactaZVM7IPmTgj2nSnIuQuF7I13cpsHtzvSDD8DlpaY95SML5twS
   keomiuHeqlpJtLAIRnNQjffDr0xEOuUc9GOqFTs/EnT0Py3Ks1yMWQYhf
   jcgLltJnoDfqJhEQ1wz77QLd+FZqwV9FaN+k2jJZHVf5Z9AW8/ZAgwU4g
   c/zdRdCLv45bXo5o3Ki/YHrVupALobIy1A+KU/W2hTr0Yy7tsPXLppIlo
   w==;
IronPort-SDR: 6QwyszSzftixHlCSPXslHC6+OCpaMmQI4dKvWoBptKENRjhXZPofM1xmRVXWp3kC97P773fhVx
 otVULSI6wDcNSySYKAfBsphgkaT6aM0eOkVLPTrfX1tfeejVMUojqzM/8VZINEYiCtxzsE2vAM
 Hv7/6ZvUGtJx8icXy6jOAY0h4mtZ3iDhyznmk6NXDXqbrC0hrMrxeJMHtGNX7eWeG6xNxxF/Sa
 FoGmNuUEk2UALuhoSUJagqmdlmDabJ37nPGszt+QSaYCpLUXoc9W1WAZXOBGEd0vrJT2//GiJv
 6fE=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="141385251"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 17:55:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M93I6iRnfKRFya2q1cFCTo4iCaw9mOlnWa5d2uJNcUvzSReyDNOhVB/UtcFSC740nKK8Vvlwb32BV6Dn395oAHAomeJImp59IL71OVKk+LXhUw28Hz/GZWbzBBjd5+JErr2ulnL9t3nrdLlG57tKF0RWUPNKk0ZjJQokVXDT9NGvfH2mm8wqAlqYHOtY/Td43LT+R+XsQsXkXd0ljbHORT4Lo43lq4il3awMS1BpHzWpxtctrjhyXnoFbUvDCwgRKxJ2Y7/eJHs/9CaVeH+U2ANfP+2Qx+H4O+wdP8EsXiNhrPZ/Xm+SWbFZi+i9rfvehzuaejtDKbVc4wNd2kzWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WsszNX29SJcWg4lPJE6qN5uCDP755i+L2ppw0d43TbVi5l2/tCEXAqVEHIJecmzdP/A2hYNOmnyVtxs+H06Fz8Je2AXAY+UxmkTSAK6qXNkptEYToTFd5CuV5epoocyiqZb+YZdrlhIkCxIedojTsdYRoXuEPqWANQbEMRtqWDOCZ7hqVr+FxLz0qUg+/GrViTBtZaAbWexv5uaafI8DkVQVv7znUyKpU7TSss28Vg45TEx7mnGxKKKYn3YdhTz4yQmoF63YlwR9eiOXXUGPDHbG6GCAKqIjwiRPk8SD0CxWQZrOOpPH8PQEsvdapXTYHn87kCA+073ejzCrdCnQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=KmxFlPKLYbuEHBkv50vDZ68/wqMExgyt8iodXEar6ioT1fT9dxplz+gtmlKMUTiac4CV7UN6T5KP18LKo1YGrLuDUTR825kWsoQPkLExocLikRDbyadluYgkHCINaqoBuciC1GqT2e0ESiSQupyocyUYX4GU7RsvGu4gUttpqhA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2318.namprd04.prod.outlook.com
 (2603:10b6:804:17::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 09:55:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:55:31 +0000
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
Subject: Re: [PATCH 04/14] block: merge __bio_associate_blkg into
 bio_associate_blkg_from_css
Thread-Topic: [PATCH 04/14] block: merge __bio_associate_blkg into
 bio_associate_blkg_from_css
Thread-Index: AQHWTFVJUHZDzJChU0uNuEC9eMoBSA==
Date:   Mon, 29 Jun 2020 09:55:31 +0000
Message-ID: <SN4PR0401MB3598E2832843F2BDD9C201D39B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200627073159.2447325-1-hch@lst.de>
 <20200627073159.2447325-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 579b60d1-01ef-471e-221f-08d81c128fb0
x-ms-traffictypediagnostic: SN2PR04MB2318:
x-microsoft-antispam-prvs: <SN2PR04MB23183060DF309ACC2FF2FA0A9B6E0@SN2PR04MB2318.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNe3F8Rp/+OUn0YmnuUVIuDp6hFrw9SNICrnkKA0kSm0o2zurxMx/hf6VNmjbK/jwrd9eiT6klUf6Vsm/c3enez5plyfLrvm0tu47dHdLKwrXnEGeURlsTBccJ+Rsw7llK9ei6NxVCCvUWRgG2bxrgLP8iG/K5gBV4gdOZsDD1O75PChF0nwrcG4EE1OW1NyIx+hanmBEug10vvA7yHeetiXhQQYHjPZBAf+ch8BWKDIq2Sabq4p3yh1WOFB44THPsRHem/S26fa6Tjc/iqU/GfROm3jZ0r56J7VVbY3vKnB8m1HYh6t2MOwI16THnz8GdGNRSePQoMxM7qCHL5ArQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(478600001)(19618925003)(8676002)(52536014)(71200400001)(7696005)(558084003)(2906002)(66946007)(8936002)(64756008)(66556008)(66476007)(66446008)(86362001)(91956017)(6506007)(186003)(76116006)(55016002)(33656002)(4326008)(316002)(9686003)(7416002)(4270600006)(5660300002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eKmdBN50K9Q+hkV72BAjelhxfuvInTi71ui7eJYdx9ogxZ7o6snRgGtSq/wdAkeHhM80vd75Go5GZ/amhplq0H3NOK5Ee/QTMq4kirKE5NVlS/3J01zSo3FgPNi8mb8y9rb3fa+0UzUimv4TK9IVdIfrjaPrqUVpRZT0QWfX93+Sn7+o8aTj5mHe/tiRzrEWCkrIXztCUAIw0O+ZCLZG6nun+Fl+IR/FTYg+Y2aaxS55yGPekCcam0PErWv+cCLVlVX3v/07CCbvc7ILp0Dj7mMpPFvHP5rul20Q/I/vqYNKMmFlvNOQEmSOk1dO2R+6UwI42CkcSBrJ3PLJN7ss9xgtyKCjbEulImcRQ08ujIGUvCT517adqtDH2E/T5l97VQKQ7skJxHzSRafnqK4Y05WjHlwgHBdx+NdtmwvVh15Spc0yX9GyU/CjhSTocE5kxW9hqKme3jsq/LV6D8TTa9rcXfPW0WbpdN6YPkhy8rEP0PQy8EG8F8+EHa5ubFj8fJXcDH3dI/Lstngn7th8m9EOWiw5HZT1EH46gjS4EixGV3aa9d1ckre1BuxRpS3d
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579b60d1-01ef-471e-221f-08d81c128fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 09:55:31.7489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtZsD2RjXuU4IftaIh1d5NcbsLbckewsbUCAsR4kSfXm5Mo+1Oqi9M7jHunSS4up4YqK8ye4aBgn4mwerKQaXMmdSetYAprffJ4qkGFz/4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2318
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
