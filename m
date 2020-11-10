Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4B42AE0C2
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 21:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgKJUfY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Nov 2020 15:35:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55044 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJUfX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Nov 2020 15:35:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAKXlN0034528;
        Tue, 10 Nov 2020 20:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=s4nyry0mSPgh1FrvXm8VEB2bCAXmh9/aI1iL5kwnE7o=;
 b=MF+5WKq4vr3MUTA6g7wFb5dE9tfejt9KvBDxWLBe5SyR4tn+KB8wIBonc5JTNB7hJwB/
 qrP6eeCzoy7nqQvQ2EcvbNw5p1jd2fBAY36U3SA9WjAPqqnjclHo+NnObpxPLwg9ZUcK
 rBWZSV2ZoV3SRFk8V1O4V8nU6hYuEtDkz9qrBY6u0t/ojtHmhUfYlnojLtc+xUUV28Xc
 feumLPaql28r4xrEnnokxLa5xfFznLWZ9aDVbTLXPL1fm2Kj1MQVPIE7ImtDabENM+ZO
 9FZZNYcRlJyzo2OYOpzyqCoH+NFiAzkORBr36nz6dXSXxL0H/lCxO8FXawwILEN6rq6n gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhkwqss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 20:35:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAKKBw6104737;
        Tue, 10 Nov 2020 20:35:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34p5gxfwve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 20:35:04 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AAKZ1Zm022008;
        Tue, 10 Nov 2020 20:35:01 GMT
Received: from parnassus (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 12:35:00 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Prateek Sood <prsood@codeaurora.org>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: fix race between hotplug work and later CPU
 offline
In-Reply-To: <20201110164504.GL2594@hirez.programming.kicks-ass.net>
References: <20201029181845.415517-1-daniel.m.jordan@oracle.com>
 <20201110164504.GL2594@hirez.programming.kicks-ass.net>
Date:   Tue, 10 Nov 2020 15:34:31 -0500
Message-ID: <87zh3pt0h4.fsf@mr.pineapple.says.hi.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100139
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Thu, Oct 29, 2020 at 02:18:45PM -0400, Daniel Jordan wrote:
>> rebuild_sched_domains_locked() prevented the race during the cgroup2
>> cpuset series up until the Fixes commit changed its check.  Make the
>> check more robust so that it can detect an offline CPU in any exclusive
>> cpuset's effective mask, not just the top one.
>
> *groan*, what a mess...

Ah, the joys of cpu hotplug!

>> I think the right thing to do long-term is make the hotplug work
>> synchronous, fixing the lockdep splats of past attempts, and then take
>> these checks out of rebuild_sched_domains_locked, but this fixes the
>> immediate issue and is small enough for stable.  Open to suggestions.
>> 
>> Prateek, are you planning on picking up your patches again?
>
> Yeah, that might help, but those deadlocks were nasty iirc :/

It might end up being too invasive to be worth it, but I'm being
optimistic for now.

>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 57b5b5d0a5fd..ac3124010b2a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -983,8 +983,10 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>>   */
>>  static void rebuild_sched_domains_locked(void)
>>  {
>> +	struct cgroup_subsys_state *pos_css;
>>  	struct sched_domain_attr *attr;
>>  	cpumask_var_t *doms;
>> +	struct cpuset *cs;
>>  	int ndoms;
>>  
>>  	lockdep_assert_cpus_held();
>> @@ -999,9 +1001,21 @@ static void rebuild_sched_domains_locked(void)
>>  	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
>>  		return;
>
> So you argued above that effective_cpus was stale, I suppose the above
> one works because its an equality test instead of a subset?

Yep, fortunately enough.

> Does that wants a comment?

Ok, I'll change the comments to this absent other ideas.

	/*
	 * If we have raced with CPU hotplug, return early to avoid
	 * passing doms with offlined cpu to partition_sched_domains().
	 * Anyways, cpuset_hotplug_workfn() will rebuild sched domains.
	 *
	 * With no CPUs in any subpartitions, top_cpuset's effective CPUs
	 * should be the same as the active CPUs, so checking only top_cpuset
	 * is enough to detect racing CPU offlines.
	 */
	if (!top_cpuset.nr_subparts_cpus &&
	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
		return;

	/*
	 * With subpartition CPUs, however, the effective CPUs of a partition
	 * root should be only a subset of the active CPUs.  Since a CPU in any
	 * partition root could be offlined, all must be checked.
	 */
	if (top_cpuset.nr_subparts_cpus) {
		rcu_read_lock();
        ...


Thanks for looking.
