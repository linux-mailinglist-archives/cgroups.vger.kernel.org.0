Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D892F8180
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 18:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbhAOREp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 12:04:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58940 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727961AbhAOREo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 12:04:44 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 10FGicOd021130;
        Fri, 15 Jan 2021 09:03:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oZXz0KoAJnOVId1VsCkd/tbqlGBCv30GAiQhtBN6l8Y=;
 b=E8dMpUOkihE/ejvp0MWgPP5PZLws3NMeqGTOTsKZITjYoJnagU94lwZxgC9+YPmUAVMM
 vpaDlloLWrHQvGN1CQSHOpeIk791UG68fKWpGfuZgfLBe1Ork6yzYq4BjPe6nx3Y3yvW
 UuMbpNiH76LRf2bmXIebTSWEdzYkZhBIU54= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 361fpr1j0n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 09:03:55 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 15 Jan 2021 09:03:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZRP/7WgunP+1uFjmvZwRl8N+PfaF0vB2LRVlpN+Q8Siy79QzwGBDwXopXsFzdgDO5wYKRUPB5lTQtzFV2rL/6qruRJOzQvS+h9F5ZyW92Ex4b9+NyysBtll7lrSj9c70NlrrxS5nGNhbBjfZ26BQg2GVOdN25ndiDEUcMEXag4ZkQJAVVMtsCAKEQnoKBLDSNFzbB1y3wjPzMvaTpHYLdeTa2vAmusPiMX5VpHB0OTwVAc6DvFs3455dwZgdntupgdWdjVLrLP8zBS1BTZMlAWUMYOkInyQkFOvqcmHzap7/unv4kj/psKMsabGVkYm5qR3PiYYEAPr36eaUHj/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZXz0KoAJnOVId1VsCkd/tbqlGBCv30GAiQhtBN6l8Y=;
 b=LFyl5jc8AY/TAO1H/k27L7gA87jETUk6nYg3Q/r511Ysrk366iMqJQBNzwBvByPapld+aPptq4rMbP9i/3+AvxZCW9hfDcNVZml9Lbe1AXVMZYzf29Qn70kgRzQrf+qvaSH9JurkciIB4YBKEI9hQPuHzz9Vai5MdnufwZllyGt/RiHsdeNbr59YQXyo5HFtICCG7aKLPhLyDSN4fvMVc4svlIpP681foNJ433UZ7KQtabsiQHNd5cT0MWbGVYtO7Qz+SQm1whR91kVtPz/bcCW77Smtz0c+23nrFrsea9RFF4YS3vahzvlP06z9Y7bMv+OeasbIXX/JI7gr6hdriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZXz0KoAJnOVId1VsCkd/tbqlGBCv30GAiQhtBN6l8Y=;
 b=iM87PJkjZRkLVixcbxA0xHm2ytNidbZvbEbhhKIz5K5gjYsHC+LIcq2gzVBM2m+UtjjMng9igl8Z0ljVphewlclkkE2Tq4LNr4DW41gdzuwgx3+bsy9yHuP3e1nBQX/sCpEzRA8OXfARhv/J/UkwIgd8Fjt24+XVl5xQmtMlhwg=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2214.namprd15.prod.outlook.com (2603:10b6:a02:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Fri, 15 Jan
 2021 17:03:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%6]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 17:03:45 +0000
Date:   Fri, 15 Jan 2021 09:03:41 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <20210115170341.GA631549@carbon.dhcp.thefacebook.com>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <20210113144654.GD22493@dhcp22.suse.cz>
 <YAHA4uBSLlnxxAbu@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAHA4uBSLlnxxAbu@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:e7b9]
