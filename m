Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31BA5B89E2
	for <lists+cgroups@lfdr.de>; Wed, 14 Sep 2022 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiINOH0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Sep 2022 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiINOHY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Sep 2022 10:07:24 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2220.outbound.protection.outlook.com [52.100.223.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085871BF
        for <cgroups@vger.kernel.org>; Wed, 14 Sep 2022 07:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpTWbmbbKhaaTbNpLiP+eLsIXDMSWx596HDBsieAqKfWKbrFXRYExFMADEu7DKPRsXiJCZhgpNzwXgF4Pwu90CoAWcFy2Zexz8VLMjpwXMLTEEmo1uEjwXrcVyseGRNjaTMFSsxPWlnEU13mD4s6ZIf56FYBQjV6doh3pzDwuGhPrGrzZUldM3vwNVSVqyMgz4oSomXivk50O0psIRpcscVN9wvNZ62KrWY7tdysHCIQvXoxZrIc7CDs8ob1Mm4ANOhJkt+Hjr/4hGiidFm4tm8tRQpVC6BfT3LFF8K2lzLP6WL2mgmnMhyKdluBHB0M57zS1fdHDu0iZYR0/EqxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs10Md+15nMnyayKLyd22Uv+/ZH79IcFcpzuzGLq1Fg=;
 b=HVAW8jEmJFHwN7PBzjuv9VhY+ERyIuQlmKBx8Y6FU0+J7lx7WMG57CZItmCowacbi8+7GQ0He97sJgGKCmjElhYCSqqS4QIcyfUOmlVrJ9RF8twmwGp4xBAOSR0q8qbTFhHdcXZ9E/K0T56jDg0m8+sCUWHZK40oRBgZnZki357h7uOLfwArRi0Bj05Yn/GhOehafG3FPeIHz1r2IF5dLFnkrS7bFZ8dBR66bZGxJYjUJhZEGiIWV/lF0bv100QWryaPo+ZIxs6Z00/G5AMkGPmYDHENTYHw9lUMheQStZoHG0gOUTvQeoD+0fg0XpaHEqNi2SfqeKU1dLKbo6jfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 37.19.199.139) smtp.rcpttodomain=calacademy.org smtp.mailfrom=t4.cims.jp;
 dmarc=bestguesspass action=none header.from=t4.cims.jp; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0013.apcprd02.prod.outlook.com (2603:1096:300:41::25)
 by PSAPR04MB4311.apcprd04.prod.outlook.com (2603:1096:301:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 14:07:22 +0000
Received: from PSAAPC01FT064.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:41:cafe::7b) by PS2PR02CA0013.outlook.office365.com
 (2603:1096:300:41::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Wed, 14 Sep 2022 14:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 37.19.199.139)
 smtp.mailfrom=t4.cims.jp; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=t4.cims.jp;
Received-SPF: Pass (protection.outlook.com: domain of t4.cims.jp designates
 37.19.199.139 as permitted sender) receiver=protection.outlook.com;
 client-ip=37.19.199.139; helo=User; pr=M
