Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C6659BEE
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2019 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfF1Mqb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jun 2019 08:46:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42754 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfF1Mqa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jun 2019 08:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vgfmsINpuE2ZU4+ZZYzkWKZ//l3gJpXtEC1mQPLq5So=; b=xeSn78dA2gJy8x/E56SZ6JNSh
        kvo8AgJJyguyKxBgDpp0JRC7yy+3DlWcrWylwFUHlg6pXwg9TCdqAxqJw8PF21Q7+KPU/0zaQDoBG
        Lbm1wLXUZQqL8JdNGTn3ZPqHMDdmZeVuGYj9TxBrPjBQz3ThZrM39sGLHIFs3PASN+2cYZx/JX2u9
        bgJSY4mb0elp39cEyEGzrDDm9q9BRMerp4gcSAtOwI+HvrvcmdvW8flkdwM05c4Wi6N6Oud2cFWfT
        atPqsRnydlmqiMPMEXjefNdc6+OsvC8jKCJDRqCyYw2VICkIFYSfjDhfhHpdxeeTkMXAM4d4YXwlB
        Sn/Z+gohA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgqGI-0000a0-Qc; Fri, 28 Jun 2019 12:45:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45B17201F4619; Fri, 28 Jun 2019 14:45:53 +0200 (CEST)
Date:   Fri, 28 Jun 2019 14:45:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v8 5/8] cgroup/cpuset: convert cpuset_mutex to
 percpu_rwsem
Message-ID: <20190628124553.GT3419@hirez.programming.kicks-ass.net>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-6-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628080618.522-6-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 28, 2019 at 10:06:15AM +0200, Juri Lelli wrote:
> @@ -2154,7 +2154,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
>  	cs = css_cs(css);
>  
> -	mutex_lock(&cpuset_mutex);
> +	percpu_down_read(&cpuset_rwsem);
>  
>  	/* allow moving tasks into an empty cpuset if on default hierarchy */
>  	ret = -ENOSPC;
> @@ -2178,7 +2178,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	cs->attach_in_progress++;
>  	ret = 0;
>  out_unlock:
> -	mutex_unlock(&cpuset_mutex);
> +	percpu_up_read(&cpuset_rwsem);
>  	return ret;
>  }
>  
> @@ -2188,9 +2188,9 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>  
>  	cgroup_taskset_first(tset, &css);
>  
> -	mutex_lock(&cpuset_mutex);
> +	percpu_down_read(&cpuset_rwsem);
>  	css_cs(css)->attach_in_progress--;
> -	mutex_unlock(&cpuset_mutex);
> +	percpu_up_read(&cpuset_rwsem);
>  }

These are the only percpu_down_read()s introduced in this patch; are we
sure this is correct? Specifically, what serializes
->attach_in_progress?
