Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF70D4A74FF
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 16:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiBBPzX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 10:55:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230107AbiBBPzW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 10:55:22 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2121ftMh016821;
        Wed, 2 Feb 2022 07:54:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=PntVkuMfTienoR7WfCrdOCIGWX4pTWY+Pz9DpDetKJ8=;
 b=VNORFQ5cMkGak4CBsI4tJMn4n3sMeUXdGyjd3r/Fju07zsvC3A9PN7yicCXrCUMt8bqM
 KAShRCFV65f0gGH2CG4R6o2Fr5zeNvUrOUfMj8/sv4OPNaxdHtZTSfqpVYB0TNOEVfUm
 sIFpjZa1K15G7SLbHOsDhrla2cMKQ/8McMY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dyb3hwnae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Feb 2022 07:54:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 07:54:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5MixJfWx4GXwJGc5Sg/zWhSgdt4bzAgABAFZDMdJt5ewHge4jaIrI/8R5sjzO8h1TCtHSQ0AWoejDpVnu2uNQCMu26XhBco2ZLUy0u7ecgfxlw3F2CRDxvAwASzjBFfxz5tsaTE8k5wTnXTFd3WjuQ+enntM+15YW+rvUSiDAgB0LswiRMFvDE+7MVJpYLepBE+jjz1KAGVGbLW799vJPE246gt5GluhM2+HxVR/2ux+kXu/NoluonFp6vZU2+R9+au8KqAFGV5EQcP6qaE6bGt7LCATvwTdvrSVfsmxwAzNHRMhtb786ipsyEYejNvf379THs6o0iBILCk6B4g9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PntVkuMfTienoR7WfCrdOCIGWX4pTWY+Pz9DpDetKJ8=;
 b=ZNADFEYsuk93i4kWacR+yLBx4atguNU3A8v7oO2x21vca4br2DIDBzZoU3dgX+f6dMG/u0vR6bLNS5KKd1xCera9U65+ymihd9Nm0A1EPgGMaoQABZlhr5K08ZRZnJR5o5u0gs9DsB3R1SNDObLmh06r64GbCDPLjj+ZbxahOAgbQvKfWsO2INB22/jGTAJ74ClUf5FK2kt1F1sPAlyB+c1oGp9y+3/hja6UKArkmOy/gTRsv9OIDE0QlooM6elBcOoByBAopCnCAoRf0avJEHg4TU4G6K6t3x2A7QPcho3BGWOCDQUUXrFTrJtoBbL0mdj5Chb9JBfBPbxwthPI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by DM6PR15MB3243.namprd15.prod.outlook.com (2603:10b6:5:162::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 15:54:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 15:54:53 +0000
Date:   Wed, 2 Feb 2022 07:54:48 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Message-ID: <YfqpSPLC+LAdqbJX@carbon.dhcp.thefacebook.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com>
 <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
 <YfgT/9tEREQNiiAN@cmpxchg.org>
 <YfgnUZQBRkqhrEIb@carbon.dhcp.thefacebook.com>
 <Yfgpknwr1tMnPkqh@dhcp22.suse.cz>
 <12686956-612d-d89b-5641-470d5e913090@redhat.com>
 <YfkQJ4QhfY0dICB9@dhcp22.suse.cz>
 <268a8bdf-4c70-b967-f34c-2293b54186f0@redhat.com>
 <YfpHbtffFi2x1L4p@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YfpHbtffFi2x1L4p@dhcp22.suse.cz>
X-ClientProxiedBy: MWHPR19CA0055.namprd19.prod.outlook.com
 (2603:10b6:300:94::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae8daf97-e94c-4c48-989d-08d9e66459b3
X-MS-TrafficTypeDiagnostic: DM6PR15MB3243:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB32432A50A1A70F1A5B543A2CBE279@DM6PR15MB3243.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ehqb3d35LQx4RwTKvmSFrb1b7D4HHeAcEs4RLZfmOasvLZv8+l76nTzKk+r+PMxiw46VOl8Yd41T+h3LOQaiCbPKMO33FjtKhvKis/onWkQDeLJaBOxQuK6+Lr6nLS+yUegK8F5wk4IN0+YftTFDRH/DPSAUlxEseB5Dvv0Annol2TPPkVNBsBpBjfkI1JeBqOKfuxba/FmZb+a44nRczLpH8Xpw4kk5zIswIAeYfjSviJr5Z3NTgQrnmYcR358TkLCcXxvgsoqVXx3YOG7a6eflxsRGF68Wkqi95up5al3rUiVyHiGO9pa9arYEKrIjxIFCYHWCCYBippAUz59q53esKjPF+g1bE64wY+OguQu4gGYwMWJKUm2ZTQOvu4+SXCK7PLyGQ4IHLsI78934lT2594gScGTz6yT5diuWbNzAnejcGC4z/qHVhIrmbS6qfB7yiGs3X5G3bBfAiu2dPIL7xzsk/aRMhzs76wuNXs0FZGKj14DHAwtCnRdrSIzlYIRCPbjy5jCp3URzmMLUVQrv9hcoBZ1AVZyvTZLDXNPnESs1J9ARduSnfZeNaKROMkiRuzrzbE0qY4pkWHtPVKfwibx9FnT2ghxVBxMwSkjpOZtV4yFV+PPCJzauycF4q1gZAHF2zCJeREvw7LE5/t0y55dqq4HUAPHWOLGONm0txwLVmpZSYUELk1tmcMVElIXw4oBkOBeI87GVU4jtUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(6666004)(508600001)(6486002)(9686003)(186003)(6916009)(6506007)(316002)(54906003)(52116002)(53546011)(83380400001)(66946007)(8936002)(8676002)(66476007)(86362001)(4326008)(66556008)(38100700002)(7416002)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k5zYs0QLI6w8806R/SXvjyfM9PAHL4hfOYA+kbzmaZRSImj/vEbjqIOXjbq8?=
 =?us-ascii?Q?wtR+2G/PEnG9mH0lq9bO2uB/QTAxDUNuVlFEry/Da43t8lf3VXdQJ15hvhtg?=
 =?us-ascii?Q?74Io+9qNDKODPYFu0vWYnAtwv3Dwwl6zFHZ+8fjeGzj8pCoa+sqsDDuEJDIZ?=
 =?us-ascii?Q?7LJpGUkBCSouNvKNp3NA6+6FkITZjILeZ9HNJwx1O9td9Jn0YWlX5ndWhAxr?=
 =?us-ascii?Q?1eGl6ZjfH0UmQF6Yd00BNtbDmC25TaZhNaolh4YXS4jImUoiQn+V+OJUld4E?=
 =?us-ascii?Q?lfsFCIVUhNwXXmmsMUPmFaqujgkhBb5g4zPOrCoOc7Ufyu+w4y82Z1yH48VK?=
 =?us-ascii?Q?m8tmQkKdvaUT73Bjcc5UNPsuRHdx7pqEutq+PNYxk04b3StMY8Z55V/CvODp?=
 =?us-ascii?Q?Z9amp+iHtW6OdPZJ8mcYkKwcAJQEfS/Wy+UgIQyx5xdpceV9MnGZdZVtkPVY?=
 =?us-ascii?Q?EZDXMs6MAWMAClQM0d/+Ef4QV5KRVDfq7mX/A/2y2hF/saYLDH76ryAisfsH?=
 =?us-ascii?Q?Z2IRhJJOXJQaXhI9FnONoNYRO2CNV4PvjZ0GuSr8kXRe1uLdiZF/E+qLKVsk?=
 =?us-ascii?Q?Ym/HA980wiTiCmA7ydituiNScoTd4iHixUhO4V73zQLBfvwCf5TMBV37wTro?=
 =?us-ascii?Q?kkeOgTRYTPMvG1PKyB03bluZarFtEo9Tsgdx3RhfpRFbpmSIjaLSCyp+yQW3?=
 =?us-ascii?Q?2CJ6dAUWsCGplGxbiqfMUuxposOAdwVZcII1VdxTdavEGGzkuBAjy12T3/jY?=
 =?us-ascii?Q?YUf65bj9kE1Y4Ih2zj5TYZdiQv47YTGdEkqpewaHhNvae55dMkl587x5+Vya?=
 =?us-ascii?Q?/qAwqttVDxdCtq16DaACkn1YVZ9eeFP3pVfissRECkCuz86opHsKfhJN3QPN?=
 =?us-ascii?Q?0bu4PmqUBDQLjJT9NZslY0YVLDSXCbTXVaO34IfbPqCi/uKtDTXS5SF+FC/A?=
 =?us-ascii?Q?tI48PNz8XYtGK6GXYW7Bx9AAIKdcn6V+s/ar0I4NvEhZqTO9Nk/xLGC8W0Hg?=
 =?us-ascii?Q?rRdQDOuKGByorQGKupYzTQdkAji27vItHC1NCj/q/liYDUU+1YI2loN0zYQT?=
 =?us-ascii?Q?lfICqrSgnrw2p7WPJNgVPVvR/OM8SuC9mvDhx1YfNgM+srw/KqPPSBqb3Mwg?=
 =?us-ascii?Q?aM8UGIu3AQCX8BVvZO3vMAWmNRWn+s9HxWvBrjTab4g4WYH7HCzMnGdJRUKA?=
 =?us-ascii?Q?EUhclQxF4PxUUNovYjosKF2gYX6ELWe6iB8lKx8S/ZHpXR5yKIvpbBoWWnMu?=
 =?us-ascii?Q?BI9iOmdqTnbmFIAW0OXgpGu+6OeJ+QtnS3St8uXf+Xw+8ZHRawRiyvh5nz++?=
 =?us-ascii?Q?Z8XjCuqrTOqrehQlvM6j30AYlN4sGG6IuSNyaFFonElEplmzXbEsfuU0iRKI?=
 =?us-ascii?Q?J+BX2ZFUEmpHFiQIPGB+kKczV4FJ1feivUuwpHSC3fYCyBPGPo6qeWR3v6sW?=
 =?us-ascii?Q?YX6zG1YJOtlUHbSP64AJo0E0YKuGcbW+6vlgD2m2j1wMRDVR+9+px+3XneId?=
 =?us-ascii?Q?pyGnYz2304BVI1+dQ3sYc/fv5tgfcwi3Gz35YnU6LOoDuU96aqA5kRan88S6?=
 =?us-ascii?Q?vhVMOFaPOBKMfKCLfVU4nRGoDHqyP9sCbHFvP48B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8daf97-e94c-4c48-989d-08d9e66459b3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 15:54:53.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgWHEdTNkJXqxtJns1mutldNBdkkF9iZrPrJ1l/UuUW3Hfq2NmG3UeoBlFPfXtyc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3243
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: SgZCIPj9yViw1FyGgr9dWk6NycFnJ46b
X-Proofpoint-ORIG-GUID: SgZCIPj9yViw1FyGgr9dWk6NycFnJ46b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_07,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=462 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202020089
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 02, 2022 at 09:57:18AM +0100, Michal Hocko wrote:
> On Tue 01-02-22 11:41:19, Waiman Long wrote:
> > 
> > On 2/1/22 05:49, Michal Hocko wrote:
> [...]
> > > Could you be more specific? Offlined memcgs are still part of the
> > > hierarchy IIRC. So it shouldn't be much more than iterating the whole
> > > cgroup tree and collect interesting data about dead cgroups.
> > 
> > What I mean is that without piggybacking on top of page_owner, we will to
> > add a lot more code to collect and display those information which may have
> > some overhead of its own.
> 
> Yes, there is nothing like a free lunch. Page owner is certainly a tool
> that can be used. My main concern is that this tool doesn't really
> scale on large machines with a lots of memory. It will provide a very
> detailed information but I am not sure this is particularly helpful to
> most admins (why should people process tons of allocation backtraces in
> the first place). Wouldn't it be sufficient to have per dead memcg stats
> to see where the memory sits?
> 
> Accumulated offline memcgs is something that bothers more people and I
> am really wondering whether we can do more for those people to evaluate
> the current state.

Cgroup v2 has corresponding counters for years. Or do you mean something different?
