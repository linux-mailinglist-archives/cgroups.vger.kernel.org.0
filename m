Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D403B7973BB
	for <lists+cgroups@lfdr.de>; Thu,  7 Sep 2023 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjIGPaJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Sep 2023 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjIGPWB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Sep 2023 11:22:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651711717;
        Thu,  7 Sep 2023 08:21:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3879K2RH019609;
        Thu, 7 Sep 2023 09:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VMf00UbFBSXJ39KsE6ttNP8iTB316kppBLMUruDxTcg=;
 b=tbP1KMkZacdUNtRilViMjaTjMLIgwayXKQyrvM5ugr7EUJ+ykT/9+ULY+WC9KCXKlvJN
 fRMHYHn8QErskOVZViUI0LX7WlblYkLjFNvoOfosQ84LgGRByXlkQShT2Rei6GS88b/W
 vAmCl86O89CTNom4La5D3WyQc+lf1iB/BB1MmPmNGnHj4UI1iS172D3QRmQWAFfA0bxS
 MDsHSocfewsLFSpJ2rFUNtfXE+GfoQrKc7B/j+bH7H3lFqVw0g72RBcQs4rMLDUSICfa
 O5VqVqwSvwiMbEyRpKcEqtqExwrmcpYbpHQpdAhFmIYoONneFpPYA4n4+TnLQgbWjfXr xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sybsrr1w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 09:51:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3877dukO010429;
        Thu, 7 Sep 2023 09:51:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugdr6vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 09:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHPFX/fNkNHJ04Y64mrFCDQ6WKwRZlK8xk0Mesav9wHZd3ecel8aP/k1AturGdflvecU/uJdk5jyUfzfX3oSUlSApZRUrzgxduUjOq8PIVl+HnFOshxyaLU/DBDHUgBcQIW1Yct1hdryW8+S/BMK56iNvJBIROfBjLLVeOyOMl9+UkA5pUhO7thCqE7shfRyZsL0mmecQw/jEQHyImJrvW9BOkY/tv6E/Ldtwjx9dlTeuiPgdSMSjk6bVZsItV5/koY8HjmYT0hPwbFJM9Fl3CjW/VbGhVQyNBXVKXni/ZKWuP42rX3mURrYcBPmgU78TafJhcFowMMW2vDOGnv+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMf00UbFBSXJ39KsE6ttNP8iTB316kppBLMUruDxTcg=;
 b=eaexbHPFfVsalzecrDwIdDhg/IZR1J/VNxgrcYY9T3gXk8ssRVQQePiFxtfRvEiqdwi42FMMtoDdAqAieDC9BK3JWAP0AKZiNpWwAw/sZ62LX77WMufjI+5GoVeytBKlAThDG0BC29IEl2KjdBOVChubZyrY38GpSzryaCi6A+nm4PvWVTX2uWrug/MiPaYorz0vJQzPCCWr8uANl1Kc+bq9L8iIsJHgKkC3hfIrIvwA/R+sdCEn8DUkc6bZumxtbIr+DnUjmAOqpdQluRK35cYtnOswdbWCtbLWZEOipO5ZEceoMjT5UT3t7TthTE+tdqVVjiNc52XzIgtX/2rFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMf00UbFBSXJ39KsE6ttNP8iTB316kppBLMUruDxTcg=;
 b=IBmEdIHWWJSOet6sU/0JLtIn27euKjZ2gwPi7Wr2q2nkbzMyoCwUkN4rbuqkwShjRM9KYSOENcMpweqflI7o5zC/hIQH5AJxTejGktsrQM+USRs/eupP8kmKSwna+6EPzUeDjKPdhbW8aFYOH9SRpERp7YKZWv1YV6oKilYA31s=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 CO1PR10MB4675.namprd10.prod.outlook.com (2603:10b6:303:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 7 Sep 2023 09:51:51 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::3c2a:5677:55fa:2d36%6]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 09:51:51 +0000
