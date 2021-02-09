Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE8E3158D7
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 22:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhBIVnM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 16:43:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233833AbhBIU4N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 15:56:13 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119KHouR013261;
        Tue, 9 Feb 2021 12:17:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DJERSTkw4isNjvcqx1tdH0RoH9cRE1Lx9NOu9ApbbQ4=;
 b=pNpn78ociYajKDdHPi0uWHCWr5V0//nNPr1dUC6my7RExsJ9aB8SJwnKxPFPjPxojo8f
 kC22GjxJNo1xdsDpTilCF6idorJdLIi8eCfCxEUFic3QqkEbfyCipeR6uuPe3qrKhtTw
 XW7BNLGnq1ylWD3JJ3JV1Od6qjWWr/E5/lY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc1cdh31-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 12:17:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 12:17:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As37MLcZ9Jzgrpg4sKSprJMcBFEp2fQHEndc3+wM/pI9ASGvkO5ZocHBr5c70vArpdkHj5iTcSRMeN+VO6Br8jSOvcvkeNRdYkfiXJXj83VZpYM8X3Io6eCSJfGxVzIu75hjsLQgqejidjZF6HMn0YUy92h1cHfXRKYbZWgaijE6uV2YqQNqc+JynNQ6OZgqBc2xZLzyTeQtimRO+sYYNVMPif68Io3JxOMoC73OZF9tAxeUcHoNRck9WCGfVTSr+Smzto7twtax/UUXAgy/4VlsjZo2SbIvBq+9wE76OOGvfbj7OzEnxO/SYIGvvQK9z0ApFiBZzrDrFYe1t215Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJERSTkw4isNjvcqx1tdH0RoH9cRE1Lx9NOu9ApbbQ4=;
 b=SZT2JEC2YEFsDMtNCm45XtCWct+eRf2HkF12XkZNsH4vHwmvjO3CFeEHMd0cgR5OxuDVELOy+EV+Gac7PDpV3YKfI9pYkrlszU3AaUrvixMXpM/bONiiuUonyPlKeSMr0dL8chn7hNYOEIigqwfY2qL9fJjXLl3ukn3A4RzvNVahhyGn56tKJEbjEHKhkaKfvTCOlv8wcHY70oTi+Jswt/nPZNVmC9oftthOdu+EYb1RM5I2M5bjnj8RD7m9QKjtOpdixN0LWHvG5sOBkkHQNu+GWQ7/QP7tTvXchdSOlHClp8Nrd0QaZ8Zh/Ryv6APZM0UUe9jo6FpzVg1EqhyyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJERSTkw4isNjvcqx1tdH0RoH9cRE1Lx9NOu9ApbbQ4=;
 b=Cs/84A5K0xG6I5ijeYXodS0Pl+eBOjQ+F3k+t4n+mdeajqr+iMjWFKqdwYfF77MVTVU8qjNl7EdlH/PWzoigSVtkojf/3uCWJASIDMQ8J0HqSc9SX+BqT7fA9hs4+CK0gV4upqW5wZJ4S5DJ2Yl+V+j1XOVc/TJslCpHXp36H3A=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3480.namprd15.prod.outlook.com (2603:10b6:a03:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 20:17:50 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 20:17:50 +0000
Date:   Tue, 9 Feb 2021 12:17:47 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v3 8/8] kselftests: cgroup: update kmem test for new
 vmstat implementation
