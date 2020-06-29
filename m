Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470EB20D218
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 20:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgF2Sqd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 14:46:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50424 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgF2Sqb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 14:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593456390; x=1624992390;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=RT/VyjQRDgRelch4juxWx9sHt/dZNDI0/y1PKalQgH7nRVgB182ZKkID
   n2PzqLa3tcqbA/CEAQsHUghMxEwvJgT3kbLsLdVaIrPOV8BiE5EwhTt0m
   9vXHQiNjVkuixPJspT4lek4EBfbNrBNmIK3C1J+ZAQGRRJJj1Nqc43gPU
   yw16MxH3gQyCt+rgKXpTy9vcM/Lj8uV6RngTPIAtIuJE3cOPsWo601OX7
   U3a1lrstuAWjbXKmMyzj5Gbbfhk4utpYo3OczSIMTKaupW/6qUIy7aMjO
   NSL7HZnpfpj+VkVXxjr7s8zXBgTlEwrm1/+GAh+GeS68Ljx9JzorMmtjB
   w==;
IronPort-SDR: G8lWVl2/Ho9vbr9IXJXWKGA0DIlQ7Xz2blxBbnscRHQvChGIVMwIgsR61CUY0P/8TDjrXOJLzl
 IocxJ+j4jkCqdwzBICFLmKez+vf9hTFzgAhTbAVXeQ/U0OtciHlmC2OmCEwgaoZ87UE2ej8EdZ
 ERk2yCHc+1zGBwrCDAe/3WHX4N0TSWVm21F/5Dv8AioL23nxSI8QtoZZ0+FEb7aiBxW9WMkDdt
 0628X4s0hKbNPIZ3xdIbSjaySuLU5BMww2bPKxUbtusKPGHf6wgmDA9tgux8GIeEOGCH3Z5gXE
 b04=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="141168408"
