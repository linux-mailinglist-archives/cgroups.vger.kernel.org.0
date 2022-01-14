Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE048E8FB
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 12:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiANLNQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 06:13:16 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42263 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232396AbiANLNQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 06:13:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V1otGzS_1642158792;
Received: from 30.21.164.113(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0V1otGzS_1642158792)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jan 2022 19:13:13 +0800
Message-ID: <1cca28c3-c84d-415e-9b33-6687e4ff2cbb@linux.alibaba.com>
Date:   Fri, 14 Jan 2022 19:13:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v2 3/3] sched/core: Force idle accounting per cgroup
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, joshdon@google.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1641894961-9241-4-git-send-email-CruzZhao@linux.alibaba.com>
 <Yd89Lv3VuaaFVm4h@slm.duckdns.org>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <Yd89Lv3VuaaFVm4h@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/1/13 上午4:42, Tejun Heo 写道:
> Hello,
> 
> On Tue, Jan 11, 2022 at 05:56:01PM +0800, Cruz Zhao wrote:
>> +#ifdef CONFIG_SCHED_CORE
>> +void cpuacct_account_forceidle(int cpu, struct task_struct *tsk, u64 cputime)
>> +{
>> +	struct cpuacct *ca;
>> +	u64 *fi;
>> +
>> +	rcu_read_lock();
>> +	/*
>> +	 * We have hold rq->core->__lock here, which protects ca->forceidle
>> +	 * percpu.
>> +	 */
>> +	for (ca = task_ca(tsk); ca; ca = parent_ca(ca)) {
>> +		fi = per_cpu_ptr(ca->forceidle, cpu);
>> +		*fi += cputime;
>> +	}
> 
> Please don't do this. Use rstat and integrate it with other stats.
> 
> Thanks.
> 

Thanks for suggestions, I'll try to do this using rstat. BTW, is it ok
to integrate it with cgroup_base_stat?

Best,
Cruz Zhao
