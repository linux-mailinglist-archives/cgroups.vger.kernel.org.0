Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3158167535A
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 12:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjATLXZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 20 Jan 2023 06:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjATLXY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 06:23:24 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2070.outbound.protection.outlook.com [40.92.48.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5D545F58
        for <cgroups@vger.kernel.org>; Fri, 20 Jan 2023 03:23:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS0wu4y5rtOXF2SeHp8ftjmLlaYZ38yj2ElBk0XLG6Kz7uQRcdRbxbhFGe7Ui52xQvpLnQXOPyctgzn8OQQWnb54UHkmketwvc2jKewYJhUWR3EbSPF+ZthlxEr2j/CCyoZ12rv58L6vUp/Q+VPYwyYSx16FkdwK7fD1hrpYdh+htlr45A6YE7JiaxqwHvUONsPxuRYKVw407pYwPGOrhkIkomxgE0nDCN+DN4a1ITLEuZeaMqcjJH4AIUy9ZjNaymvaqcbME/doEuBtjBOIpb0VDS/Wpmw9hc/8pac+MECxoMKr4stnG+WRkXmeRqTftWDjHCYuk11O43gfChG21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtmzJvyiELb7UY4BPW38dy6/nG54JEu0GKGVKO7M+74=;
 b=EBO1QPoxzGjqFgTaHPnLC8sbJYOmsYJ+QUkGEUDilQX3BQzo5E0SWdotfhbMwhfH1qNWNpnFgfirPIZ4WKphjN6RzgiyiMpQNcGeYkiL3KpFQlOJoif+sb+M9XOJppCNiDjWk3fz5Ajxya9C4AlTsT+LPpmlYd3o5KNJVab/m8vd2OpQKXRI8GchCsBr7krpjs/77tby+49Q6OmjseTFd+UhDKs+0D9HlIqlUIKocVzSlfkz5h5S432syd11YnnBRv/GMow6QJiBuv9Ok0xaOGsZlVwCyQcd+JVvx6/QXxLGj7++N0bpNRkrh2GsNof3fwM0y6npCHpPG+jRvVtK9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM9P193MB1649.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ec::23)
 by AS8P193MB2286.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:440::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 11:23:19 +0000