Message-ID: <a88173b8-0d87-37fe-3c4c-bd1d15d3f5bb@oracle.com>
Date:   Thu, 7 Sep 2023 15:21:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [External] : Re: [PATH v2] cgroup: add cgroup_favordynmods=
 command-line option
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Luiz Capitulino <luizcap@amazon.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lcapitulino@gmail.com
References: <20230906005712.66461-1-luizcap@amazon.com>
 <5487ed0a-8483-0a92-c7c1-9ca3ed8e6162@oracle.com>
 <ac50c7a3-c2af-26c1-cdd3-0add6b299994@redhat.com>
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <ac50c7a3-c2af-26c1-cdd3-0add6b299994@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0217.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::13) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|CO1PR10MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: ad396069-24a4-4d61-d46f-08dbaf880f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/ghYKOSxxhE+J8boux8eiRhl/2Bd2Gb8teuG1LgHM6jYt/goxJX6utCe6muPG7wJHAnxJ/tmOH1qzpZwB49TKeR++Odgfa7hiBC6R5nA9n6Aas3lN/TBR4YcW41eHZZT61MAa9fjVu4WJdcVMkzqdcMi3dTxZwfJgWvl27NzInu2vJgEFReY5RR2fPIyFDvJx25dJ5vSuP0d3MXhoCmggKNj7ZdO4siDbq/5PTp3A3VjIY3ZRdrJqZHrTmWlcZFgAu2/HgQhMndlwZE40sbVt9yajNZ0Zu+/xi5nT0GEsEISl5l5oHl+qjn1/KtLFAmM0HwPknQr50fCdQUJrg/MeM5dAMRhY2RuiR5qL+yLwk2qUY7U1fROy3NjXQ+F67e/bSMWiatrUMd8X/RSwRebymHVoMnFf99YgPiImGJj76u6RDzhh5WRnPPQE1qABRiaAAR45tINkqIdkQpwpN/7EP2opUBoEDUi4/8X8ww6fEYZ5Kt+cJM0pRLmHQ/9m4HNVHXQPOof1IzJT1k8a8ll3eyoWUH2thIhmU4FxHFP56Ezug1gcAq2i9f02a5i0tigBZY1mO5TWZl1IkV9FmLlguaODNpcvBpW+LZX2FK/92r4YiTUkxabp8nUgQn51VVe7Qz9Kh/VKnzJH7wAa/axQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(8676002)(4326008)(8936002)(83380400001)(478600001)(66476007)(66556008)(66946007)(110136005)(53546011)(6486002)(6512007)(26005)(6666004)(6506007)(41300700001)(316002)(2906002)(5660300002)(38100700002)(44832011)(2616005)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUE0UHZDWVhjbHMzQ2U2cGhrU2NkVVBtbUNmOThhaWVDSzYvcmQ3ZFFMdlFr?=
 =?utf-8?B?YktqRTBGZnFUcVZwLzVJbmp5cjRBbVdqRHJpeVhFRTFmYTc3MkpmYWZTSWpp?=
 =?utf-8?B?YzZNMi8vY2ZQcUJNN1U5NmZObjBUSWxpSVBNU2d3bVRtUlpSL2tWdTdkd3V2?=
 =?utf-8?B?ZUIzNGh6NkNOM241eXRoT2EwK3l6eW5vVW1GRXlxQUVhQnFJUEtlSEpNZ1dW?=
 =?utf-8?B?aXdIWllOb2owMEhLWTFnTE9Ea1I4ekdzUUY2N0xkU0ErcVl2S1IzUFZabmg1?=
 =?utf-8?B?T1RqQnZjVktwZkNsbkUzVFI2Y0l2V2FFL05OR0VvVUp0NGUvcE1NSXpjREV4?=
 =?utf-8?B?ejdXcTlRTDMyZGZJYk5MYTZXSXlzRVluajhoTmNFUkNTK3ZLYW1uNXE4eXdL?=
 =?utf-8?B?MFcvbytUZ3VnQmdSRnRIenVEeXlGZzRIWW5NVkdJckIreVgxeE9HV3BFbjdZ?=
 =?utf-8?B?a29TRENSOGJWNW1jR3p2QUg0Ty91djBkTVBIeXpLQlYwa3BhTCtOUDh1VW5W?=
 =?utf-8?B?MEI1bmtNYkQ3VUJjZm5QeEM1RDdnajMwZ0VwWHZ2VXNKY0VweS9FOHZvK0N5?=
 =?utf-8?B?Mm5kTUNIRUxiZkJBUjR5bWl5NzNER3ZOZHdHSThxb05jVENrTncrWkpFS0FW?=
 =?utf-8?B?Rnh5UWpaRSsxd1dmMERhZUFiZEszdGhHWi80UTVxMmhnYWo3UzBiSjN1TWhS?=
 =?utf-8?B?RmR2Y3RZekx2K0NDVkVIKzB2dzVrajArcnRuSFpqdEZCMEhKeWdlV29abHFG?=
 =?utf-8?B?cmxPWlU5OS9TY1U1eHN0cjRRLzhQZDBqYTI2S3p0eGpWcEYwTk5IWEdPNVNs?=
 =?utf-8?B?bWtRR2dPUmk3TUlNTTJhb3ZmLzFyTTJqNnhGNmtINEc1bXRmSEVpekUzdHFO?=
 =?utf-8?B?M1V2alVhTEx5NGV2Um5XVzd4WnJrSFZldHNNeURVbDExeWFocjAvbjFsRFVM?=
 =?utf-8?B?TkdYNjhnWmJDNHMxSlpwYWg5MWlWTnVCbkRNTlhxNTVubDBTSUFsbFNBeEx3?=
 =?utf-8?B?S05vaW9ITDNsMWc1NFo1blJZV3F0aVVVdnNwWTlzYWQ1RHpvaEUzTk1IOWpF?=
 =?utf-8?B?aktqdGpqMmlTWVkvQ09VbVI2QVEySTQ0NWlhT2lmODFGOEVvZDZESVRuM2J2?=
 =?utf-8?B?S1JxSVFnQStFNkh1amppb0s4ekFXUlBGMnlDQ29RZXBlTHhDK1pTckRmUlBM?=
 =?utf-8?B?YkcxN20wTjliNnBZV0hUU1hFaXJvZ2E1VFNhVUx3bGIxYzFpRWMzYkdseHFi?=
 =?utf-8?B?aDBFcEpVd0N3WW5RRlJtV0VneWl3a3BsWEZ3cHNheE82bG5QZFZiNWs2bG14?=
 =?utf-8?B?OWFtTnJtTHhQVjFkMXg2SzFJVEFzQURJYTViaWx5N0JYbmhGWHVJZnNuNTNG?=
 =?utf-8?B?TFZlZU5HSlliT3o5SFhBL0xEakgwM2pyZmp6L3NFWU5ydjlPOCtrZG40TXpE?=
 =?utf-8?B?ZlZVZDlvY1d5ZkltbUIwWWNzMVZuYlBPb2s3VGY0SU9jbkNmZXZOcG5GbzZV?=
 =?utf-8?B?dUY5TzR4S2h2ay9PWFZQWkVFTjNFa1VUVjBGbUJCMEliVzVYb1RsRS9jR0hU?=
 =?utf-8?B?cFRHeVIwT29tdmh3VzM3SXN4WUwxRGNvOElHc2RkL016R0kveW9YWmgwMEJx?=
 =?utf-8?B?d0ErQzFITnh0UUoyMXFrS3MvNW1udTZwUFJWc0RlYXNPK0NnSFFFcmx4RGF2?=
 =?utf-8?B?Z0ZjVjkwaEU0R21Ua2ZtSExXTVR3NWxsWmt0U3N1eE11VEF4MXJGNjdhZ1Z1?=
 =?utf-8?B?U0FZVGdaUFlnZk9oN3kxZlpHOFJBWDdQTnFnTWhtK1FnM0czbHJvV2hBKzhW?=
 =?utf-8?B?ZGFjclgwSHdYdllQUjA5cjZOdGNWZWRQWUhGeS9vVWJoOXByUWhoMytYazJG?=
 =?utf-8?B?NXlwVVlRcmhBOXR4akVoZzR5STI2RFgwODRHeDU4ck5vcWJNN1Fvc1FuWGxX?=
 =?utf-8?B?SnJOczNqc0c4eWYxYnkwTTVMbWhabytHVzZyckNWMlhLaDBoNEFxUUhreUZI?=
 =?utf-8?B?UVkxRHArdktvaUQ4TEZqM3U1blFBMmsyKzdtNlNJNmlPVmVuNWpJTFlmbVUv?=
 =?utf-8?B?d2FJUlo0SENOQ3EwbHlFS2hHU3IvTTFUUjVUNGFrcnAzTWxWYUN5b3dOalIy?=
 =?utf-8?B?SEo1cldrVGg1ZmFzRkk5SWhFYk1UWnBGQlNxSzJpZE9peFpieWRIczFPM0Ri?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RGRBT0hOT2JWRE80SGRSRGFEYytZU2R1KzBoaVI4RW1abElyc1VDaWZJWHJT?=
 =?utf-8?B?Q2NMY09wMEZQNEphOXp3andobnY2R2ZNNDM1THkvZll2dWd1dDdWQjRlWkNl?=
 =?utf-8?B?azhnMW1zZEN3VVpFQTFVSGVNeGFDbkEraVcwbjhwdUV3M1lHcTNDaGtCUjRy?=
 =?utf-8?B?M2hleG1KN215R0luTiszMWQ0QTBrOG5uRFVLY2kwYTdRblBGSUhYSldwZEFR?=
 =?utf-8?B?VlBnYjVmdUZnbnJvaktMZ3RRbUJoSHhuMVl3cjIvV3hKWFhSYkFSTkRUQ0Yv?=
 =?utf-8?B?TjNZT0xGN1JncTJtUzZ0bGR3MXZMNTlxREI0d2l4S29OZWc3ZCtaQzlqWTF0?=
 =?utf-8?B?dUl5OWpGd3FBZUNqaTk4RWY2SmUwc05OUFAxWlAvMjBjaEp3dnJBU25teisz?=
 =?utf-8?B?T3UyeVJkRGM2UExvRDB1Z2FaeTFjOGdQMzRxMUFsNTY0bEhEWEh1U1ZZY2t6?=
 =?utf-8?B?alVFTFJBWUtPZUJPQzFGWWVPV3l2cG16bzVpaTBZM1pQL3J3VWZTWExrV3g0?=
 =?utf-8?B?Snk1ekx3dHh6NmZxYXNYNEQ0SHFZUzNOQnpybHhzdzNvNm1EM0dZamtxUC9Q?=
 =?utf-8?B?a3JNL1dHZFpaY21jWnZtcnFUR2plU2pDRmlTaTJHRGo5WlZDOHlMNHBXTlVs?=
 =?utf-8?B?VmpSbW1oSkNQVWZtRlpxaThkZkFmaDRSNWJlbW5mREN0d2tEYkRMUG1jZHV2?=
 =?utf-8?B?UDNpdnpjWHc2M1YyMW03cnczZjRXSkhjWHFNL2I1SjZpS3JaVjM1MlZDbEc3?=
 =?utf-8?B?eVUyaVMzSUNxZDdNZWxzRE42VTg0UGxSZkY1eitOVUlkaDBrdEJRclFLV2h5?=
 =?utf-8?B?ZGVRelFPRVJSNS93K1AxeDl1c1hwQkRSaE9vZTd2b0dYNWJSRGt4b0RlSHhT?=
 =?utf-8?B?MnpFeU52MzlYdklISUVLZ2QvTkFXSzI3dWpwVTUxL0QrZjR6NVJqYUFXVXVL?=
 =?utf-8?B?bk1MUTdIYmxZYXJxVXNrVG10UzgveklkN1BLMER3YnZuTS81dUh0d2RKdXlC?=
 =?utf-8?B?d04rSCtBd2pKSzRmbnpqSGVLOFBxc2NlMVJ1YmJrNjlpeGRXRE9aTXJ5T1ox?=
 =?utf-8?B?NzhOK1BYRjk2NjlHZzRCRlJBanRMdDJreWJjTmZFZnZZMFlkYnBkeVEwVllz?=
 =?utf-8?B?K05CUWgzYzFqNmxYSVNtWkJzZk4xMDhPNEVIUDFRRGZxWUQ5WDZSbXpqNzZa?=
 =?utf-8?B?NzJ3MFpRTVJFdGR0azZ5azViQjd5b0RYVVltTXlnMTVBZDNuYjBKNm9UdEV4?=
 =?utf-8?Q?BCWNLtm+YsAyxG5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad396069-24a4-4d61-d46f-08dbaf880f5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 09:51:51.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MldxnWEWId59GczzCSufs+1UAnFYa19bGG/zHTov9pHFNKK+lK+u/jYbGKvSiAXMmJvdFSkyLEZduc9jXWeFmofGArxzEv7Yz6XV6azvs70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070086
