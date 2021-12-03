Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1794680AD
	for <lists+cgroups@lfdr.de>; Sat,  4 Dec 2021 00:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344287AbhLCXlE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Dec 2021 18:41:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47850 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240671AbhLCXlD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Dec 2021 18:41:03 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3L6Oel026069;
        Fri, 3 Dec 2021 15:37:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oBR2+xUVvPcb5jyrgmPTBCCS07U+FThFRatAqFHsCYY=;
 b=pGTxt6a/BbFCqXN73eJXT2fQIIlvyytSPYUOl4jMtY+rBZKorarUUOwfn/tvtYZItnoX
 VaC7KE73XDlkSO7eXHVLi6YHlinn+WLiKW6Rx9kNOVJD72beY4xnEPuQxxsyh/My5hRd
 flgbXe7qNDtFJBlOKVyD0yioaGIzadU1XtQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cqhvdn50u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Dec 2021 15:37:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 15:37:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnMRwqsgIHR8AsYtOXR827AVJ9AUv83RY4mT3hmpoRvwtFi1vIsuwCYdSU5Nx2CuMjp2yhC0iiZLKoumGais836N/xDhOxN0RfEC4fruqAn/JNNoVnOmHhZY/nSpwUzvxQ4EE53A4dUD7u+Rq3j9UDj2nos8T65b3E4XbfPkTEWFXNARNr5/W17Ahx0CJ2nY0vkZXfnK6UkBPkW8hqaclqPGZte0/uH3hI/9yw+tSuqpWG952hwoF6q8WbUsU8ZAgYnsATFA6c2qbBaidwG4vhVwXWr09V/lzGjijuIRIoXdiQtUzPbQo63ebbNKPc/+QWf617OMXxajJhvoZXNIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBR2+xUVvPcb5jyrgmPTBCCS07U+FThFRatAqFHsCYY=;
 b=Wv9sBzY8UdZYVlU0C0+CLrGaeNC0BCE7NmlXU/nBl9rHCkzEQsN05jeVYz3nS92lpJAv3oY6XVWISpafKpdrmxZ0SZAeBT9o839VJofz7fsBG8gBWK4gb1Y/TT6lf9oU9YDilXvJwGZDbmpagYIgyJ2NzrmBp/H3Krl4D6R0x+fG8lGyivCLgtadR89umXi47F4vKhPP5CIgZuBvmV1aM20R+GVQurb7p5kY+8uTwggc0NFosckw5YGOBUlrLWT1Rx4Q2DT6JMED8LLLyLUWdNmfjSbEisu38o3QFGfPSRXjuUwIC4U0mPTbk38tYwW0cV81r1LSwbP1o77PC6WvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB1997.namprd15.prod.outlook.com
 (2603:10b6:805:8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 3 Dec
 2021 23:37:14 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::5977:c3b1:4b5d:9e2a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::5977:c3b1:4b5d:9e2a%3]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 23:37:14 +0000