Received: from mail.prasarana.com.my (58.26.8.158) by
 PSAAPC01FT064.mail.protection.outlook.com (10.13.38.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 14:07:21 +0000
Received: from MRL-EXH-02.prasarana.com.my (10.128.66.101) by
 MRL-EXH-01.prasarana.com.my (10.128.66.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 14 Sep 2022 22:06:59 +0800
Received: from User (37.19.199.139) by MRL-EXH-02.prasarana.com.my
 (10.128.66.101) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 14 Sep 2022 22:06:27 +0800
Reply-To: <rhashimi202222@kakao.com>
From:   Consultant Swift Capital Loans Ltd <info@t4.cims.jp>
Subject: I hope you are doing well, and business is great!
Date:   Wed, 14 Sep 2022 22:07:06 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <19e24ab6-a299-4d34-bf65-e0172291686a@MRL-EXH-02.prasarana.com.my>
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[37.19.199.139];domain=User
X-MS-Exchange-ExternalOriginalInternetSender: ip=[37.19.199.139];domain=User
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT064:EE_|PSAPR04MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: e693429b-c9b0-426b-ac1d-08da965a7167
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?windows-1251?Q?VAjfK5xzJF9OFeNvhmJ5F3szQDVqrIqYbjtn/aoYb6JR0w04TTZVcemK?=
 =?windows-1251?Q?jcsuQmHNDH5LTHTPNcN0PEZdmcZOYrxHSV8EDJG/MoaBIqWPpEKDNp7s?=
 =?windows-1251?Q?hJwG7hqtcD1MZPu3UylcT91IvvFiHTftPzIYN5a8PXmohMBvzE3A7d6u?=
 =?windows-1251?Q?3TdJghDmVesagVFtcytXiaWHqv6CvKByCHwvgMP+sS53eaKc6jWFhvkM?=
 =?windows-1251?Q?VERzzKeNoMQtVa/7zj/EF+ga6C/cGEQiM6QGJNW7i4F6JZk2ukQRbLEh?=
 =?windows-1251?Q?U9D2AXlO6LQ1BlkYcKIln9fFZ6THpnTOpVGlN6KtPHE3Q7JzMRuTDJjN?=
 =?windows-1251?Q?2hRn5F1r9Tt7xNljC96K7CxZCdjqJASBPmBkFEx+nyBvZGik6Uf+tR4S?=
 =?windows-1251?Q?u90RyYSrcbmgfm3fPO1Eexgl6ENfiYQkJ0VBYXKn+B+YFMK1OV+g5hr2?=
 =?windows-1251?Q?we9/TwBWF8v7JcN2Pd2AO12JUTjkwGZcWHzZktY3VicLp3BLbIQSQ2ut?=
 =?windows-1251?Q?AkiuCkbkw95jHlUr2qZZzJFOVF/SlJLaq5lDXqlA6ZC5jDBE3DgNN49u?=
 =?windows-1251?Q?mAN3l8J9/nZEtW/ICLvrODqrcdzJm5QiIYzB/oc/oTNCTEu8MxLGjkTk?=
 =?windows-1251?Q?+27oAkn6nHlFz19bS/tLXHKjwWWUM2fGINXnb8MEc+iraL4utPfPlkk7?=
 =?windows-1251?Q?MtU2I4MmWI7mzuaK5F1ACl/vHS8j4tY07EdBgOcL0qdwRlnwS6WNFsUg?=
 =?windows-1251?Q?Qd7zIAIvcp9znskQsC/vhDjxDh9j5FrCcYvQZ6kGkTBWbZgZ7TTpe0kg?=
 =?windows-1251?Q?O+8vXr6Ecvxo2CkUivJrb75ZgDFbyFNON61uonIYlWP0GmjAWhS3yX+B?=
 =?windows-1251?Q?DpEKDmxZfU3f6Zp8J/Tji9FWeeSomzJ9jIL/LVqbfpYmxHK9KflGE/EQ?=
 =?windows-1251?Q?tA8Ehj82M8tW7asrhmoZQAA7qBIv02K9iDcKJrtCXyOssNXjHhQfMQs4?=
 =?windows-1251?Q?5s+TjByF2ABGU94kPBL1006XnGspMb24QCCfbUdh7XXKlVpEciJ35WDT?=
 =?windows-1251?Q?sfIwVj89TJhVqkKTLmYkGGercwCXhdBQqusR4OqCysO00LeYoru/dUQc?=
 =?windows-1251?Q?8/B2leY1ittv2uu8KBR+HvDu42+NLb0ylDyIFiTfVlEgDzcKwVU5FODr?=
 =?windows-1251?Q?8GYOUlqCJjvTA/rI3hvKY8sJhLErG5pb2sVU/JtWDR2mhjlttHmVD4lF?=
 =?windows-1251?Q?XrI/Dvd5Ipv+IGUVqNrBWlZaa15ROMgtI2o49kR/hUqfcNOhPtWNSnQp?=
 =?windows-1251?Q?jz92lNK3RHBzq0ayALC1UKVMv7shJgS7+eKqE55R4i2TlPku?=
X-Forefront-Antispam-Report: CIP:58.26.8.158;CTRY:US;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:User;PTR:unn-37-19-199-139.datapacket.com;CAT:OSPM;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(40470700004)(31686004)(40480700001)(4744005)(7366002)(7406005)(7416002)(2906002)(82310400005)(82740400003)(316002)(8676002)(35950700001)(8936002)(86362001)(36906005)(31696002)(70206006)(70586007)(336012)(81166007)(956004)(498600001)(26005)(9686003)(156005)(32650700002)(40460700003)(32850700003)(5660300002)(6666004)(109986005)(41300700001)(2700400008);DIR:OUT;SFP:1501;
X-OriginatorOrg: myprasarana.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 14:07:21.8626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e693429b-c9b0-426b-ac1d-08da965a7167
X-MS-Exchange-CrossTenant-Id: 3cbb2ff2-27fb-4993-aecf-bf16995e64c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3cbb2ff2-27fb-4993-aecf-bf16995e64c0;Ip=[58.26.8.158];Helo=[mail.prasarana.com.my]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT064.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4311
X-Spam-Status: Yes, score=6.2 required=5.0 tests=AXB_XMAILER_MIMEOLE_OL_024C2,
        AXB_X_FF_SEZ_S,BAYES_50,FORGED_MUA_OUTLOOK,FSL_CTYPE_WIN1251,
        FSL_NEW_HELO_USER,HEADER_FROM_DIFFERENT_DOMAINS,NSL_RCVD_FROM_USER,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [52.100.223.220 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.0 NSL_RCVD_FROM_USER Received from User
        *  3.2 AXB_X_FF_SEZ_S Forefront sez this is spam
        *  0.0 FSL_CTYPE_WIN1251 Content-Type only seen in 419 spam
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [52.100.223.220 listed in wl.mailspike.net]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
        *  0.0 FSL_NEW_HELO_USER Spam's using Helo and User
        *  1.9 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

I hope you are doing well, and business is great!
However, if you need working capital to further grow and expand your business, we may be a perfect fit for you. I am Ms. Kaori Ichikawa Swift Capital Loans Ltd Consultant, Our loans are NOT based on your personal credit, and NO collateral is required.

We are a Direct Lender who can approve your loan today, and fund as Early as Tomorrow.

Once your reply I will send you the official website to complete your application

Waiting for your reply.

Regards
Ms. Kaori Ichikawa
Consultant Swift Capital Loans Ltd
