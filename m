Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6CF20D531
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 21:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbgF2TP2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jun 2020 15:15:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8612 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgF2TP0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jun 2020 15:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593458125; x=1624994125;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KNB/ynCjpfsxK2aVGgJs6wnDs7/gS/ryWrp6GLnsKo4hpB2FISetYka7
   T2qpuSfmVaPaUwVvpDdzUXNpJkCjzRfKS5xoUwSeP09RNqgApYiohS4CE
   F6KjH9s6qdjjxrFLH0F7TK6Ms7CewrEtHE5C1Q5QUcK97f+mQ5JQsEyNq
   fKe7rK06OKTkt7p8BuMJIWM1VoRluBVbqaaT/WGJzborQzu7Aha/crjUt
   A2pZPfl18/fdJTSPkpMaK3b/NcEu6MUYuu2uhrlwEARrgD8WjH6AFld9E
   H53B6ulS61TOtwZvalIjPiH+nFaLaZZjjfTysUd17xxXF6YbKb7nqwUFP
   w==;
IronPort-SDR: IS2LiAO0SEol4Ije24jnK9IPkYyOCyaAbV99buwZj/n3+xqHevY12PBcmr7lp+wJUGH0R/RxZk
 u9cTIr5CtT3Bc56StvHjV1Oruud6RKoVXe5oK0imgKH4bjMLmUrgWmYP0efUp9w0UlgCx+99ve
 u/sUHwn+bytwgUiCPzl9XbtkCiSnb0UcFo1iI3qfneYr4NWZS34V7OnQDLTpME+/cFhBIVKkEK
 MSmkL9j8Lzi2gDcr78lYdyxuzidAV40dk0VfcJ3GeLHGwqhxCbUM3rpgbC6G5JQswsiLqaSqyV
 Odg=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="145502239"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 20:21:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4VYOQcl/+rMe2J7YYP7LV3lfOpBK6SvwsFHfiknyMFU97RY7cvXPs5moCss8DLYhtkiejqwwSVmuf8bfXheHnZkSPPEh6QLcTPck810ZDxC7DzIO6/BV1bn7vPxU0ooVC3VlHkGrs1RZAa2C+JfatoEksOHsJz8FFhx90h8nJB+wkEPqMfwRNYU3n5teNtceV0TqMxzSyyKG4f+FTHjDYSOYkMZ6QYyTUg46XOiSwF9eLtagrNovmRztDfNQJU24dy9ObAjGg33Jsrr/wE1f3bzWkM+fxZkBBs5/Asth41ea22fiGJNtMToaQos6xDhCZm/9ly4cwyFQuvbpm0+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=N6hp7ShfL9jGNO5Qjfjcc3AqXtGjmdrpv8KNYcu6JABnIo+7VjXaQucQ3uzmVLSziOABnDpKGR/9CYpUFEkB/btN5/awhX6wpT/uSh88P+MwQNPlTA7FWtXvSOFcB5StxWIl4dav+vyhUvGXD6F6zojFvtvp67aLOniSTgcx0EAR3L0zfv7R/A8imdpAvwb3taQBUW7xQxgXODwjMG/za6xxfAzNVy84wRdzYYv8KzlKbDrbpGrpdrH0szB6Bfizidjc0OEoCQXVIVNh6/VxevYLW0o4nuFNY5Lq2JyVKY/ewMK9MnsUsDQ8vY6+ka8b2qWvmtjD1tt/gjLuZb4zqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=e6XXaqwH/NEI221yOutKAfjMub83xvaWufwWUpHUoKFVSSur9iyDWnA0TOcvVgqbJea/KeVssa595Ju6EI4KUwlC1UV/HTOLW5eq3u1mDN8lPWplCZdSM8UBylsITu9GTUKLL4DLYJrmyuUsSNnGYS8iwlqeK/shYqmrdpVEeSY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3808.namprd04.prod.outlook.com
 (2603:10b6:805:48::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 12:21:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 12:21:18 +0000
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
Subject: Re: [PATCH 07/14] block: merge blkg_lookup_create and
 __blkg_lookup_create
Thread-Topic: [PATCH 07/14] block: merge blkg_lookup_create and
 __blkg_lookup_create
Thread-Index: AQHWTFVFyCAhfw/dRUSuUH/1G+TpHw==
Date:   Mon, 29 Jun 2020 12:21:18 +0000
Message-ID: <SN4PR0401MB35989164D23E31992F6750F69B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200627073159.2447325-1-hch@lst.de>
 <20200627073159.2447325-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f645c3d6-7136-49c2-8a77-08d81c26ed19
x-ms-traffictypediagnostic: SN6PR04MB3808:
x-microsoft-antispam-prvs: <SN6PR04MB380864544A071F7E6B9430F59B6E0@SN6PR04MB3808.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3coz+RRRyb7dFeeqZ39NWuz5Q9C1yHoGdqvAVvwtgh76DTSclOUE7tx3DjF+nwGtYtElzFDNJou+l5yIU8r3+1RsvZmYdq14XGSnaLlPS5uwxyPUQ7zo1asQAeEAkqsK4d4dDhARlZLwZQKW5NHsCB97M8l7WNuvPPCU8Hmj58MqpW8epwTxsK3vBt6YQ3OG5mXcu52pUH0pWo6We7ai954X0LPtcf72oWPo06Y4NWcLNnkK9pPF0yuNrq9rdzmm4JsCpkkY1WvhU7fXnuTbXRO/FXMMqS13UWhHBQHdikkGjDbRoKSZtqyyVBCJJlXzEw4da9UBg1agyQa/JETQsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(33656002)(4326008)(478600001)(66556008)(76116006)(2906002)(66446008)(66946007)(91956017)(316002)(66476007)(7696005)(9686003)(55016002)(64756008)(19618925003)(5660300002)(8676002)(6506007)(4270600006)(8936002)(110136005)(54906003)(52536014)(186003)(558084003)(86362001)(7416002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: f32qXrTqTxpIGfyoXKIW7tytHNU1smODLqqk1KxP/mPO7Xp5bFX01WOwD3ptOIfkXxeiArEuPQ8wHR+pEXLMbbqCP9rHS6Qw+yXrQhDFd+E2xfB+QgsT3u8BzBQKBfsJ7EWIXcIt3N0PqXlrSajGLEmfeG3TTRm6G3t2KA8byN0vi8OERQ3HvPeGbxjOSDa8UcoVHdNPxxgM1hS4+GF2jO9wVRY3TwQ3UabqRHFTHwG2O9YHIndpQZEJwPNcOGIjZ8HKIwWoa+brG5pYweNr2pI0pmnWegtW2s6++vTa2eK8JYBSW1vPAGdVjomC7HvS1AyrejxV9C3Kqf3+8OcJGyyJuL0h9oUHjokK9ohgo9GB6d45MygAaDHdPlrEt9qA4I8s1JzwOENOF5spHj7dia2s/IpXgXzjLpeZANzOOfiQPcUS+4OOXoQpJYAvDP2UUpeaxjFmtKrmxHcVY+fVjhSkW35RHR/yNw6ZXZFqTq8vJtwkEsSmtNlrt6O/33I6jS1p15qOWkYpD0Eg3HZ38gwhz7w/o9J1YN9xSp8jLSeer3FhLMSgy69h7rJVFWlT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f645c3d6-7136-49c2-8a77-08d81c26ed19
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 12:21:18.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gsa6wn/UOuY8ZT+HImDR6SBKn1T2YzsKFO3K1vX6U895GG5jsHBoo0FYAjfdLO29xhJxp9vxAlMzKovtuBIkRDkqEv5V0qZablQ2b6S61m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3808
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