Received: from AM9P193MB1649.EURP193.PROD.OUTLOOK.COM
 ([fe80::d455:d780:250c:f020]) by AM9P193MB1649.EURP193.PROD.OUTLOOK.COM
 ([fe80::d455:d780:250c:f020%4]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 11:23:19 +0000
From:   Maria Halonen <ubabk@outlook.fr>
Subject: =?iso-8859-1?Q?Unser_lieber_G=FCnstiger_2023?=
Thread-Topic: =?iso-8859-1?Q?Unser_lieber_G=FCnstiger_2023?=
Thread-Index: AQHZLMGK6HfyxqrB2U6wZmtSQE+0Tw==
Date:   Fri, 20 Jan 2023 11:23:19 +0000
Message-ID: <AM9P193MB1649605E1890D0BC48D9622ED6C59@AM9P193MB1649.EURP193.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [ZGfFOvhiGtaPaK7gfii+nBSGVBBkb0j1]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P193MB1649:EE_|AS8P193MB2286:EE_
x-ms-office365-filtering-correlation-id: e7868f9a-96c1-4349-bf77-08dafad8bbaa
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAWbM6Igl83OSMgY7KdrRTE1xbUzrMAUmptZRh6KjkbaOhkbiM9lN8AXjZbaiLmxmBUpiQfUbXkNNjVOi+QaanMDCF8yotnLoMNcp1QFrp8EQ4ags+2xz8vdVoBGQtemo+z3WSn+jDeus1S2f51JfAHIjfBs6Cg0TdHLdLbj1JjvgHXoMP7SxrFBZjQImIXzacjyf9VqN0iUcxjucSwiPG+igJxzR2QyMNv/6FsEi5hiPz4BTLvBNcXB/4vdSncTpvTYkLrnsgwXft/SAkTfuU/Z0g7QT/YL6jws2CDVOGTh5nBgdYcxxTi19OCM3AAy8PSGyMgnoZHt1aK/XxW2R2gA1+ywudMOEydOU01okymVXtd5da63NZkwoKM/Wt6opjxlPvq+fLKBrWj0vqH/RmuZGH+/uDsxeaIpKw81Z92yy9UzG3vXW6TZE2Fdlgn58PLKpAu8G49hKdgrjl+Z9MaRD9EofFzVvzJm6Fq68yZxptlcf4bCORnkwmoecPVww+QydaMRmik6jMgqlPjNQa/n6KafRUr1hk276v/6NbjUuwTMXvmvAfs3Rgd2gohKvEcOQoHLOZdhSszLaPYzRw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V8C9YlhIYOZcAyQhWlDU95FzB0+71qBcj3s+mwM4bDPgOXm7Bh3tW3OCF0?=
 =?iso-8859-1?Q?KNcYNEIwrb9J3i5KGv8y2+/G3GpAzHlsHSOY9tLQ6J0G7J7y5+161LkW1+?=
 =?iso-8859-1?Q?k1da3KaZ8e7+E0mZ+sA//21mTbyEIcpYvzvEF+P/7UAEwnrOkyekpVaUEf?=
 =?iso-8859-1?Q?RxIP9agIa3WysQYbBGQxhA/AuqL37FACci+xz/n6NRa9dl/WRAaHjYcIjR?=
 =?iso-8859-1?Q?9eQl8vdM42skHhFXSYQt5ldNUHLVoGk3ZGvrG4r669YGlwzv3fdD02x7sX?=
 =?iso-8859-1?Q?JTr99dW1saM9ostIVj/SAagoVT26r80Gk36BnSyfoSU+an9t3DW6hoS6HT?=
 =?iso-8859-1?Q?LJBAgNhsH4l2aZsdSvF37LII+N7DNzIKpp7ZfuxcYbr62qhmF6RoKYLv7h?=
 =?iso-8859-1?Q?3GC/Mz+2iMe7PMZUnkt3qeTtz/56dVvwFbm+Jh2Gl/V8G10INZ/zufoj3M?=
 =?iso-8859-1?Q?FKNvQu9ayg2f5fbY06VRwufKAJvsUUY0ZkyklqN5ffUA1GALENwY4eMAuQ?=
 =?iso-8859-1?Q?WRbeSORDKJuGdV2KcW/7m/1lTr8MUb4jvJ8dxQFvf/PDJf9bYuq3kMu3a+?=
 =?iso-8859-1?Q?L1bqws2BAbqC1Hl5YiZ8loCCklKY4FBZo74j+fMnHhd/voOoOHtnc0kekH?=
 =?iso-8859-1?Q?ktLMwGuRF6balkJ7mj+8W12PQIOEMssPapfcqgEwI4yofKWhULH2fQU6WM?=
 =?iso-8859-1?Q?MMkvoLPUY55wnBqU6t+Vs27EbBoSjvJsxut2e1fqkpp24IcoU4xDBWyDyY?=
 =?iso-8859-1?Q?EIkEHmVk1R9EPi0yZblyyQs8Pk6BoQ74DxT/UEI0YFZ3mrR2VJs02M2yan?=
 =?iso-8859-1?Q?xgN7fJoXk9nMonHYn6g6/8Y7pkZk2lwGBoYjXxWB4cnpB74ED6KDgqBNnb?=
 =?iso-8859-1?Q?02sB4EUu/i45oeq5O4MmqCmTGqfLFQk5+B1tcIRs4H5MNcewMdRP3fUxyU?=
 =?iso-8859-1?Q?DbrQvex53oRbk7myak1Cr4iE7brM8cOwOKJShTdkNU/Fx50I3s4DupbBtH?=
 =?iso-8859-1?Q?npWFaOpugPjfxZDKLi7ap2Tly16TxoZAsOlAl8+JNmkkQnaZOXWkqtwHdu?=
 =?iso-8859-1?Q?WwEgkSKDtff0nOEDkZeXqaPnub5WpxVZT+Y3U6y6BN4Kbzwox1r2H31xTk?=
 =?iso-8859-1?Q?Jzc3YQYqi9no7Ta1yNyVn3DdntXo5WulXdqXSbP1n3+ATKUdM8bCfIBwN/?=
 =?iso-8859-1?Q?Y2MSrePbt227uhDopsz8zP69XAzpU6gGanjRjVF7n8Z8wk9emHFsN2cRhG?=
 =?iso-8859-1?Q?GSq9vh+hvI6Na29HQBoIqMcxfwtfIm6FhRsG1EXGGhZpzwqbKOGiQOZ7Cv?=
 =?iso-8859-1?Q?4yRP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1649.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e7868f9a-96c1-4349-bf77-08dafad8bbaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 11:23:19.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2286
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_50,FREEMAIL_FROM,
        FREEMAIL_REPLY,LOTS_OF_MONEY,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Unser lieber Günstiger 2023

Darauf haben sich die Vereinten Nationen in Zusammenarbeit mit der Weltbank geeinigt
spenden Ihnen die Summe von einer Million zweihunderttausend US-Dollar
($1.200.000,00), nachdem Ihr Name und Ihre E-Mail-Adresse über das Internet übermittelt wurden
International Monitoring Group während der Ausgabe 2023 der UNCC-Konferenzsitzung mit dem Vorsitzenden der Generalversammlung der Vereinten Nationen, Seiner Exzellenz Abdulla Shahid, in NEW YORK, USA. Dieses Zahlungsprogramm ist für Wohltätigkeitsorganisationen/Betrugsopfer und Entwicklung organisiert.

Sie wurden unter den (40) Begünstigten ausgewählt, die empfangen werden
die Summe von $1.200.000,00, die dem eingerichteten Online-Bankkonto gutgeschrieben wird
für Sie bei der Bank hinterlegt und zur sofortigen Zahlung freigegeben
Sie.

Ihre dringende Antwort auf diese E-Mail genügt die Weiterleitung
Zahlung von $1.200.000,00 an Sie.
Für weitere Anschlüsse wenden Sie sich bitte an den Zahlungsbeauftragten Herrn Jean Andrea per E-Mail (
wl2505556@gmail.com )

zu ihm schicken
Ihr vollständiger Name,_________________
Adresse: Zuhause oder Büro____
Tel: Nein, _______________
Eine manuelle Kopie Ihres Ausweises__________

Grüße,
Maria Halonen
Entschädigungskommission der Vereinten Nationen
Verbindungsbüro Ausgabe 2023