Message-ID: <20210209201747.GC524633@carbon.DHCP.thefacebook.com>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-9-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209163304.77088-9-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:8775]
X-ClientProxiedBy: BY3PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:8775) by BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 20:17:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99331db0-d933-4e39-cf04-08d8cd37c62b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB34801CE02F8C479FC0E3F59BBE8E9@BYAPR15MB3480.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUHE3ltNVcQpY01AgnzlecwGvhkXzTQRrq4CcODGfR3e4w6/Ci9QXi+F51NiSGHLJ2hDtLE6YOQFWas52pJxpbuFvlcZMOkdQbyxzeeG2uLjtzubS7hB6MRn5/DyZmrZ5w8uOd7BNHDdet4IpbPRGDe/LU+jDUY69UrLZ5ad+CDcG/Y+4Q/hEuYM/KcfZXHPY/ZAWZMwj8BgR5+phhNVyFcZjdp8ZrhHrN57CkC9YE9Sz/ZZ0ViIX9DA5aUR3kzlGkW9piT8FKN8UAFQPCNCn/wVar6jXOrgdQ+/L9iB4JQ1TISqL0A+/7TuiVi0wkRaD+JKpr7zMzGiX2abWa9M6cUFy2DAEYNT7VoyaEHqMr1SzCWKUATHmPfokuGE4ER+I/SsjhTFFO157yvCJagqvEepGTeJU5OdmWPva6DBckwa4qFqf2c9OfS+lPZpOhog1dTl7LXC15gCJ/AmY8riR7guA3rj1VNY6uiMv1K5R+ZAsi1gBvLQXhof6AwcynJGVsSWTafwfbnuZVQ1/8RWvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(39860400002)(366004)(66556008)(66476007)(66946007)(15650500001)(1076003)(6916009)(2906002)(8936002)(16526019)(6506007)(54906003)(316002)(186003)(9686003)(55016002)(6666004)(83380400001)(33656002)(86362001)(52116002)(4744005)(5660300002)(7696005)(478600001)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AZJdvIMYsmVL6OyA5jeI1OYWiwbYtKtPSb/kEyGniHyDnswamGKORYu1YkHA?=
 =?us-ascii?Q?sdBMnGwTr4bkFuYzzjh/ABdIkYCb2y0WIiBL2LQr8bB6OQVpZcmhW0WhZEq0?=
 =?us-ascii?Q?dKbRQm9d+3u4qczEE6/TcO5gjmOIvTKAV10hvE7xgEZS0C+TMJPUezzRWz69?=
 =?us-ascii?Q?14oGjQrqUO7vek/EK/33xohOzwvbreOSn+tF5NkXAbLBN4PECgnNPNdfykED?=
 =?us-ascii?Q?TZtD1VvzO+wPqp0kv0Oug6HN5jdCtg+wQ2aSKH+N0rUbwpfXw7K4BvWn6/WP?=
 =?us-ascii?Q?OhONRoFlGgTe6s1JmqrSr8O1FLm/St2r5Umjw9t8GkpQPWR8XF3iVai4hMJ7?=
 =?us-ascii?Q?1kQWQxrn8+dEI23mZufmeuZfoRDJ20If5YJZRJvQkxp+oPgPoRCKwQUFfbs5?=
 =?us-ascii?Q?BVl7Zyb1LAh/vdrK4V4yaSNUWPGzfMHglBOpO7BDvxglUZKSKfhBnC8Lnq7y?=
 =?us-ascii?Q?+Ucl7FJm5am14/Q/JFptfgBvPZWd+zIW2XpcVUAaUfuLyQlK8BnciJnY3MJt?=
 =?us-ascii?Q?waFDeJ5sjcmw50zaFrWDlCjyBjryVcCe3XMQqKRNHAJxCHQgD3aqGxs0PjCU?=
 =?us-ascii?Q?VctlrC4LjtFaXKwPoOP4o2S3NpXWxOMA/KY+fbE9C0Kcd7eKfjAChfyTUtj3?=
 =?us-ascii?Q?Dax2CXusb6OR5flPsKe/3PRutEOo6peo3x8Vw45yFI/l5SMWWDrV0sQpIxpl?=
 =?us-ascii?Q?zt+JKic8cOhiBJUc6qOcyO+ji+cs3ZkSh6LGSF2mGfIe3p2oYmFtPMTQV3R0?=
 =?us-ascii?Q?Ib9w1sW2SnNVHIw6zS3lfYs23cl/n82J8d974P2I0KzBcKKysrLO9t5Sp2BV?=
 =?us-ascii?Q?vth+0ip6/D5WUH0RHS3vvsvOzVGf5pfxXN0B9MEZY+KbU2TNQcVa6wTHuFsW?=
 =?us-ascii?Q?hXwunqiUcJEfufxY9Z1iPV1CSKyDkBy5OZ+zFFf0vf+IGW5T2ofRhVW6AC0L?=
 =?us-ascii?Q?NNUs2iQba8g0mNX00DTYa+r7Lcjnv6992ippESNvlbZLiBOqWeOogk898sNu?=
 =?us-ascii?Q?x/9xWLHa8jG98+Q9SxYbc9OZJ4VS8X8ETti6K3ZTexJb1VyhhiBwx2a6bMKf?=
 =?us-ascii?Q?qzK46KdKDzPsXv2JGW8ZXj+8hpF1ktqG1lkDUBJ4GtKbgyp5CA+m+gCqNrOj?=
 =?us-ascii?Q?V7bMDwoByaJIOymk7Fk81K3YCY84jGbukUHFgAQQLqnn1kMEKqaGVP+p9mEF?=
 =?us-ascii?Q?P5gIKXtGpJmt3NrOzY0Pm3kqOqGWWwWGMVK1p/JnK20zGE+H3A8/qQIdqSBO?=
 =?us-ascii?Q?AkX0Dt2kAbF7eNvlLad/KqhiN81rUvW4UXxhalNtExXtbq31zF9AKYv7hMzz?=
 =?us-ascii?Q?n5r9i0PRdiHbC+1sJgr0m076HfjWC3cCgs+WD2vbak2qmg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99331db0-d933-4e39-cf04-08d8cd37c62b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 20:17:50.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JMPfmoYtOpUYVUv3HxAghd7AoGiEWB06BvsQeCVqLYfh5hwsl2FIRG568uc4BD/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3480
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_07:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 09, 2021 at 11:33:04AM -0500, Johannes Weiner wrote:
> With memcg having switched to rstat, memory.stat output is precise.
> Update the cgroup selftest to reflect the expectations and error
> tolerances of the new implementation.
> 
> Also add newly tracked types of memory to the memory.stat side of the
> equation, since they're included in memory.current and could throw
> false positives.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