X-Proofpoint-GUID: px4Jb-u_Pu63CueFhsmetRB0M_8gFcXM
X-Proofpoint-ORIG-GUID: px4Jb-u_Pu63CueFhsmetRB0M_8gFcXM
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 9/6/23 18:29, Waiman Long wrote:
> On 9/6/23 02:58, Kamalesh Babulal wrote:
>> On 9/6/23 06:27, Luiz Capitulino wrote:
>> [...]
>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>> index 1fb7f562289d..2b7d74304606 100644
>>> --- a/kernel/cgroup/cgroup.c
>>> +++ b/kernel/cgroup/cgroup.c
>>> @@ -207,6 +207,8 @@ static u16 have_exit_callback __read_mostly;
>>>   static u16 have_release_callback __read_mostly;
>>>   static u16 have_canfork_callback __read_mostly;
>>>   +static bool have_favordynmods __ro_after_init = IS_ENABLED(CONFIG_CGROUP_FAVOR_DYNMODS);
>>> +
>>>   /* cgroup namespace for init task */
>>>   struct cgroup_namespace init_cgroup_ns = {
>>>       .ns.count    = REFCOUNT_INIT(2),
>>> @@ -2243,9 +2245,9 @@ static int cgroup_init_fs_context(struct fs_context *fc)
>>>       fc->user_ns = get_user_ns(ctx->ns->user_ns);
>>>       fc->global = true;
>>>   -#ifdef CONFIG_CGROUP_FAVOR_DYNMODS
>>> -    ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
>>> -#endif
>>> +    if (have_favordynmods)
>>> +        ctx->flags |= CGRP_ROOT_FAVOR_DYNMODS;
>>> +
>>>       return 0;
>>>   }
>>>   @@ -6764,6 +6766,12 @@ static int __init enable_cgroup_debug(char *str)
>>>   }
>>>   __setup("cgroup_debug", enable_cgroup_debug);
>>>   +static int __init cgroup_favordynmods_setup(char *str)
>>> +{
>>> +    return (kstrtobool(str, &have_favordynmods) == 0);
>>> +}
>>> +__setup("cgroup_favordynmods=", cgroup_favordynmods_setup);
>>> +
>>>   /**
>>>    * css_tryget_online_from_dir - get corresponding css from a cgroup dentry
>>>    * @dentry: directory dentry of interest
>> Consider a case where the kernel is compiled with
>> CONFIG_CGROUP_FAVOR_DYNMODS=n and kernel command line is passed with
>> cgroup_favordynmods=true, this would set the have_favordynmods to true.
>> In cgroup_favordynmods_setup(), should it return 0 with a pr_warn(),
>> when CONFIG_CGROUP_FAVOR_DYNMODS=n in the above case, or is this
>> expected behavior?
> 
> According to the documentation of __setup:
> 
> /*
>  * NOTE: __setup functions return values:
>  * @fn returns 1 (or non-zero) if the option argument is "handled"
>  * and returns 0 if the option argument is "not handled".
>  */
> 
> So the return value should tell whether the input parameter is a recognizable true or false value, not whether it is true or false. kstrtobool returns 0 if it is a recognizable T/F value or -EINVAL otherwise. So the check is correct. I did double check that before I ack'ed the patch.
> 

