Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C597C48CD2F
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 21:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbiALUm3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 15:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiALUmZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 15:42:25 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68BC06173F;
        Wed, 12 Jan 2022 12:42:25 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id l15so5949281pls.7;
        Wed, 12 Jan 2022 12:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HO7qMaYrtwZh1fXZ2JialerphvW3Ld7mXY4ozQ74kp8=;
        b=T//gm9B2hHMRxudRJ5GrIEq6vQlBYHNIMACX99yWLgykrZKNX5UGa2PRk/IKsheR9g
         SWsPtR+wGtZy0Blm7u2k70b9UNWVcT/RT09nQceitwss3Y5RfmnBn6zAjT7l60cTCdXt
         iZQrIaOMIfkVahpM0KMcnLkUCH5L+MTWJZMExT952E4p5H3TMJIEzmpAYFQgCLChvT+z
         KgOhRQ+jgbOZe3oAFhAcNabmstwsLyXc5p1cyFMrEsK4i1iYf4DUxdzvsHp03iqY0jG4
         OucI73fRpoq/TsjOvrQBp6OGrF4X+l4m5tzLK6hHSeqkuXV2AWYjJRZLrmeGcWRZz98E
         JINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HO7qMaYrtwZh1fXZ2JialerphvW3Ld7mXY4ozQ74kp8=;
        b=nzDUJVcOK3Tlxk+yaluscdF7yMBU15Gf7sl3G5JJAPFJ5Y7HYz/lElzhUDO14ghn4a
         JLiVRMMk9SEWdU6jDul2e+kPWfbqmC4oF/PAQefy05IY5KiYpzjNkKkz0OUi101OAR2R
         ahq1sBTZueELoy1UamyWJ1Y3Cw5W2wm8MngjUl3rXXHDq66qmNm4kS+SdSKB+Odut+ZW
         KpSvwj7gB5vvqKgrfVJ/c2RNYqsQculHt2mH1VcxVkoBOxjXdyIitcO5agTOwusyRlIZ
         2VrUNrPypBULVfakEuh3kBH4nJBOxjsobRspVKPMACdEfds7+aJmshzTIOMBMkyLTVzb
         5kqg==
X-Gm-Message-State: AOAM5301V+CjJiPDL+My0IhlSNzk71hHc6yXnTVGNwISqnuupibrcE0W
        czhXSwFIsQYs55RJYRxRlncix4uskn+WWQ==
X-Google-Smtp-Source: ABdhPJzLS6XwzXazPOo/ws/RqiqAsQqeHOGmR3WO1ZRJ2o73zL9HFfGixxuVnhAWWPfUUYnr0Q8Puw==
X-Received: by 2002:a63:b245:: with SMTP id t5mr1194847pgo.388.1642020144614;
        Wed, 12 Jan 2022 12:42:24 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s35sm422950pfw.193.2022.01.12.12.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:42:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 10:42:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, joshdon@google.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sched/core: Force idle accounting per cgroup
Message-ID: <Yd89Lv3VuaaFVm4h@slm.duckdns.org>
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1641894961-9241-4-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641894961-9241-4-git-send-email-CruzZhao@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Jan 11, 2022 at 05:56:01PM +0800, Cruz Zhao wrote:
> +#ifdef CONFIG_SCHED_CORE
> +void cpuacct_account_forceidle(int cpu, struct task_struct *tsk, u64 cputime)
> +{
> +	struct cpuacct *ca;
> +	u64 *fi;
> +
> +	rcu_read_lock();
> +	/*
> +	 * We have hold rq->core->__lock here, which protects ca->forceidle
> +	 * percpu.
> +	 */
> +	for (ca = task_ca(tsk); ca; ca = parent_ca(ca)) {
> +		fi = per_cpu_ptr(ca->forceidle, cpu);
> +		*fi += cputime;
> +	}

Please don't do this. Use rstat and integrate it with other stats.

Thanks.

-- 
tejun
