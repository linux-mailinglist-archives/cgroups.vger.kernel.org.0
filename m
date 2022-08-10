Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4658E408
	for <lists+cgroups@lfdr.de>; Wed, 10 Aug 2022 02:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiHJAUu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Aug 2022 20:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiHJAUo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Aug 2022 20:20:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F6ACF9
        for <cgroups@vger.kernel.org>; Tue,  9 Aug 2022 17:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQXwQaI4SeNvlJgsW91YbMOREJHTNB+ohJBFPIiA4jYLxITiYYSG+pMZbrB9sxrYnCi1aL8XGQBYBS6DpsIDrcW4Eo0mQxNfmGR1gqhVo/FqLjr1AfYr3wz772Db9HKmRLFEoCzS+jMBPbORnNiMunZEfpbIS8c7eT/g2y08gNeGyOLWfnqI8CYrhrWT/xIr1uk9eK/U6ZeFf8JQhtDd73vx7aCkZP0avugGq65JGoqmZEG5V72U2887k/8l/gVP4l1NGmcztVKyCNwx1/JQiSK39OlwsB9TOd6k0xoOaSam2KYbnqoEntZxcA1QD3KXF5VZjGSRXfy2jTEO+uFdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBtC/p0FjcbEnYSW8nRkDVV0HFjd4Zho1yr0pMIiJd8=;
 b=gxWhz2aT2byCMy4NYnpaOY8HpgYIZxpIan8BY89nqE0CBjex6f4BwZzSpA4As2jQNsqBPZiJVe+MjEnpRGZCod9P8o0ILaP/i5XNBd53WVZqmJC+5Af1SYR84zZCDSTgpLKijmOBO37RM0izp/R+Nm7DfDCgju9aTR+twYcuP+JsGb4QpGTxD4zml+6hRoc0IP1HEuZpI9+Q8r2bg6yE9LX0W7//jw0m6JXLZvdFfwKDOM6y8PxjbnN6wy1X/x5AEJ4LVPHRR7gABPH4QX6KZkznTleyl7VpQgjDnXBb9xVS2UlOX3V/04LMiP0D6bbWw4oMJ+wJIVk+GPk4cyFSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.136.252.176) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=stryker.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=stryker.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stryker.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBtC/p0FjcbEnYSW8nRkDVV0HFjd4Zho1yr0pMIiJd8=;
 b=LKWuEG+KKI/ynIYu5XPg4IEfSbAfBeeQm6AIcaHv4dmwW6MyXvdQgMVMarH5B04Vy94CkT+nEL2PfCMIj5OnpMqVNtEWu+fz2NdQefggnC+Lv4Yx6FTA0kjmuUjz+oFFYqfuFO7yOzDsD9KLmWVC8BG1ASL+ESullSq+TYWB2zqvHKpVMAKVyHyzD/LD1e7K7M66DJtSI5zUD6LQJRmN6lO8Eu5XfYwXFHmcgXyaByQXxXo/Wsnde9R3m8nxWepKrl+LNLt6oWygL5t4JyiX1iNqTA4MXFz3x5xaNi2v9Cm/9r0kdwbkG8cPyyYtYehqOgtbo65U0kKrxjqUMeiR+A==
Received: from DM6PR04CA0011.namprd04.prod.outlook.com (2603:10b6:5:334::16)
 by BL0PR01MB4577.prod.exchangelabs.com (2603:10b6:208:82::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Wed, 10 Aug 2022 00:20:39 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::a6) by DM6PR04CA0011.outlook.office365.com
 (2603:10b6:5:334::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Wed, 10 Aug 2022 00:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.136.252.176)
 smtp.mailfrom=stryker.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=stryker.com;