X-ClientProxiedBy: MWHPR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:300:16::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e7b9) by MWHPR13CA0007.namprd13.prod.outlook.com (2603:10b6:300:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.7 via Frontend Transport; Fri, 15 Jan 2021 17:03:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bcdb25b-1576-4c24-1aa0-08d8b97784b7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2214EB60D160CF891B41A2F5BEA70@BYAPR15MB2214.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bjjpEBYCi6NAPq0nQGEsBlnEjoYFuXCEmKh5RDvh43ZKYJZBbhLFSg0oi8Pa56+7H4M3+VIJtj6a342qzfraw5PcatEplLUTJgBqKko83N/fTLNeQZZzcz3P8U1vuhNKsFaQ37R/4vG5KcgeuHgIhec/yljTemLgQOKaLV+DzH8Qd0YJhJGua222b22HYnEjUVLZz5ZRiDohAp789urIo4JxyiYB1b4vzEk/CrlD8tlbySIXVP5wQcgGfDAAZ1tYldi02mK5zcMaaufS9/Rajw/V3sGuKkZo6rNtiwa98j85qDR5oqbM8hUrmPGA95ur7tKRsWKPu0d9Po9sAckgmwqOixb3clRIGdEQmyINy8cOtjAPCDNwnX7ZMjUym9tsHxhysx7hiKd3Y3f8RWIWhRUcIKoMdg+RIXh/w1ZJyR5Ms2RVl7ScES6+GoPirCl7AsdZUo5IF/dM52dpn7fmtMp+TQqcbEFZrml4pn4rOrJPUFNz1f/5NLdp5KIqqHJEqhMzwcIiZvJwl5aM7tSQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(4326008)(478600001)(186003)(55016002)(6506007)(316002)(8936002)(66946007)(9686003)(1076003)(2906002)(54906003)(16526019)(6666004)(6916009)(52116002)(33656002)(8676002)(7696005)(83380400001)(5660300002)(66556008)(66476007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2Px3d7owNk8PpKYtjNPINl4z9F89D/TdFAS0jBPOqS18+GPoQAbqj5DzXJyh?=
 =?us-ascii?Q?+VALyiLLxrIiEp17mA9EZaXNpDEs9DMos4v8gQbwh/Sw5J05mmv3eVL7w5Pn?=
 =?us-ascii?Q?wIZU8mRwNm4daTQAjD2XjUotMIY/nf2+b1sjhxc0uR1p2LkmCJ6GLM+Ge5Qg?=
 =?us-ascii?Q?95yPb0LJRt3BdnPF5stdvXbsV8JBXn9PMxEfKS6NrURXaHa99Cl21rm30+H/?=
 =?us-ascii?Q?3zpJYdH/bVgVY/Fo8QLP3EA6aWDKfNPuk85QAlUCb7DaBvhSeE/xS9yVZ/qo?=
 =?us-ascii?Q?CXFXF4ijVsP+1Dt43XxGvSe8eORLQ5zUhMenSpwh8v780mgPi33L5/dsxSoZ?=
 =?us-ascii?Q?7hoOWBi0m4TZwE0O52KS5AeqlYKgGnJJT0fc0tBkksgTNLeSxlRS2H9EIJVR?=
 =?us-ascii?Q?ve95JetMMsSCo6y6ucoYQmMOnJRl6aOfRnQLnFUKtlIkE0kNAf3JklWsHhVF?=
 =?us-ascii?Q?MYNZo30b12X7t/UGLh+io2YXRasjE6GkuNjAtd4xgOEvGh/ZdkG8OLapWmFT?=
 =?us-ascii?Q?XTIupgH5O0q177OMuIVwDtwQEiRSdxQWg2TrnfUY/3br0MChlsXqujfqsyMb?=
 =?us-ascii?Q?VjmUYrT9ilZTEF7+vEVMN8s/6fblDWL8VRqyi1ZgfzjJh0IP/oJ/LeS9xduU?=
 =?us-ascii?Q?/OE1wpKV39lO/DfzRUv8KDOqhJAvJKya0ycw+87zGyQW8ulNSa9AR08gooNe?=
 =?us-ascii?Q?a9K5Vb025mR9E2dc/hk0LZOBRLVSDstRYBTf5uDbDvkiAF1mRR0KvVfpSIwE?=
 =?us-ascii?Q?LJstwsoSZ+aruzORU7As+dX7ywB1ScHJiIaYAznfxk/qvfMwZMkwEZPc4rXX?=
 =?us-ascii?Q?PXFI0pc15ApUbxkL72SvsGofNSdIeRB9rfS9FutFrA6/nI/9DGizn8f6N3vT?=
 =?us-ascii?Q?EL+CB6QelUhO/C/Vnu5LSYJPaQ+9rnvzgVvBCsSXdGvwjfR82a+ir/Pf3Jrc?=
 =?us-ascii?Q?Hw6yeS9Jt0i/WuELXMdvJlYasI9nwxOxw5AZyD7aJoFJQcOAst7nzh0dO1l7?=
 =?us-ascii?Q?pQvExddhvKsBxggW34AAjtQDuw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcdb25b-1576-4c24-1aa0-08d8b97784b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:03:45.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMb1wdt4oea3VJELiRXVOdWrPRqxuzm8VwUfTxlvRniE8K90ZoflTyQk9yQDjld0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2214
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-15_09:2021-01-15,2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 15, 2021 at 11:20:50AM -0500, Johannes Weiner wrote:
> On Wed, Jan 13, 2021 at 03:46:54PM +0100, Michal Hocko wrote:
> > On Tue 12-01-21 11:30:11, Johannes Weiner wrote:
> > > When a value is written to a cgroup's memory.high control file, the
> > > write() context first tries to reclaim the cgroup to size before
> > > putting the limit in place for the workload. Concurrent charges from
> > > the workload can keep such a write() looping in reclaim indefinitely.
> > > 
> > > In the past, a write to memory.high would first put the limit in place
> > > for the workload, then do targeted reclaim until the new limit has
> > > been met - similar to how we do it for memory.max. This wasn't prone
> > > to the described starvation issue. However, this sequence could cause
> > > excessive latencies in the workload, when allocating threads could be
> > > put into long penalty sleeps on the sudden memory.high overage created
> > > by the write(), before that had a chance to work it off.
> > > 
> > > Now that memory_high_write() performs reclaim before enforcing the new
> > > limit, reflect that the cgroup may well fail to converge due to
> > > concurrent workload activity. Bail out of the loop after a few tries.
> > 
> > I can see that you have provided some more details in follow up replies
> > but I do not see any explicit argument why an excessive time for writer
> > is an actual problem. Could you be more specific?
> 
> Our writer isn't necessarily time sensitive, but there is a difference
> between a) the write taking a few seconds to reclaim down the
> requested delta and b) the writer essentially turning into kswapd for
> the workload and busy-spinning inside the kernel indefinitely.
> 
> We've seen the writer stuck in this function for minutes, long after
> the requested delta has been reclaimed, consuming alarming amounts of
> CPU cycles - CPU time that should really be accounted to the workload,
> not the system software performing the write.
> 
> Obviously, we could work around it using timeouts and signals. In
> fact, we may have to until the new kernel is deployed everywhere. But
> this is the definition of an interface change breaking userspace, so
> I'm a bit surprised by your laid-back response.
> 
> > > Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> > > Cc: <stable@vger.kernel.org> # 5.8+
> > 
> > Why is this worth backporting to stable? The behavior is different but I
> > do not think any of them is harmful.
> 
> The referenced patch changed user-visible behavior in a way that is
> causing real production problems for us. From stable-kernel-rules:
> 
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing).
> 
> > > Reported-by: Tejun Heo <tj@kernel.org>
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > I am not against the patch. The existing interface doesn't provide any
> > meaningful feedback to the userspace anyway. User would have to re check
> > to see the result of the operation. So how hard we try is really an
> > implementation detail.
> 
> Yeah, I wish it was a bit more consistent from an interface POV.
> 
> Btw, if you have noticed, Roman's patch to enforce memcg->high *after*
> trying to reclaim went into the tree at the same exact time as Chris's
> series "mm, memcg: reclaim harder before high throttling" (commit
> b3ff92916af3b458712110bb83976a23471c12fa). It's likely they overlap.
> 
> Chris's patch changes memory.high reclaim on the allocation side from
> 
> 	reclaim once, sleep if there is still overage
> 
> to
> 
> 	reclaim the overage as long as you make forward progress;
> 	sleep after 16 no-progress loops if there is still overage
> 
> Roman's patch describes a problem where allocating threads go to sleep
> when memory.high is lowered by a wider step. This is exceedingly
> unlikely after Chris's change.
> 
> Because after Chris's change, memory.high is reclaimed on the
> allocation side as aggressively as memory.max. The only difference is
> that upon failure, one sleeps and the other OOMs.
> 
> If Roman's issue were present after Chris's change, then we'd also see
> premature OOM kills when memory.max is lowered by a large step. And I
> have never seen that happening.
> 
> So I suggest instead of my fix here, we revert Roman's patch instead,
> as it should no longer be needed. Thoughts?

Chris's patch was merged way earlier than mine into the kernel tree which
was used when I observed the problem in the production. So likely it was there.

I think it makes sense to try to reclaim memory first before putting
all processes in the cgroup into reclaim mode. Even without artificial delays
it creates some latency and btw doesn't make the reclaim process more efficient.

What about something like this? Make one optimistic iteration without setting
the high value and then fallback to the old behavior.


@@ -6317,15 +6317,15 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 			continue;
 		}
 
-		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-							 GFP_KERNEL, true);
+		try_to_free_mem_cgroup_pages(memcg, nr_pages - high, GFP_KERNEL,
+					     true);
 
-		if (!reclaimed && !nr_retries--)
+		if (nr_retries == MAX_RECLAIM_RETRIES)
+			page_counter_set_high(&memcg->memory, high);
+		if (!nr_retries--)
 			break;
 	}
 
-	page_counter_set_high(&memcg->memory, high);
-
 	memcg_wb_domain_size_changed(memcg);
 
 	return nbytes;

