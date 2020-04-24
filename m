Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806CC1B7B8C
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgDXQ0Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Apr 2020 12:26:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42008 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727863AbgDXQ0Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Apr 2020 12:26:24 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OGQCTm004444;
        Fri, 24 Apr 2020 09:26:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+MjBi82/SVt47pYOBEgSUwbeLKitEqMEiLJsqmlpMMk=;
 b=SVl1+DgG1i++y7260lhiL9e79Ftyl/wQMeTJU4bB87YQLqZEg5J1CK2oO/yoWj/S9s81
 jyfI8cKpsG/SnG7TaA8UwOUHj4ZcWCuVZSShluYF7Nfo6y3Ebb5TdR5HlBU2YNUX2fgC
 Z4dqvu+SebrNfVP9C/jb1+BU6yy7uzwByDM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30kc0rgqjn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Apr 2020 09:26:22 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 24 Apr 2020 09:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwh0L8ygtcC2BiC5AvtD1o1zNowDhlXeLa/AXBkY32rbrb+soFPh5iYbXYYVG8rS9r3rZSHul3WY0Zv3yhsVtftAENJNRTmCGw2JqX3F4NKkejoMXgflrdx5oNoHV8KD875V+rJ+YFX1OuHqq2JzF8xcDLUBvMUACbB17ncq896Kp+VLCiBoiLaV9SgG2NQpWxt2LkmQS0paJvj+lYmt2HswL5t006M51iSTThzOpIOQzKpteyxOUhZvXRynOOvT3G22t/MPeciy88ctnyGWWJpnWcQq1pPwztoOvA7Z9FBueESlL3hUuMy2LfSWlk3x1T1To3AwRVvFkQ81omyC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MjBi82/SVt47pYOBEgSUwbeLKitEqMEiLJsqmlpMMk=;
 b=mhbc4gZw6BntjjJauso8eSGsSTd4j9hDBKw2xkipXh8VBBq70Htax/UfgQ7yOVzwXn82VMMZcwTVJukmiKMQkVmgX6KUb3BFVzEp0pKwo0zHdenRw8cW5fXXhwms/VOD1EmpB8CW3O26YatJXvdMfSONeTalTApAfdS0AtAYuZIrXWVN9aahc8dKqqT5u0ScqKxtpgXv17KFY6wc+ZXD0rksptFYtHj1BfaizFd63Q0kxBnt7g4C8ovzfpiib9zgprhpkFdM3lrEHpifHQKJTSUVJSm8W1SuQPWq8u41GK5Xn6CM4QZDi3+lShoIRbB2mlfnuaVLARQL/sE2W8ptwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MjBi82/SVt47pYOBEgSUwbeLKitEqMEiLJsqmlpMMk=;
 b=HrL5+Q6KAqN6eQKnB53EJVXUO9C9zkMkWy0TsyMXlkME8nXwMQUr77vbbuHTf28ocq/kItcFIFsJ91WFI45FUMTTXl0X0cNxp2VEJxHpAQjlJo8q3hk7QKfHg9FDk2M/QbvEfGe/qnk2bN0+SKsC6uyk2nDvjmzJRaZpcXTfSKY=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2853.namprd15.prod.outlook.com (2603:10b6:a03:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 16:26:01 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 16:26:01 +0000
Date:   Fri, 24 Apr 2020 09:25:57 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Kenny Ho <y2kenny@gmail.com>
CC:     <cgroups@vger.kernel.org>
Subject: Re: Question about BPF_MAP_TYPE_CGROUP_STORAGE
Message-ID: <20200424162557.GB99424@carbon.lan>
References: <CAOWid-dSF0X3pa6ud2-ndYzJdohuOBewfcEZcG7pQ8q=fZh14g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-dSF0X3pa6ud2-ndYzJdohuOBewfcEZcG7pQ8q=fZh14g@mail.gmail.com>
X-ClientProxiedBy: CO2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:102:2::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:1ddb) by CO2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:102:2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.9 via Frontend Transport; Fri, 24 Apr 2020 16:26:00 +0000
X-Originating-IP: [2620:10d:c090:400::5:1ddb]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2af6db24-1ec8-425a-24cc-08d7e86c2d2a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2853:
X-Microsoft-Antispam-PRVS: <BYAPR15MB28539C4D25BA40D6F46C7099BED00@BYAPR15MB2853.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(81156014)(7116003)(4326008)(8936002)(316002)(55016002)(186003)(16526019)(6916009)(8886007)(86362001)(8676002)(6666004)(5660300002)(52116002)(7696005)(2906002)(36756003)(33656002)(1076003)(66476007)(66946007)(4744005)(6506007)(66556008)(9686003)(478600001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/zKzx3KZkl/ZJkkwowdJo7C7ILKeVYBtJ4yzxfhbkRnWiI0jXcfyts4P0kwp7yMe/9SsfytwALLsrw4r9cAPUGC6m9rn1rNaEN/NkQmLusVgQPa8YKTX9OSyts/xzbvPCOd25+DQ2wlnsJZ8MNhOTfKB+0Et0/haVcHmf+3JPSsag9oMBTvcVPENNORaoYF0H/8hh41HSNnLRuCjC4Kyp8t7MlODEOSSa3KoG9xKrhcDXG36c7z01beodex82BHReG/YVlaAGb0ZVWPXjRmk9aHfM1ldRZsu5riWH5QHV/k3L+WdozeoMYqJjv3mdddUbCMDB4ixww0SJuy224nu/mpYz0cfBQKtMdkoLHyebRbYBidJrucCVEvOeAB0yaU7rQSr5jV9lQ0sTNK3mw9El4TZlASIrRrpONejXr2ljBDhM4WrNYdFotxUBaSlHEq
X-MS-Exchange-AntiSpam-MessageData: lWwgzBCdhy2g1OTkxIk8T+Ry/sbDoKpjpST7C3Q1Q6WQUBoWo1BWZ9ebzrJwA9U2xA/aiOOzZLWeq0anKJYJab9S9W4aVNBeRC3wNxPB6avjC1mXh7i8QQ+wUNaxF6dgoxmdFvGsaIr/keUEL2bc7myawSXC7cuuIUgxFoN4u0IvM4/igvZ3yS+7gLReK22i
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af6db24-1ec8-425a-24cc-08d7e86c2d2a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 16:26:00.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hCxEbYuGZl7AdnuGHG+wJ7iRcsokyRMdLCPplPjfMUd3jNzapvgatM/+/0NiMVR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2853
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_08:2020-04-24,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 suspectscore=1 impostorscore=0 adultscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240128
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 24, 2020 at 12:17:55PM -0400, Kenny Ho wrote:
> Hi,
> 
> From the documentation, eBPF maps allow sharing of data between eBPF
> kernel programs, kernel and user space applications.  Does that
> applies to BPF_MAP_TYPE_CGROUP_STORAGE?  If so, what is the correct
> way to access the cgroup storage from the linux kernel? I have been
> reading the __cgroup_bpf_attach function and how the storage are
> allocated and linked but I am not sure if I am on the right path.

Hello, Kenny!

Can you, please, elaborate a bit more on the problem, you're trying to solve?
What's the goal of accessing the cgroup storage from the kernel?

Certainly you can get a pointer to an attached buffer if you have
a cgroup pointer. But what's next?

Thanks!