Date:   Fri, 3 Dec 2021 15:37:08 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: add group_oom_kill memory event
Message-ID: <YaqqJPe9yvhLfQgM@carbon.dhcp.thefacebook.com>
References: <20211203162426.3375036-1-schatzberg.dan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211203162426.3375036-1-schatzberg.dan@gmail.com>
X-ClientProxiedBy: MWHPR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:300:4b::22) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8982) by MWHPR02CA0012.namprd02.prod.outlook.com (2603:10b6:300:4b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Fri, 3 Dec 2021 23:37:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12e8c93c-da72-4c8e-ca81-08d9b6b5d5c8
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1997:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB19973AF608CC5BB40404A8ECBE6A9@SN6PR1501MB1997.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juJZTeOMpotHZVaXwkwsXI4svo3o/8Vfb60zX0RqeeoxJcwzcWn8ON/PZekZQ9edNev3qeIqHqQlASGy98LiBfqp6QVLQ9+9LMYQObOb5VFlT1kcVHVC3ITcL7EZoxZSc86hsnaZA4NN394cSZt/JXW+zCUM68j0/XS/1+Q5ZUJqF+hMnGdHg4MMW0GN8zvWDrA4vMWc05dDdypH80Y19P+ZeDmRinokI7cl7IXSsYWhEOZuFR21zV9aLfDeoUwVq+/dU6S4Lx2C42z3kxUhApjyln3/VRdMzLLzAk19vxpFTtmoAS0fcK2AqOrdyz7xxB5dRKcFWu/y7jEGyn5EnDW7etQ2yds9r4s1gq4fWi41ne5HEMgTY1AUnQmewbhWcUJEdo3gJonRmW55ajm90APWwo9Z90tV6ZAam7lcsJVUi9zh1UgpVfI/VeHw8yWJfmCGS7j1kgJ3tWxxouMNDVE3r8UhbqD+64QTGwWYvIlsUpSyPCzBhiSVkTCHGjFc39XKCd6Kp9khE6z9gPc+vk6dPHjQgrX4gCK2RxOvDTfvCkPQD0n/9i7MWo+CxBZuLtuoJlUbJMdmLqdHn2NLylVMmevdEbaiYN/J8dl/6tqCMFdpLCAFvkZa3y0UpQ/z9QGqwcUCQ8Uc5f/9pBum6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6916009)(66476007)(7416002)(55016003)(66556008)(66946007)(6506007)(186003)(9686003)(2906002)(86362001)(54906003)(6666004)(4326008)(8676002)(52116002)(316002)(7696005)(5660300002)(8936002)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p0gkQAEdcCzFcqMRHUK6Ku9zM1axWC4y8PUXfkaGGVCtZA09EnN3+BWRu29v?=
 =?us-ascii?Q?kFVEXyxomNmvJGNdZXstq47WosimOlzpizwzNOJiIo9n7oCpiX21Ezxo6nJm?=
 =?us-ascii?Q?fZfnDj0Zx2aTLWb3WtAz/SnQ2GhfncLAh9EUVe7sbGvDnzKL4HJPFSC9VRTi?=
 =?us-ascii?Q?nWcPlnyBpvcmUDx58q3+lLT8mQfC/AUWgtSEfOOTlLLF/7ghx7TmJ7U/tHel?=
 =?us-ascii?Q?nj5yq3mdrzXEX9+IDK6Dmsog2cwEsseKgDo8p9f/DyFoQlVFIJ9/qyBw0rG3?=
 =?us-ascii?Q?b+mtZjhlMlnlcAgU88y2vnJf3QPknfHkvErZXfiGryftQKatHtR/k5qzlUdH?=
 =?us-ascii?Q?xdM0PRxttLnz6/vZfLuxpRO8wAHMmAi6c/775aqqzox0sD6+BPkKpfgi9sG8?=
 =?us-ascii?Q?2IQAfrAga9lRLpx6lb6YUy5z7JfFzJVeCzLpleEs5IZs4O7wyVACw7fE1CbQ?=
 =?us-ascii?Q?YtSP9KIQ5guOzQYkobrN37k0LrTtNAzt2PcAVmmWXYvWMq1KrK9vStbswzta?=
 =?us-ascii?Q?jip9+nV0L5QIEwTFFiIM8U0iAHL9y/9I5vDZjcfHU7dtubpQ/DM+Hp5t6Iq5?=
 =?us-ascii?Q?cjHw5MjiQ/0WkEgvsDLGz3o/xAi/b7m2k3akJoTg95jq8jezSskzAmXfRTX1?=
 =?us-ascii?Q?LrySbopQs5twBBqxiCSUqiXyqP/2KfIzJ86+PiuSJlwZryiHcswefnni1iNi?=
 =?us-ascii?Q?2dFz19ftBbn6AmucSSJ00dPxvTxylgiPxSEZ9feqSENF13wrTlw0mLDgJOyo?=
 =?us-ascii?Q?UPYSlUkSQIxxL06KGh81PeM6dYlyXz7extuSBWUo+Od7L61sSt+faFspQuxG?=
 =?us-ascii?Q?NLftNysgYTMw6MeSsXfl5Vf+AwrYI+++duwZOQD6TQkINw28wr1S6RRPmbgS?=
 =?us-ascii?Q?7S1Saj1tvVvWFetPymY428V8MdwrNzN+OaW4qXeZtBttRYnfW55c6zXaZhfC?=
 =?us-ascii?Q?gYszFDn+MGFsf+le2EELpx7o8KagBTHLFmPZajjydTX87UYlbXPiPabjZTRd?=
 =?us-ascii?Q?/8HmUOaF/c8P9c+uLqPRkLOg/OCA5pbmYIYOUHRWJkB9Y7MDN87Q3Dv8surP?=
 =?us-ascii?Q?ov+epHygmoZJppadyNpbY9nE360WUsX/BThZDpWlPOmbyvSB0CplHeCiEi5n?=
 =?us-ascii?Q?KPvgiF8HNgyTRWLvEjrB6qD7STa5bibdr3kZJ91IIzOZyTJ5sho4QLnFaQWx?=
 =?us-ascii?Q?MsemjakMGuTbmycQHaJpJHKxZNyjfEVwJ6ERQesCP+I8fyEHaP4afMh3zdQY?=
 =?us-ascii?Q?5EXcLFqzn3hMNARofMz2zuK6Ha8IAX1lVPYnKqKi3myyR6G1uW/4upyqau1S?=
 =?us-ascii?Q?8NsuSWtQSl3iv8IU6cu3rDHSLHxXJFOCJTiKVbWEmRMg2XOXvu4QD4uuTt8N?=
 =?us-ascii?Q?ljBQfQn1sT4Bu0O1nFgTRWE9R4Pyba3u43y+xb98IA8gQ9H92M5JIOMKSMH3?=
 =?us-ascii?Q?YRjCZfvDtMo/S/DOMamEXUNO6Pg7VAGNMBqEXdTzUqa+VVye8LFgSLS4U0uT?=
 =?us-ascii?Q?Ojc1dn93R4JzxO7Tvbt70K4Tkc1wNMtukxRVSAt5gdmYoanZX7PwXr5qPtWY?=
 =?us-ascii?Q?LzGvRvqedTPNFbGlMLnIgzGOG17N7YaSuwfRaPMw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e8c93c-da72-4c8e-ca81-08d9b6b5d5c8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 23:37:14.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWHQsEWre5dVrFP/sUxnB8K/zRhGh6tgmTeih2Smhj6Bc33s7tf225HThz4/MpPT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1997
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: dD0bSgGLLrXQijetQtTL_nLFxQOZvWi7
X-Proofpoint-GUID: dD0bSgGLLrXQijetQtTL_nLFxQOZvWi7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030150
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 03, 2021 at 08:24:23AM -0800, Dan Schatzberg wrote:
> Our container agent wants to know when a container exits if it was OOM
> killed or not to report to the user. We use memory.oom.group = 1 to
> ensure that OOM kills within the container's cgroup kill
> everything. Existing memory.events are insufficient for knowing if
> this triggered:
> 
> 1) Our current approach reads memory.events oom_kill and reports the
> container was killed if the value is non-zero. This is erroneous in
> some cases where containers create their children cgroups with
> memory.oom.group=1 as such OOM kills will get counted against the
> container cgroup's oom_kill counter despite not actually OOM killing
> the entire container.
> 
> 2) Reading memory.events.local will fail to identify OOM kills in leaf
> cgroups (that don't set memory.oom.group) within the container cgroup.
> 
> This patch adds a new oom_group_kill event when memory.oom.group
> triggers to allow userspace to cleanly identify when an entire cgroup
> is oom killed.
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