Received: from mail-co1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.58])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 17:37:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrZCgL56f7sR+ECsfzRuLjejUU/hYUZsCCbae32/gxxn2ZoxbLUWWFCv7A7LZ/O+aaUcjfZFqzSRgF9p08joJnMHcI3+GqI5rPboX1v4xQs73Bnn/Y+EsR3GjI5H2SWGQEO+gY0NOyhUSzUYivhd9WK82xy8R7O5HTXEVqNgXwcxbjzTic8/Zoe3xvcJ5Km+r8uYGT8+MTR0+3n8S41HcN/QnV/FE0yPyNumshySLtOcs6hgf6daZpjRNdYCL0aQFAehpPgWwMvBuTCKcUjpWkr95TAL7m6BKa9u46iqRGla7weZTHIUn455itxCEdphA791QSBh5NA6rX3V6nTqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XyRZVpTBwR+Q3gD1BidyXpyG8uKZy2N89KwtSi6WHx65wNANkF1ImY/C78lcAMbKFUJ1spEmNudlXqscMCklzniy6kHem/oD7hblDbl0OUJ33K6Lx9XLs7LAJHw3lgPAxtLMwERxDW7v2dBY2viXgOw3XC8voUwiFK/SBPOCBmCvvdWLpj3s6ml2VtcaDpPPhRxNLPbJ5qtCOdTtIZDVqQmZ4tVcJU+BiDeSAc1dpzrtSNbfMVxPcwnIrBqZhCxnXUobIokBLMFHStxc4d5Ls/poj4+TCTQIahk4zoWUpyooSU0956+iMIRD9i0mzyam3WDeudKPy4aOURrMjgPBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hnIWrnInmDIiqpjVCvC90c4VOOGGwIDEuENBb9ghHf7lQQuRv4GnWaA3wrS9J3+HoKFZ9FghoZftoaMLqLTyEiyG/2sM7+6UaB3T+t/Cl3iZ4C6N7EEsjcNd1PI6Slfb+yayJOztdvsZHnlj3UTELmk3uSRDwrbwfq9H5wP0XDk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2317.namprd04.prod.outlook.com
 (2603:10b6:804:6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 09:37:36 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 09:37:36 +0000
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
Subject: Re: [PATCH 03/14] block: really clone the block cgroup in
 bio_clone_blkg_association
Thread-Topic: [PATCH 03/14] block: really clone the block cgroup in
 bio_clone_blkg_association
Thread-Index: AQHWTFVJmZY//kRbkEWoTGTQSwlZAw==
Date:   Mon, 29 Jun 2020 09:37:36 +0000
Message-ID: <SN4PR0401MB35984B689047ADE7AC38BF139B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200627073159.2447325-1-hch@lst.de>
 <20200627073159.2447325-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26b06046-a41c-453a-73ca-08d81c100eb1
x-ms-traffictypediagnostic: SN2PR04MB2317:
x-microsoft-antispam-prvs: <SN2PR04MB2317A868B92AABB02701CEED9B6E0@SN2PR04MB2317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wefofk7NDPopjnjiK5bWNCmGlNtT63iYCXEo0+yzOUCO1tXSXgn1eHXMyALsgN6t4SN6YKsAmikUe1iP8TFR7Wpk96YwhfgZZEz6jFBet2WhR9nq88o9dhcvj7RrDfVLBvoO7eqoxEoYxfB/Oxb99iLLzaHoB3O5ezy9DEpN3iYKScjEWKWxOX+3pSOI5/cUH3ooAuFUSaMK6FftI/VkOOBJIY7H3KEEbORwRLA/10Qg+1Z2WCtuKeVShRYAlGiC936T87nDVHdF+MSWrINepwDmDWvddXTUmJZmbKQbS8FzTlrxqN9HBnpSrIVF/pguF1xiomNJXjyyamlU8WLigQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(66946007)(71200400001)(9686003)(76116006)(91956017)(478600001)(5660300002)(66446008)(64756008)(66556008)(6506007)(66476007)(7416002)(52536014)(19618925003)(55016002)(186003)(4270600006)(7696005)(4326008)(8936002)(33656002)(316002)(54906003)(8676002)(2906002)(86362001)(558084003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tOHSXkOEQk7uLjXirIRdVqVtq1qNVLgwC9vVts56XnfEMirayUufsYIzR4hKba49GjLjyhu5Lo6M8nMYQfj0wQ3a360kvYE1AMOQlSVFAK1glx8B+i+i6fOxBHh30T8M5XtxpeIEPsteYVZY9TvrhRpUsXbKjwCtVWsrOkcQuIJVIDiT1Ov0E7aSMPkOwjrxM/QVL5u/MxxoywqUKrM6FAMTJ8fbFQqCJwMxxYFAETq0ZSCl1p/ddAksPoCNJEMHiBKHK3cbD7L2vAwLWBIZlIbOsq1uPdct4NiWvjkV8OIKXt5SRrQuuKXGm2wVMY4HJUOL57QrDJ3R0M2exy+e9coJWQ0cRdZ/c5AbeZzoL7dAq9DqbQ2IkMPFfAL7ta0Tf4sDM8HjW5gNQ3W1SFOI8LD5q1ftj/cftKx/vqTlwJ9F7JSNprlchlzJr9DTdFEtbih6cScCE56Afx2ZGz0zEjysZOO8WQAiDw6QMC2ZPJe9Y+DKeSlV56Hvg8GcSTsOuhLekSgPlOCaLdBaa9/lAs5D8EljB2cD1SQObSKEIA0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b06046-a41c-453a-73ca-08d81c100eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 09:37:36.3820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjG7swyiSFH5jhCPd2WWd9faFCg7GEo0RN6zrcbN5PRKpzg00he3aTTm9R5aUz41V/FJohT+e3WskNPJ9AjeXrhxS8y/F7Aw9TPXiQDXmIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2317
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