Received-SPF: Pass (protection.outlook.com: domain of stryker.com designates
 64.136.252.176 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.136.252.176; helo=kzoex10b.strykercorp.com; pr=C
Received: from kzoex10b.strykercorp.com (64.136.252.176) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Wed, 10 Aug 2022 00:20:38 +0000
Received: from bldsmtp01.strykercorp.com (10.50.110.114) by
 kzoex10b.strykercorp.com (10.60.0.53) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Aug 2022 20:20:32 -0400
Received: from bldwoapp11 ([192.168.131.10]) by bldsmtp01.strykercorp.com with
 Microsoft SMTPSVC(8.5.9600.16384);      Tue, 9 Aug 2022 18:20:26 -0600
MIME-Version: 1.0
From:   <noreply@stryker.com>
To:     <wos@stryker.com>
CC:     <cgroups@vger.kernel.org>
Date:   Wed, 10 Aug 2022 08:20:25 +0800
Subject: EIN SCHNELLER UND EFFEKTIVER WEG, UM REICH ZU WERDEN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <BLDSMTP01roC6POYFSr00145df5@bldsmtp01.strykercorp.com>
X-OriginalArrivalTime: 10 Aug 2022 00:20:26.0028 (UTC) FILETIME=[FD0C06C0:01D8AC4E]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2114ac99-224c-4293-bd51-08da7a662743
X-MS-TrafficTypeDiagnostic: BL0PR01MB4577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqxekMHInf1Jf6eZUP1SW9gP5vYFf6OIzKEsgw1XKPZFqNL95dCStJRdZ5Dyvgh7Nm+r2KTZAye5EEwQMG6PeS5bQXr85VJzO5t384jCQ/0450mzlqUFI4wrK7JyplIDnY8/6+uobX6336sm/bIBonGZ3qH7yebzgZeBYvRZlAx1oU6p1bAOrAASEzrMZVbyhGQ4gYtGyFBetUaATOf5aJnavN+D0DdPYbRrgw+zsAhIeUEqfX7baWuemrfD92XvyIiBNgTUmDgsG8Tlc27KH5D3a1N+KlUgIC5JvP66KTM70V+srSN9GcHd8OEnvPz9CtYnZZt+oPlBvX3X6lrVJds2rBWTxUknvqFjoZ4hctMTwDGSlsU5xSFcVlAYTdM3asLwVTYSWnMj3dLDGvwE//j0j+VySGL/Ri7+5t7t4hONU4nkPSQreRQy5PJdewmD4VLHDM8WwVBl+oUArhtIhiVl/4FgCECToPJebVnaOLQ7fBqi6s6AEchsNnDXHdC/dEOJlkkZAFXdOCK2aijapof2YKyyyxpkOecnsgO9vQreAClXGO47+B0BEDK6V+dxFV4Ygov6M3fF4w7vrQrL541x/lQZ21r/cHEUc2Z5CgxXX6SZ4GoWpYC23Lh0ApXSRmaYmRVYidx/uLEq1F7pz5l99d3RMX57HH0xKXAdJy28bVS6h+NWXmRiMhNu6hiKjig/36b709UZkTm5BRuF00WK0IMqtThUlJU4bOoUo/asRC8iBhUHlNyOr6okr9MDViLd8fffRIlQWA2qe3kI+YecKq+fhENkfN++2eoas6MYThyQLhAXOEXzvudEPjee
X-Forefront-Antispam-Report: CIP:64.136.252.176;CTRY:US;LANG:de;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:kzoex10b.strykercorp.com;PTR:ip176-252-136-64.static.ctstelecom.net;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(40470700004)(36840700001)(46966006)(966005)(26005)(9686003)(40480700001)(186003)(336012)(356005)(316002)(47076005)(478600001)(6636002)(2906002)(82310400005)(2876002)(41300700001)(36860700001)(558084003)(86362001)(8936002)(5660300002)(6862004)(40460700003)(82740400003)(8676002)(4326008)(70586007)(81166007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: stryker.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 00:20:38.8631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2114ac99-224c-4293-bd51-08da7a662743
X-MS-Exchange-CrossTenant-Id: 4e9dbbfb-394a-4583-8810-53f81f819e3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4e9dbbfb-394a-4583-8810-53f81f819e3b;Ip=[64.136.252.176];Helo=[kzoex10b.strykercorp.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4577
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SCC_BODY_URI_ONLY,SPF_HELO_PASS,
        SPF_NONE,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

RElFIFdFTFRGSU5BTlpLUklTRSBLQU5OIFNJRSBSRUlDSCBNQUNIRU4hIGh0dHBzOi8vdGVsZWdy
YS5waC9QYXNzaXZlcy1FaW5rb21tZW4tdW5kLTc1MDAwMDAtRXVyby1hdWYtS3J5cHRvd9CTwqRo
cnVuZy03NTI2My0wOC0wOQ0KRm9sbG93IHRoaXMgbGluayB0byByZWFkIG91ciBQcml2YWN5IFN0
YXRlbWVudDxodHRwczovL3d3dy5zdHJ5a2VyLmNvbS9jb250ZW50L3N0cnlrZXIvZ2IvZW4vbGVn
YWwvZ2xvYmFsLXBvbGljeS1zdGF0ZW1lbnQuaHRtbC8+DQo=