Apologies for not being clear in the previous email. It was in two parts,  
where the first one was more of a question, where if a kernel is compiled
with CONFIG_CGROUP_FAVOR_DYNMODS config option disabled and the user    
attempts to pass cgroup_favordynmods=true in the kernel command line.   
                                                                        
In this scenario, the have_favordynmods is set to true regardless of    
the CONFIG_CGROUP_FAVOR_DYNMODS config option being enabled/disabled in 
the kernel. This allows the user to set CGRP_ROOT_FAVOR_DYNMODS flag    
without enabling the CONFIG_CGROUP_FAVOR_DYNMODS kernel config.         
                                                                        
Shouldn't the cgroup_favordynmods kernel parameter be valid only when   
the kernel is compiled with CONFIG_CGROUP_FAVOR_DYNMODS=y and allows the 
user to only disable it in the kernel command line instead of allowing  
them to set/unset have_favordynmods when CONFIG_CGROUP_FAVOR_DYNMODS is 
disabled.                                                               
                                                                        
If the above assumption is right, that's where the second part was of   
email, where I was suggesting the restriction by using ifdef guards in  
cgroup_favordynmods_setup(), something like:

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2b7d74304606..5c7d1a0b1dbe 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6768,7 +6768,11 @@ __setup("cgroup_debug", enable_cgroup_debug);
 
 static int __init cgroup_favordynmods_setup(char *str)
 {
+#ifdef CGROUP_FAVOR_DYNMODS
        return (kstrtobool(str, &have_favordynmods) == 0);
+#endif
+       pr_warn("Favor Dynmods not supported\n");
+       return 0;
 }
 __setup("cgroup_favordynmods=", cgroup_favordynmods_setup);

-- 
Thanks,
Kamalesh
