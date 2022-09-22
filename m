Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67F75E5ACE
	for <lists+cgroups@lfdr.de>; Thu, 22 Sep 2022 07:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIVFk6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Sep 2022 01:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIVFk5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Sep 2022 01:40:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13AD81B0A;
        Wed, 21 Sep 2022 22:40:54 -0700 (PDT)
X-UUID: 802ff2ee5b574f9095d791aa7211dc99-20220922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=V/4+Moo1S3nQcLY9jDjtjnWEDd9L/Kw2aufNRHGosCA=;
        b=Zo90xoefOKJHvtfEFcDTAqWFMMlSWhYdihn9YUwakBoC7hSj65xFQOnkygZWjRWo+0MaOfGzMIuyKHdO04SqksKYo04Q/Ql+ZbID6f3GpTsr00YT5rq3AD7qAoZiR0Fhzx7za2FPjitpJ6vUJJ8lOcjWUAYbbUvnHd5+FHK+MKU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:93a320cb-2d0a-420e-a931-84fcd3502661,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:93a320cb-2d0a-420e-a931-84fcd3502661,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:696eb1a2-dc04-435c-b19b-71e131a5fc35,B
        ulkID:2209221340524T07RBDH,BulkQuantity:1,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:
        0
X-UUID: 802ff2ee5b574f9095d791aa7211dc99-20220922
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1364894657; Thu, 22 Sep 2022 13:40:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 22 Sep 2022 13:40:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Sep 2022 13:40:47 +0800
Message-ID: <93f4ce9486ec4b856ba0f3bfe956fc9b2d3cb4cf.camel@mediatek.com>
Subject: Re: BUG: HANG_DETECT waiting for migration_cpu_stop() complete
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Waiman Long <longman@redhat.com>,
        ValentinSchneider <vschneid@redhat.com>,
        TejunHeo <tj@kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Jonathan.JMChen@mediatek.com>,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Vincent Donnefort" <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        <cgroups@vger.kernel.org>, <lixiong.liu@mediatek.com>,
        <wenju.xu@mediatek.com>
Date:   Thu, 22 Sep 2022 13:40:47 +0800
In-Reply-To: <20220907000741.2496-1-hdanton@sina.com>
References: <20220907000741.2496-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 2022-09-07 at 08:07 +0800, Hillf Danton wrote:
> On 5 Sep 2022 10:47:36 +0800 Jing-Ting Wu <jing-ting.wu@mediatek.com>
> wrote
> > 
> > We meet the HANG_DETECT happened in T SW version with kernel-5.15.
> > Many tasks have been blocked for a long time.
> > 
> > Root cause:
> > migration_cpu_stop() is not complete due to
> > is_migration_disabled(p) is
> > true, complete is false and complete_all() never get executed.
> > It let other task wait the rwsem.
> 
> See if handing task over to stopper again in case of migration
> disabled
> could survive your tests.
> 
> Hillf
> 
> --- linux-5.15/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2322,9 +2322,7 @@ static int migration_cpu_stop(void *data
>  	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued
> because
>  	 * we're holding p->pi_lock.
>  	 */
> -	if (task_rq(p) == rq) {
> -		if (is_migration_disabled(p))
> -			goto out;
> +	if (task_rq(p) == rq && !is_migration_disabled(p)) {
>  
>  		if (pending) {
>  			p->migration_pending = NULL;

Because Peter have some concern for patch by Waiman.
We add Hillf's patch to our stability test.
But there are side effects after patched.
The warning appear once < two weeks. 

Backtrace as follows:
[name:panic&]WARNING: CPU: 6 PID: 32583 at affine_move_task
pc : affine_move_task
lr : __set_cpus_allowed_ptr_locked
Call trace:
affine_move_task
__set_cpus_allowed_ptr_locked
migrate_enable
__cgroup_bpf_run_filter_skb
ip_finish_output
ip_output


The root cause is when is_migration_disabled(p) is true，the patched
version will set p->migration_pending to NULL by migration_cpu_stop.
And in affine_move_task will raise a WARN_ON_ONCE(!pending).

Kernel-5.15/kernel/sched/core.c:
static int affine_move_task(struct rq *rq, struct task_struct *p,
struct rq_flags *rf, int dest_cpu, unsigned int flags) {
...
	If (WARN_ON_ONCE(!pending)) {
 	  Task_rq_unlock(rq,p,fr);
  	  return -EINVAL;
	}
...
}

But the tasks have not been migrated to the new affinity CPU, so there
should be pending tasks to be processed, so p->migration_pending should
not be NULL.



Without patch:
When is_migration_disabled is true, then goto out and not set p-
>migration_pending to NULL.

static int migration_cpu_stop(void *data) {
...
	If (task_rq(p) == rq) {
        	     if (is_migration_disabled(p))
                	           goto out;
	}
...
}


With patch:
When is_migration_disabled is true and pending is true, goto else if
flow. Because p->cpus_ptr not updated when migrate_disable, so this
condition is always true and p->migration_pending will set to NULL.

static int migration_cpu_stop(void *data) {
...
	If (task_rq(p) == rq && !is_migration_disabled(p) ) {
 	  ...
	} else if (pending) {
	  ...
	  If (cpumask_test_cpu(task_cpu(p), p-> cpus_ ptr)) { 
        	p->migration_pending = NULL;
      		 complete = true;
      		 goto out;
	}
...
}






Best regards,
Jing-Ting Wu


